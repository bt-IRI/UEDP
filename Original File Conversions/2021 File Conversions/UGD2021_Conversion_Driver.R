Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_261') 
options(java.parameters = "- Xmx2000m")
library(rJava)
library(tabulizer)
library(pdftools)
library(stringi)
library(stringr)

#****************************************
# Code to convert station results PDFs
#****************************************

Convert_2021_StationResults = function(PDF_data_list, PDF_links, start, stop) {
  for (u in start:stop) {
    PDF_doc <- PDF_links[u, 2]
    #******************************************************
    # Initial Scan of PDF for Dist./Const./Subcounty Names
    #******************************************************
    Dist_Const_read <- pdf_text(PDF_doc)
    Dist_Const_read <- str_split(Dist_Const_read, "\r\n")
    Dist_Const_read <- unlist(Dist_Const_read)
    
    # Need to double-check that this works with PDFs describing multiple constitutencies...
    Dist_Const <- unique(str_squish((stri_trim(Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "CONSTITUENCY:"))==FALSE)]))))
    #Dist_Name_No <- unique(stri_trim(substr(Dist_Const, stri_locate_last(Dist_Const, regex = "DISTRICT:")[,2][2]+1, stri_locate_first(Dist_Const, regex = "CONSTITUENCY:")[,1][1]-1)))
    Dist_Name_No <- str_squish(str_trim(substr(Dist_Const[1], stri_locate_first(Dist_Const, regex = "DISTRICT:")[,2][1]+1, stri_locate_first(Dist_Const, regex = "CONSTITUENCY:")[,1][1]-1)))
    
    # Consituence Name/No Extractions
    Const_Name_No <- stri_locate_last(Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "CONSTITUENCY:"))==FALSE)], regex = "CONSTITUENCY:")[,2]
    Const_Name_No <- unique(str_squish(stri_trim(substr(
      Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "CONSTITUENCY:"))==FALSE)], 
      Const_Name_No+1, 
      nchar(Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "CONSTITUENCY:"))==FALSE)])))))
    
    # Subcounty Name/No Extractions
    Subcounty_Name_No <- unique(str_squish((stri_trim(Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "Sub-county:"))==FALSE)]))))
    Subcounty_Name_No <- stri_trim(substr(Subcounty_Name_No, stri_locate_last(Subcounty_Name_No, regex = "Sub-county:")[,2]+1, nchar(Subcounty_Name_No)))
    
    
    #******************************************************
    # PDF Table Extraction & Dataframe Assembly
    #******************************************************
    
    # Table Extractions
    PDF_geos <- extract_tables(PDF_doc, method = "stream", guess = FALSE, 
                               area = list(c(32.08342,  13.13260, 564.55045, 830.93514)), 
                               columns = list(c(95.29964, 209.81937, 248.2596, 289.9031, 332.3475, 371.5885, 414.8337, 457.2781, 498.9216, 541.3660, 582.2087, 623.8522, 666.2966, 707.9402, 746.3804, 784.8205)))
    
    
    PDF.df <- do.call(rbind.data.frame, PDF_geos[which(lapply(PDF_geos, ncol)==17)])
    
    
    # Remove original headers & junk rows
    PDF.df <- PDF.df[-c(which(PDF.df[,17]=="")),]
    PDF.df <- PDF.df[-c(which(PDF.df[,17]=="Total" | PDF.df[,17]=="Votes")),]
    
    # Set parish and station columns to character before wrap corrections
    PDF.df[,1] <- as.character(PDF.df[,1])
    PDF.df[,2] <- as.character(PDF.df[,2])
    
    # Fix wrapped station and parish names
    for (i in 1:(nrow(PDF.df)-1)) {
      if(PDF.df[i+1,3]=="" & isFALSE(PDF.df[i+1,2]=="") & isFALSE(PDF.df[i,2]=="")) {
        PDF.df[i,2] <- stri_trim(paste(PDF.df[i,2], PDF.df[i+1,2], sep = " "))
      }
      if(PDF.df[i+1,3]=="" & isFALSE(PDF.df[i+1,1]=="") & isFALSE(PDF.df[i,1]=="")) {
        PDF.df[i,1] <- stri_trim(paste(PDF.df[i,1], PDF.df[i+1,1], sep = " "))
      }
    }
    
    
    
    # Assemble subcounty data
    Subcounty_Indices <- which(is.na(stri_extract(PDF.df[,2], regex = "Sub-county Total"))==FALSE)
    
    Index_start = 1
    Subcounty_Name_No_Array <- c()
    for (i in seq_along(Subcounty_Indices)) {
      Subcounty_Name_No_Array <- append(Subcounty_Name_No_Array, rep(Subcounty_Name_No[i], length(Index_start:Subcounty_Indices[i])), after = length(Subcounty_Name_No_Array))
      Index_start = Subcounty_Indices[i]+1
    }
    
    Subcounty_Name_No_Array <- append(Subcounty_Name_No_Array, rep(Subcounty_Name_No[length(Subcounty_Name_No)], nrow(PDF.df)-length(Subcounty_Name_No_Array)), after = length(Subcounty_Name_No_Array))
    
    
    # Assemble constituency data
    Const_Indices <- which(is.na(stri_extract(PDF.df[,2], regex = "Constituency Total"))==FALSE)
    
    Index_start = 1
    Const_Name_No_Array <- c()
    for (i in seq_along(Const_Indices)) {
      Const_Name_No_Array <- append(Const_Name_No_Array, rep(Const_Name_No[i], length(Index_start:Const_Indices[i])), after = length(Const_Name_No_Array))
      Index_start = Const_Indices[i]+1
    }
    
    Const_Name_No_Array <- append(Const_Name_No_Array, rep(Const_Name_No[length(Const_Name_No)], nrow(PDF.df)-length(Const_Name_No_Array)), after = length(Const_Name_No_Array))
    
    
    # Assemble district data
    Dist_Name_No_Array <- rep(Dist_Name_No, nrow(PDF.df))
    
    # Bind subcounty, constituency, and district data
    PDF.df <- cbind.data.frame(Subcounty_Name_No_Array, PDF.df)
    PDF.df <- cbind.data.frame(Const_Name_No_Array, PDF.df)
    PDF.df <- cbind.data.frame(Dist_Name_No, PDF.df)
    
    
    # Remove percentage Rows and non-station-level total rows
    PDF.df <- PDF.df[which(
      is.na(stri_extract(PDF.df[,7], regex = "%"))==TRUE & 
        is.na(stri_extract(PDF.df[,5], regex = "Parish Total"))==TRUE &
        is.na(stri_extract(PDF.df[,5], regex = "Sub-county Total"))==TRUE &
        is.na(stri_extract(PDF.df[,5], regex = "Constituency Total"))==TRUE &
        is.na(stri_extract(PDF.df[,5], regex = "District Total"))==TRUE),]
    
    # Add metadata
    PDF_created <- rep(pdf_info(PDF_doc)$created, nrow(PDF.df))
    PDF_modifed <- rep(pdf_info(PDF_doc)$modified, nrow(PDF.df))
    
    PDF.df <- cbind.data.frame(PDF.df, PDF_created)
    PDF.df <- cbind.data.frame(PDF.df, PDF_modifed)
    
    # Add column names
    colnames(PDF.df) <- c("District", "Constituency", "Subcounty", "Parish", "Polling Station","Reg.Voters",
                          "Amuriat Oboi Patrick", "Kabuleta Kiiza Joseph", "Kalembe Nancy Linda", "Katumba John", "Kyagulanyi Ssentamu Robert",
                          "Mao Norbert", "Mayambala Willy", "Mugisha Muntu Gregg", "Mwesigye Fred", "Tumukunde Henry Kakurugu", "Yoweri Museveni Tibuhaburwa Kaguta",
                          "Valid Votes", "Invalid Votes", "Total Votes","PDF_created","PDF_modified")
    
    # Fill parish names
    for (i in 1:nrow(PDF.df)) {
      ifelse(isFALSE(PDF.df[i,4]==""),
             Par_Name <- PDF.df[i,4],
             PDF.df[i,4] <- Par_Name)
    }
    
    # Format variables
    for (i in 1:5) {
      PDF.df[i] <- as.character(PDF.df[,i])
    }
    
    for (i in 6:20) {
      PDF.df[i] <- as.numeric(as.character(PDF.df[,i]))
    }
    PDF_data_list <- append(PDF_data_list, list(PDF.df), after = length(PDF_data_list))
    print(u)
  }
  return(PDF_data_list)
}



