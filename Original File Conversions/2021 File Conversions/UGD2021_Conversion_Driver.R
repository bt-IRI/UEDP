# Author: UEDP Team @ International Republican Institute
# Last modified: 3/8/21

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
    
    # Dist Name/No Extractions
    Dist_Const <- unique(str_squish((stri_trim(Dist_Const_read[which(is.na(stri_extract_all(Dist_Const_read, regex = "CONSTITUENCY:"))==FALSE)]))))
    Dist_Name_No <- str_squish(str_trim(substr(Dist_Const[1], stri_locate_first(Dist_Const, regex = "DISTRICT:")[,2][1]+1, stri_locate_first(Dist_Const, regex = "CONSTITUENCY:")[,1][1]-1)))
    
    #******************************************************
    # PDF Table Extraction & Dataframe Assembly
    #******************************************************
    
    # Table Extractions
    PDF_geos <- extract_tables(PDF_doc, method = "stream", guess = FALSE, 
                               area = list(c(32.08342,  13.13260, 564.55045, 830.93514)), 
                               columns = list(c(95.29964, 209.81937, 248.2596, 289.9031, 332.3475, 371.5885, 414.8337, 457.2781, 498.9216, 541.3660, 582.2087, 623.8522, 666.2966, 707.9402, 746.3804, 784.8205)))
    
    
    PDF.df <- do.call(rbind.data.frame, PDF_geos[which(lapply(PDF_geos, ncol)==17)])
    
    
    # Add subcounty data
    
    Subcounty_Name_No <- c()
    for (i in 1:nrow(PDF.df)) {
      if(is.na(stri_extract_all(PDF.df[i,2], regex = "Sub-county:"))) {
        Subcounty_Name_No <- append(Subcounty_Name_No, "", after = length(Subcounty_Name_No))
      } else {
        Subcounty_Name_No <- append(Subcounty_Name_No, paste(as.character(PDF.df[i,2]),
                                                             as.character(PDF.df[i,3]),
                                                             as.character(PDF.df[i,4]),
                                                             as.character(PDF.df[i,5]),
                                                             sep = ""),
                                    after = length(Subcounty_Name_No))
      }
    }
    
    PDF.df <- cbind.data.frame(Subcounty_Name_No, PDF.df)
    
    # Add constituency data
    
    Const_Name_No <- c()
    for (i in 1:nrow(PDF.df)) {
      if(is.na(stri_extract_all(PDF.df[i,2], regex = "DISTRICT:"))) {
        Const_Name_No <- append(Const_Name_No, "", after = length(Const_Name_No))
      } else {
        Const_Name_No <- append(Const_Name_No, paste(as.character(PDF.df[i,9]),
                                                     paste(
                                                       as.character(PDF.df[i,10]),
                                                       as.character(PDF.df[i,11]),
                                                       as.character(PDF.df[i,12]),
                                                       as.character(PDF.df[i,13]),
                                                       as.character(PDF.df[i,14]),
                                                       as.character(PDF.df[i,15]),
                                                       as.character(PDF.df[i,16]),
                                                       as.character(PDF.df[i,17]),
                                                       as.character(PDF.df[i,18]),
                                                       sep = ""),
                                                     sep = " "),
                                after = length(Const_Name_No))
      }
    }
    
    PDF.df <- cbind.data.frame(Const_Name_No, PDF.df)
    
    
    
    # Fill in Const/subcounty columns...
    PDF.df[,1] <- as.character(PDF.df[,1])
    PDF.df[,2] <- as.character(PDF.df[,2])
    
    Const_Name <- c(" ")
    Subty_Name <- c(" ")
    for (i in 1:nrow(PDF.df)) {
      ifelse(isFALSE(PDF.df[i,1]==""),
             Const_Name <- PDF.df[i,1],
             PDF.df[i,1] <- Const_Name)
      ifelse(isFALSE(PDF.df[i,2]==""),
             Subty_Name <- PDF.df[i,2],
             PDF.df[i,2] <- Subty_Name)
    }
    
    # Remove original headers & junk rows
    PDF.df <- PDF.df[-c(which(PDF.df[,19]=="")),]
    PDF.df <- PDF.df[-c(which(PDF.df[,19]=="Total" | PDF.df[,19]=="Votes")),]
    
    # Set parish and station columns to character before wrap corrections
    PDF.df[,3] <- as.character(PDF.df[,3])
    PDF.df[,4] <- as.character(PDF.df[,4])
    
    # Fix wrapped station and parish names
    for (i in 1:(nrow(PDF.df)-1)) {
      if(PDF.df[i+1,5]=="" & isFALSE(PDF.df[i+1,4]=="") & isFALSE(PDF.df[i,4]=="")) {
        PDF.df[i,4] <- stri_trim(paste(PDF.df[i,4], PDF.df[i+1,4], sep = " "))
      }
      if(PDF.df[i+1,5]=="" & isFALSE(PDF.df[i+1,3]=="") & isFALSE(PDF.df[i,3]=="")) {
        PDF.df[i,3] <- stri_trim(paste(PDF.df[i,3], PDF.df[i+1,3], sep = " "))
      }
    }
    
    # Assemble district data
    Dist_Name_No_Array <- rep(Dist_Name_No, nrow(PDF.df))
    PDF.df <- cbind.data.frame(Dist_Name_No_Array, PDF.df)
    
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
    
    PDF.df[,3] <- str_remove(PDF.df[,3], "Sub-county: ")
    
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



