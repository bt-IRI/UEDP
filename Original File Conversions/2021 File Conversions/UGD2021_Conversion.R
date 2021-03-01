# Author: UEDP Team @ International Republican Institute
# Last modified: 3/1/21

#****************************************************************************
# 1. PDF FILE DOWNLOADS & LOOKUP DATAFRAME FOR CONVERSION
# 2. STATION PDF FILES CONVERSION
# 3. NULLIFIED STATIONS PDF FILE CONVERSION
# 4. DISTRICT TALLY SHEET PDF CONVERSION
# 5. VOTER COUNT BY STATIONS PDF CONVERSION

#**********************************
# 2021 Station Results downloads:
#**********************************
library(stringi)
EC_html <- readLines(con = "https://www.ec.or.ug/2021-presidential-results-tally-sheets-district")


EC_html <- EC_html[which(is.na(unlist(stri_locate_last(EC_html, regex = ".pdf"))[,2])==FALSE & is.na(unlist(stri_locate_last(EC_html, regex = "ecresults/2021/"))[,2])==FALSE)]

EC_html <- cbind.data.frame(
  paste("https://www.ec.or.ug/", substr(EC_html, stri_locate_last(EC_html, regex = "ecresults")[,1], stri_locate_last(EC_html, regex = ".pdf")[,2]), sep = ""),
  substr(EC_html, stri_locate_last(EC_html, regex = "/2021/")[,2]+1, stri_locate_last(EC_html, regex = ".pdf")[,2])
)

colnames(EC_html) <- c("EC_link", "PDF_name")
EC_html[,1] <- as.character(EC_html[,1])
EC_html[,2] <- as.character(EC_html[,2])

# Optional write for table with links/file names. Not required for this conversion code...

#write.csv(EC_html, "UGD_2021_Station_Results_Links.csv")


for (i in 1:nrow(EC_html)) {
  download.file(EC_html[i,1], EC_html[i,2], mode = "wb")
}


#*************************************************
# Other 2021 file downloads:
#   1. Nullified Polling Stations
#   2. District-level Summary
#   3. Polling Station Registration Statistics
#*************************************************
download.file("https://www.ec.or.ug/ecresults/2021/NullifiedPollingStationsPresidential2021",
              "NullifiedPollingStationsPresidential2021.pdf",
              mode = "wb")

download.file("https://www.ec.or.ug/ecresults/2021/District_Summary_PRESIDENT_FINAL_2021.pdf",
              "District_Summary_PRESIDENT_FINAL_2021.pdf",
              mode = "wb")

download.file("https://www.ec.or.ug/sites/default/files/docs/Voter%20Count%20by%20Polling%20Stations%202021.pdf",
              "Voter_Count_by_Polling_Stations_2021.pdf",
              mode = "wb")

#****************************************************************************










#****************************************************************************
# 2. STATION PDF FILES CONVERSION

source("UGD2021_Conversion_Driver.R")

#**********************************
# Notes on Driver:
#
# Load the driver .R file for Extracting data from the downloaded PDF files.
#
# The conversion driver requires the following packages: tabulizer, rJava, pdftools, stringi, stringr.
#
# The driver file requires a machine with Java installed and the driver specifies the location of Java as:
#
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_261') 
#options(java.parameters = "- Xmx2000m")
#
# If this is this is not correct for your machine, please edit the 'Sys.setenv' location accordingly.
#**********************************


#**********************************
# PDF Data Extraction:
#**********************************
# THESE CONVERSION WILL TAKE A WHILE!!! Tabulizer's extraction algorithms need to analyze the structure of each PDF.
# The numebr of each PDF in the list of files is printed when conversion is completed. (1-146)

# Convert first 50... chunks of conversions can be changed as needed.
# Tabulizer tends to get overloaded and crash if too many PDFs are loaded at once, so recommend splitting files into chunks.
# If Tabulizer crashes, try shrinking the start/stop size of each conversion chunk... this seems to be a memory issue. 
PDF_data_list <- list()
PDF_data_list <- Convert_2021_StationResults(PDF_data_list = PDF_data_list, 
                                             PDF_links = EC_html,
                                             start = 1,
                                             stop = 50)


Processed_1_50.df <- do.call(rbind.data.frame, PDF_data_list)

# Convert 51-146... chunks of conversions can be changed as needed. Same comment on overloading Tabulizer applies. Code below assumes two chunks of conversion were done.
PDF_data_list <- list()
PDF_data_list <- Convert_2021_StationResults(PDF_data_list = PDF_data_list, 
                                             PDF_links = EC_html,
                                             start = 51,
                                             stop = 146)

Processed_51_146.df <- do.call(rbind.data.frame, PDF_data_list)

#**********************************
# Converted data assembly/cleaning:
#**********************************
Processed.df <- rbind(Processed_1_50.df, Processed_51_146.df)
rownames(Processed.df) <- c(1:nrow(Processed.df))

# Correct for one error on Reg.Voter in Wakiso at "KAWEMPE MAJAANI FACTORY (NAM - Z)"
Processed.df[33520,6] <- 1037

# WRITE THE CONVERTED DATASET AS .csv
write.csv(Processed.df, "Converted_2021_Results.csv")
#****************************************************************************










#****************************************************************************
# 3. NULLIFIED STATIONS PDF FILE CONVERSION
source("UGD2021_Conversion_Driver.R")

Processed.df <- Convert_2021_NullStations("NullifiedPollingStationsPresidential2021.pdf")

write.csv(Processed.df, "Converted_2021_NullStations.csv", row.names = FALSE)

#****************************************************************************










#****************************************************************************
# 4. DISTRICT TALLY SHEET PDF CONVERSION
source("UGD2021_Conversion_Driver.R")

Processed.df <- Convert_2021_DistTallySheet("District_Summary_PRESIDENT_FINAL_2021.pdf")

write.csv(Processed.df, "Converted_2021_DistrictTallySheet.csv", row.names = FALSE)

#****************************************************************************










#****************************************************************************
# 5. VOTER COUNT BY STATIONS PDF CONVERSION
source("UGD2021_Conversion_Driver.R")

Processed.df <- Convert_2021_VoterCountbyStations("Voter_Count_by_Polling_Stations_2021.pdf")

write.csv(Processed.df, "Converted_2021_VoterCountbyStations.csv", row.names = FALSE)

#****************************************************************************