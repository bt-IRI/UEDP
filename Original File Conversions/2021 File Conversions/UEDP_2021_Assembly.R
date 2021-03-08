# Author: UEDP Team @ International Republican Institute
# Last modified: 3/8/21

# Imports
library(stringi)
library(stringr)

Converted_2021_Results.df <- read.csv("Converted_2021_Results.csv", stringsAsFactors = FALSE)
Converted_2021_Results.df <- Converted_2021_Results.df[,-c(1)]

Converted_2021_NullStations.df <- read.csv("Converted_2021_NullStations.csv", stringsAsFactors = FALSE)
Converted_2021_NullStations.df <- Converted_2021_NullStations.df[,-c(1)]

#************************
# Results/Null file prep
#************************
# Bind together conversion from main results df...
Assembly.df <- cbind.data.frame(
  rep(2021, nrow(Converted_2021_Results.df)),
  as.character(str_squish(substr(Converted_2021_Results.df$District, stri_locate_first(Converted_2021_Results.df$District, regex = " ")[,1], nchar(Converted_2021_Results.df$District)))),
  as.character(str_squish(substr(Converted_2021_Results.df$Constituency, stri_locate_first(Converted_2021_Results.df$Constituency, regex = " ")[,1], nchar(Converted_2021_Results.df$Constituency)))),
  as.character(str_squish(substr(Converted_2021_Results.df$Subcounty, stri_locate_first(Converted_2021_Results.df$Subcounty, regex = " ")[,1], nchar(Converted_2021_Results.df$Subcounty)))),
  as.character(str_squish(substr(Converted_2021_Results.df$Parish, stri_locate_first(Converted_2021_Results.df$Parish, regex = " ")[,1], nchar(Converted_2021_Results.df$Parish)))),
  as.character(str_squish(substr(Converted_2021_Results.df$Polling.Station, stri_locate_first(Converted_2021_Results.df$Polling.Station, regex = " ")[,1], nchar(Converted_2021_Results.df$Polling.Station)))),
  paste("O",
        as.numeric(str_squish(substr(Converted_2021_Results.df$District, 1, stri_locate_first(Converted_2021_Results.df$District, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_Results.df$Constituency, 1, stri_locate_first(Converted_2021_Results.df$Constituency, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_Results.df$Subcounty, 1, stri_locate_first(Converted_2021_Results.df$Subcounty, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_Results.df$Parish, 1, stri_locate_first(Converted_2021_Results.df$Parish, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_Results.df$Polling.Station, 1, stri_locate_first(Converted_2021_Results.df$Polling.Station, regex = " ")[,1]))),
        sep = "-"),
  Converted_2021_Results.df[,c(6:20)],
  ifelse(rowSums(Converted_2021_Results.df[,c(7:17)])==0, 1, 0)
)

colnames(Assembly.df) <- c("Year", "Dist_name_previous", "Const_name_previous", "Sub_cty_name_previous", "Par_name_previous", "Station_string_previous", "Original_Station_ID_previous","Reg.Voters",
                           "Amuriat Oboi Patrick", "Kabuleta Kiiza Joseph", "Kalembe Nancy Linda", "Katumba John", "Kyagulanyi Ssentamu Robert",
                           "Mao Norbert", "Mayambala Willy", "Mugisha Muntu Gregg", "Mwesigye Fred", "Tumukunde Henry Kakurugu", "Yoweri Museveni Tibuhaburwa Kaguta",
                           "V.Votes", "Inv.Votes", "T.Votes", "NON_REP")


# Bind together conversion from null stations df...
Assembly2.df <- cbind.data.frame(
  rep(2021, nrow(Converted_2021_NullStations.df)),
  as.character(str_squish(substr(Converted_2021_NullStations.df$District, stri_locate_first(Converted_2021_NullStations.df$District, regex = " ")[,1], nchar(Converted_2021_NullStations.df$District)))),
  as.character(str_squish(substr(Converted_2021_NullStations.df$Constituency, stri_locate_first(Converted_2021_NullStations.df$Constituency, regex = " ")[,1], nchar(Converted_2021_NullStations.df$Constituency)))),
  as.character(str_squish(substr(Converted_2021_NullStations.df$Scounty, stri_locate_first(Converted_2021_NullStations.df$Scounty, regex = " ")[,1], nchar(Converted_2021_NullStations.df$Scounty)))),
  as.character(str_squish(substr(Converted_2021_NullStations.df$Parish, stri_locate_first(Converted_2021_NullStations.df$Parish, regex = " ")[,1], nchar(Converted_2021_NullStations.df$Parish)))),
  as.character(str_squish(substr(Converted_2021_NullStations.df$POLLING.STATION, stri_locate_first(Converted_2021_NullStations.df$POLLING.STATION, regex = " ")[,1], nchar(Converted_2021_NullStations.df$POLLING.STATION)))),
  paste("O",
        as.numeric(str_squish(substr(Converted_2021_NullStations.df$District, 1, stri_locate_first(Converted_2021_NullStations.df$District, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_NullStations.df$Constituency, 1, stri_locate_first(Converted_2021_NullStations.df$Constituency, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_NullStations.df$Scounty, 1, stri_locate_first(Converted_2021_NullStations.df$Scounty, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_NullStations.df$Parish, 1, stri_locate_first(Converted_2021_NullStations.df$Parish, regex = " ")[,1]))),
        as.numeric(str_squish(substr(Converted_2021_NullStations.df$POLLING.STATION, 1, stri_locate_first(Converted_2021_NullStations.df$POLLING.STATION, regex = " ")[,1]))),
        sep = "-"),
  Converted_2021_NullStations.df[,6],
  matrix(0, nrow = nrow(Converted_2021_NullStations.df), ncol = 14),
  rep(1, nrow(Converted_2021_NullStations.df))
)

colnames(Assembly2.df) <- c("Year", "Dist_name_previous", "Const_name_previous", "Sub_cty_name_previous", "Par_name_previous", "Station_string_previous", "Original_Station_ID_previous","Reg.Voters",
                           "Amuriat Oboi Patrick", "Kabuleta Kiiza Joseph", "Kalembe Nancy Linda", "Katumba John", "Kyagulanyi Ssentamu Robert",
                           "Mao Norbert", "Mayambala Willy", "Mugisha Muntu Gregg", "Mwesigye Fred", "Tumukunde Henry Kakurugu", "Yoweri Museveni Tibuhaburwa Kaguta",
                           "V.Votes", "Inv.Votes", "T.Votes", "NON_REP")


# Bind together assembly files...
UEDP_2021.df <- rbind.data.frame(Assembly.df, Assembly2.df)

GeoDelimiters <- stri_split(UEDP_2021.df$Original_Station_ID_previous, regex = "-")

AdminCodes <- cbind.data.frame(as.numeric(as.character(sapply(GeoDelimiters, function(x) x[2]))),
                               as.numeric(as.character(sapply(GeoDelimiters, function(x) x[3]))),
                               as.numeric(as.character(sapply(GeoDelimiters, function(x) x[4]))),
                               as.numeric(as.character(sapply(GeoDelimiters, function(x) x[5]))),
                               as.numeric(as.character(sapply(GeoDelimiters, function(x) x[6]))))

colnames(AdminCodes) <- c("Dist", "Const", "Sub", "Par", "Stn")

UEDP_2021.df <- cbind(UEDP_2021.df, AdminCodes)

# Re-sort according to admin. unit codes...
UEDP_2021.df <- UEDP_2021.df[order(UEDP_2021.df$Dist,
                                   UEDP_2021.df$Const,
                                   UEDP_2021.df$Sub,
                                   UEDP_2021.df$Par,
                                   UEDP_2021.df$Stn),]

# Remove sort columns and export...
UEDP_2021.df <- UEDP_2021.df[,-c(24:28)]

write.csv(UEDP_2021.df, "UEDP_2021_AllStations.csv", row.names = FALSE)