#*****************************************
# Code to convert district tally sheet
#*****************************************

Convert_2021_DistTallySheet = function(DistTallySheet_File) {
  PDF_doc = DistTallySheet_File
  
  # Read first page separately due to different dimensions
  PDF_geos1 <- extract_tables(PDF_doc, pages = 1, method = "stream", guess = FALSE, 
                              area = list(c(145.74251,  15.95636, 560.36827, 830.39986)), 
                              columns = list(c(95.45228, 133.64150, 182.7419, 231.0630, 280.1634, 329.2638, 376.8055, 426.6853, 474.6166, 523.3274, 572.427, 621.5282, 669.8493, 708.0385, 747.0071, 785.1963)))
  
  # Read remaining pages
  PDF_geos2_6 <- extract_tables(PDF_doc, pages = 2:6, method = "stream", guess = FALSE, 
                                area = list(c(28.90693, 16.39104, 562.43532, 829.38671)), 
                                columns = list(c(95.45228, 133.64150, 182.7419, 231.0630, 280.1634, 329.2638, 376.8055, 426.6853, 474.6166, 523.3274, 572.427, 621.5282, 669.8493, 708.0385, 747.0071, 785.1963)))
  
  
  PDF_geos1 <- do.call(rbind.data.frame, PDF_geos1[which(lapply(PDF_geos1, ncol)==17)])
  PDF_geos2_6 <- do.call(rbind.data.frame, PDF_geos2_6[which(lapply(PDF_geos2_6, ncol)==17)])
  
  PDF.df <- rbind(PDF_geos1, PDF_geos2_6)
  
  
  # Remove junk header rows and eliminate district factor
  PDF.df <- PDF.df[-c(1:4),]
  
  PDF.df[,1] <- as.character(PDF.df[,1])
  PDF.df[,2] <- as.character(PDF.df[,2])
  PDF.df[,17] <- as.character(PDF.df[,17])
  
  for (i in 1:(nrow(PDF.df)-1)) {
    if(PDF.df[i+1,2]=="" & isFALSE(PDF.df[i+1,1]=="")) {
      PDF.df[i,1] <- stri_trim(paste(PDF.df[i,1],PDF.df[i+1,1], sep = " "))
    }
    PDF.df[i,17] <- stri_trim(paste(PDF.df[i,17],PDF.df[i+1,17], sep = ""))
  }
  
  PDF.df <- PDF.df[-c(which(PDF.df[,2]=="")),]
  
  for (i in 2:16) {
    PDF.df[,i] <- as.numeric(as.character(PDF.df[,i]))
  }
  
  colnames(PDF.df) <- c("District","Reg. Voters","Amuriat Oboi Patrick", "Kabuleta Kiiza Joseph", "Kalembe Nancy Linda", "Katumba John", "Kyagulanyi Ssentamu Robert",
                        "Mao Norbert", "Mayambala Willy", "Mugisha Muntu Gregg", "Mwesigye Fred", "Tumukunde Henry Kakurugu", "Yoweri Museveni Tibuhaburwa Kaguta",
                        "Valid Votes", "Invalid Votes", "Total Votes","Received Station")
  return(PDF.df)
}


