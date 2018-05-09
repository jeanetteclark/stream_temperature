################
#Issue #168: NPS SW Alaska Stream Temp
#Data Cleaning - AKOATS 1450
#March 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1450 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1450.csv", na.strings = "")

# delete Grades columns
ID1450$Water.Temp.000m.KATM_NAKNL_02_TEMP.1 <- NULL 
ID1450$Water.Temp.005m.KATM_NAKNL_02_TEMP.1 <- NULL
ID1450$Water.Temp.010m.KATM_NAKNL_02_TEMP.1 <- NULL
ID1450$Water.Temp.015m.KATM_NAKNL_02_TEMP.1 <- NULL
ID1450$Water.Temp.020m.KATM_NAKNL_02_TEMP.1 <- NULL
ID1450$Water.Temp.025m.KATM_NAKNL_02_TEMP.1 <- NULL

# change column names to standard column names
colnames(ID1450) <- c('dateTime', 'Temp', 'UseData', 'Temp5', 'UseData5', 'Temp10', 'UseData10', 'Temp15', 'UseData15', 'Temp20', 'UseData20', 'Temp25', 'UseData25')

# delete unnecessary rows
ID1450 <- ID1450[-(1:2),]

# add 'Depth' attribute
ID1450$Depth <- 0
ID1450$Depth5 <- 5
ID1450$Depth10 <- 10
ID1450$Depth15 <- 15
ID1450$Depth20 <- 20
ID1450$Depth25 <- 25

# split into multiple data frames
df0 <- data.frame(ID1450$dateTime, ID1450$Depth, ID1450$Temp, ID1450$UseData)
df5 <- data.frame(ID1450$dateTime, ID1450$Depth5, ID1450$Temp5, ID1450$UseData5)
df10 <- data.frame(ID1450$dateTime, ID1450$Depth15, ID1450$Temp15, ID1450$UseData15)
df15 <- data.frame(ID1450$dateTime, ID1450$Depth10, ID1450$Temp10, ID1450$UseData10)
df20 <- data.frame(ID1450$dateTime, ID1450$Depth20, ID1450$Temp20, ID1450$UseData20)
df25 <- data.frame(ID1450$dateTime, ID1450$Depth25, ID1450$Temp25, ID1450$UseData25)
# change column names
colnames(df0) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df5) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df10) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df15) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df20) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df25) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
# combine dataframes
df <- rbind(df0, df5, df10, df15, df20, df25)

#replace UseData values of '3' (approved) with '1' 
df$UseData <- gsub("3", "1", df$UseData)
# change UseData values of '4' (rejected) to '0'
df$UseData <- gsub("4", "0", df$UseData)
# index entries with UseData values of NA
a <- which(is.na(df$UseData))
# use index to replace NA with '0'
df$UseData[a] <- '0'

# separate dateTime into sampleDate and sampleTime
df <- separate(df, dateTime, into = c("sampleDate", "sampleTime"), sep = " ")
# reformat Date
df$sampleDate <- strptime(as.character(df$sampleDate), "%m/%d/%y")
df$sampleDate <- format(df$sampleDate, "%Y-%m-%d")
# reformat Time
df$sampleTime <- strptime(as.character(df$sampleTime), "%H:%M")
df$sampleTime <- format(df$sampleTime, "%H:%M:%S")

# add 'AKOATS_ID' attribute
df$AKOATS_ID <- '1450'

# rearrange columns
df <- df[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

#write csv
write.csv(df,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1450.csv', row.names = F)
