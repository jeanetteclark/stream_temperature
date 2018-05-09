################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1431
#March 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1431 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1431.csv", na.strings = "")

# delete Grades columns 
ID1431$Water.Temp.000m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.005m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.010m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.020m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.030m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.040m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.090m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.050m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.060m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.070m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.080m.KATM_NAKNL_03_TEMP.1 <- NULL
ID1431$Water.Temp.100m.KATM_NAKNL_03_TEMP.1 <- NULL

# change column names to standard column names
colnames(ID1431) <- c('dateTime', 'Temperature', 'UseData', 'Temperature5', 'UseData5', 'Temperature10', 'UseData10', 'Temperature20', 'UseData20', 'Temperature30', 'UseData30', 'Temperature40', 'UseData40', 'Temperature50', 'UseData50', 'Temperature60', 'UseData60', 'Temperature70', 'UseData70', 'Temperature80', 'UseData80', 'Temperature90', 'UseData90', 'Temperature100', 'UseData100')

# delete unnecessary rows
ID1431 <- ID1431[-(1:2),]

# add 'Depth' attribute
ID1431$Depth <- 0
ID1431$Depth5 <- 5
ID1431$Depth10 <- 10
ID1431$Depth20 <- 20
ID1431$Depth30 <- 30
ID1431$Depth40 <- 40
ID1431$Depth50 <- 50
ID1431$Depth60 <- 60
ID1431$Depth70 <- 70
ID1431$Depth80 <- 80
ID1431$Depth90 <- 90
ID1431$Depth100 <- 100

# split into multiple data frames
df0 <- data.frame(ID1431$dateTime, ID1431$Depth, ID1431$Temperature, ID1431$UseData)
df5 <- data.frame(ID1431$dateTime, ID1431$Depth5, ID1431$Temperature5, ID1431$UseData5)
df10 <- data.frame(ID1431$dateTime, ID1431$Depth10, ID1431$Temperature10, ID1431$UseData10)
df20 <- data.frame(ID1431$dateTime, ID1431$Depth20, ID1431$Temperature20, ID1431$UseData20)
df30 <- data.frame(ID1431$dateTime, ID1431$Depth30, ID1431$Temperature30, ID1431$UseData30)
df40 <- data.frame(ID1431$dateTime, ID1431$Depth40, ID1431$Temperature40, ID1431$UseData40)
df50 <- data.frame(ID1431$dateTime, ID1431$Depth50, ID1431$Temperature50, ID1431$UseData50)
df60 <- data.frame(ID1431$dateTime, ID1431$Depth60, ID1431$Temperature60, ID1431$UseData60)
df70 <- data.frame(ID1431$dateTime, ID1431$Depth70, ID1431$Temperature70, ID1431$UseData70)
df80 <- data.frame(ID1431$dateTime, ID1431$Depth80, ID1431$Temperature80, ID1431$UseData80)
df90 <- data.frame(ID1431$dateTime, ID1431$Depth90, ID1431$Temperature10, ID1431$UseData90)
df100 <- data.frame(ID1431$dateTime, ID1431$Depth100, ID1431$Temperature100, ID1431$UseData100)
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
colnames(df80) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df90) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
colnames(df100) <- c('dateTime', 'Depth', 'Temperature', 'UseData')
# combine dataframes
df <- rbind(df0, df5, df10, df20, df30, df40, df50, df60, df70, df80, df90, df100)


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
df$AKOATS_ID <- '1431'

# rearrange columns
df <- df[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

#write csv
write.csv(df,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1431.csv', row.names = F)