#*****************************************
# Code to convert reg. voters by station
#*****************************************
Convert_2021_VoterCountbyStations = function(VoterCountbyStations_file) {
  PDF_doc = VoterCountbyStations_file
  
  PDF_pgs <- pdf_info(PDF_doc)$pages
  
  PDF_geo_list <- list()
  for (i in 1:PDF_pgs) {
    PDF_geos <- extract_tables(PDF_doc, pages = i, method = "stream", guess = FALSE, 
                               area = list(c(114.54974, 12.69893, 524.68586, 756.07070 )), 
                               columns = list(c(41.53663, 93.60470, 123.2434, 206.5523, 232.9869, 317.8979, 348.3377, 434.0497, 462.0864, 558.2120, 574.2330, 693.5890)))
    PDF_geo_list <- append(PDF_geo_list, PDF_geos, after = length(PDF_geo_list))
    print(paste("Extracting page... ", i, "/", PDF_pgs, sep = ""))
  }
  
  PDF.df <- do.call(rbind.data.frame, PDF_geo_list[which(lapply(PDF_geo_list, ncol)==13)])
  
  # Delete final total row
  PDF.df <- PDF.df[-c(nrow(PDF.df)),]
  
  # Change factors to characters
  for (i in 1:ncol(PDF.df)) {
    PDF.df[,i] <- as.character(PDF.df[,i])
  }
  
  # Fix wrapped location labels
  for (i in 1:(nrow(PDF.df)-1)) {
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,2]=="") {
      PDF.df[i,2] <- paste(PDF.df[i-1,2], PDF.df[i+1,2], sep = "")
    }
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,4]=="") {
      PDF.df[i,4] <- paste(PDF.df[i-1,4], PDF.df[i+1,4], sep = " ")
    }
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,6]=="") {
      PDF.df[i,6] <- paste(PDF.df[i-1,6], PDF.df[i+1,6], sep = " ")
    }
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,8]=="") {
      PDF.df[i,8] <- paste(PDF.df[i-1,8], PDF.df[i+1,8], sep = " ")
    }
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,10]=="") {
      PDF.df[i,10] <- paste(PDF.df[i-1,10], PDF.df[i+1,10], sep = " ")
    }
    if (isFALSE(PDF.df[i,1]=="") & PDF.df[i,12]=="") {
      PDF.df[i,12] <- paste(PDF.df[i-1,12], PDF.df[i+1,12], sep = " ")
    }
  }
  
  # Remove junk wrapped rows
  PDF.df <- PDF.df[-c(which(PDF.df[,1]=="")),]
  
  # Set reg. voters numeric
  PDF.df[,13] <- as.numeric(PDF.df[,13])
  
  # Set column names
  colnames(PDF.df) <- c("DISTRICT CODE", "DISTRICT NAME", 
                        "COUNTY CODE", "COUNTY NAME", 
                        "EA CODE", "ELECTORAL AREA NAME",
                        "SUB COUNTY CODE", "SUB COUNTY NAME",
                        "PARISH CODE", "PARISH NAME",
                        "PS CODE", "POLLING STATION NAME", "VOTER COUNT")
  
  return(PDF.df)
}