#*****************************************
# Code to convert nullified stations PDF
#*****************************************
Convert_2021_NullStations = function(NullStationsFile) {
  PDF_doc = NullStationsFile
  PDF_geos <- extract_tables(PDF_doc, method = "stream", guess = FALSE, 
                             area = list(c(82.73559,  16.38963, 574.28231, 745.19288)), 
                             columns = list(c(45.59365, 152.16885, 269.24010, 400.84433, 527.60423, 681.00793)))
  
  
  PDF.df <- do.call(rbind.data.frame, PDF_geos[which(lapply(PDF_geos, ncol)==7)])
  # Initial cleaning...
  PDF.df <- PDF.df[-c(1:2, nrow(PDF.df)),]
  PDF.df <- PDF.df[-c(which(PDF.df[,7]=="VOTERS" | PDF.df[,1]=="No.")),]
  # Set parish and station columns to character before wrap corrections
  PDF.df[,1] <- as.character(PDF.df[,1])
  PDF.df[,2] <- as.character(PDF.df[,2])
  PDF.df[,3] <- as.character(PDF.df[,3])
  PDF.df[,4] <- as.character(PDF.df[,4])
  PDF.df[,5] <- as.character(PDF.df[,5])
  PDF.df[,6] <- as.character(PDF.df[,6])
  PDF.df[,7] <- as.character(PDF.df[,7])
  # Fix wrapped station and parish names
  for (i in 1:(nrow(PDF.df)-1)) {
    if(PDF.df[i,7]=="" & isFALSE(PDF.df[i+1,7]=="")) {
      PDF.df[i+1,1] <- stri_trim(paste(PDF.df[i,1],PDF.df[i+1,1], sep = " "))
      PDF.df[i+1,2] <- stri_trim(paste(PDF.df[i,2],PDF.df[i+1,2], sep = " "))
      PDF.df[i+1,3] <- stri_trim(paste(PDF.df[i,3],PDF.df[i+1,3], sep = " "))
      PDF.df[i+1,4] <- stri_trim(paste(PDF.df[i,4],PDF.df[i+1,4], sep = " "))
      PDF.df[i+1,5] <- stri_trim(paste(PDF.df[i,5],PDF.df[i+1,5], sep = " "))
      PDF.df[i+1,6] <- stri_trim(paste(PDF.df[i,6],PDF.df[i+1,6], sep = " "))
    }
  }
  # Remove rows with wrap errors
  PDF.df <- PDF.df[-c(which(PDF.df[,7]=="")),]
  # Remove comma from Voters column
  PDF.df[,7] <- str_remove(PDF.df[,7], ",")
  # No. and Voters columns to numeric
  PDF.df[,1] <- as.numeric(PDF.df[,1])
  PDF.df[,7] <- as.numeric(PDF.df[,7])
  # Relabel columns
  colnames(PDF.df) <- c("No.","District","Constituency","Scounty","Parish","POLLING STATION","VOTERS")
  return(PDF.df)
}