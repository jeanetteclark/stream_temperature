################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1458
#March 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1458 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1458.csv", na.strings = "")

# delete Grades columns 
ID1458$Water.Temp.000m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.005m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.010m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.020m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.030m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.040m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.050m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.060m.KATM_NAKNL_01_TEMP.1 <- NULL
ID1458$Water.Temp.070m.KATM_NAKNL_01_TEMP.1 <- NULL

# change column names to standard column names
colnames(ID1458) <- c('dateTime', 'Temp', 'UseData', 'Temp5', 'UseData5', 'Temp10', 'UseData10', 'Temp20', 'UseData20', 'Temp30', 'UseData30', 'Temp40', 'UseData40', 'Temp50', 'UseData50', 'Temp60', 'UseData60', 'Temp70', 'UseData70')

# delete unnecessary rows
ID1458 <- ID1458[-(1:2),]

# add 'Depth' attribute
ID1458$Depth <- 0
ID1458$Depth5 <- 5
ID1458$Depth10 <- 10
ID1458$Depth20 <- 20
ID1458$Depth30 <- 30
ID1458$Depth40 <- 40
ID1458$Depth50 <- 50
ID1458$Depth60 <- 60
ID1458$Depth70 <- 70

# split into multiple data frames
df0 <- data.frame(ID1458$dateTime, ID1458$Depth, ID1458$Temp, ID1458$UseData)
df5 <- data.frame(ID1458$dateTime, ID1458$Depth5, ID1458$Temp5, ID1458$UseData5)
df10 <- data.frame(ID1458$dateTime, ID1458$Depth10, ID1458$Temp10, ID1458$UseData10)
df20 <- data.frame(ID1458$dateTime, ID1458$Depth20, ID1458$Temp20, ID1458$UseData20)
df30 <- data.frame(ID1458$dateTime, ID1458$Depth30, ID1458$Temp30, ID1458$UseData30)
df40 <- data.frame(ID1458$dateTime, ID1458$Depth40, ID1458$Temp40, ID1458$UseData40)
df50 <- data.frame(ID1458$dateTime, ID1458$Depth50, ID1458$Temp50, ID1458$UseData50)
df60 <- data.frame(ID1458$dateTime, ID1458$Depth60, ID1458$Temp60, ID1458$UseData60)
df70 <- data.frame(ID1458$dateTime, ID1458$Depth70, ID1458$Temp70, ID1458$UseData70)
# change column names
colnames(df0) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df5) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df10) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df20) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df30) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df40) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df50) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df60) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df70) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
# combine dataframes
df <- rbind(df0, df5, df10, df20, df30, df40, df50, df60, df70)


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
df$AKOATS_ID <- '1458'

# rearrange columns
df <- df[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

#write csv
write.csv(df, '/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1458.csv', row.names = F)

