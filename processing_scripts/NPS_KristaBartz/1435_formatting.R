################
#Issue #168: NPS SW Alaska Stream Temp
#Data Cleaning - AKOATS 1435
#March 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1435 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1435.csv", na.strings = "")

# delete Grades columns
ID1435$Water.Temp.000m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.005m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.010m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.020m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.030m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.040m.KATM_LBROO_01_TEMP.1 <- NULL
ID1435$Water.Temp.050m.KATM_LBROO_01_TEMP.1 <- NULL

# change column names to standard column names
colnames(ID1435) <- c('dateTime', 'Temp', 'UseData', 'Temp5', 'UseData5', 'Temp10', 'UseData10', 'Temp20', 'UseData20', 'Temp30', 'UseData30', 'Temp40', 'UseData40', 'Temp50', 'UseData50')

# delete unnecessary rows
ID1435 <- ID1435[-(1:2),]

# add 'Depth' attribute
ID1435$Depth <- 0
ID1435$Depth5 <- 5
ID1435$Depth10 <- 10
ID1435$Depth20 <- 20
ID1435$Depth30 <- 30
ID1435$Depth40 <- 40
ID1435$Depth50 <- 50

# split into multiple data frames
df0 <- data.frame(ID1435$dateTime, ID1435$Depth, ID1435$Temp, ID1435$UseData)
df5 <- data.frame(ID1435$dateTime, ID1435$Depth5, ID1435$Temp5, ID1435$UseData5)
df10 <- data.frame(ID1435$dateTime, ID1435$Depth10, ID1435$Temp10, ID1435$UseData10)
df20 <- data.frame(ID1435$dateTime, ID1435$Depth20, ID1435$Temp20, ID1435$UseData20)
df30 <- data.frame(ID1435$dateTime, ID1435$Depth30, ID1435$Temp30, ID1435$UseData30)
df40 <- data.frame(ID1435$dateTime, ID1435$Depth40, ID1435$Temp40, ID1435$UseData40)
df50 <- data.frame(ID1435$dateTime, ID1435$Depth50, ID1435$Temp50, ID1435$UseData50)
# change column names
colnames(df0) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df5) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df10) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df20) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df30) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df40) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df50) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
# combine dataframes
df <- rbind(df0, df5, df10, df20, df30, df40, df50)

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
df$AKOATS_ID <- '1435'

# rearrange columns
df <- df[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

#write csv
write.csv(df,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1435.csv', row.names = F)
