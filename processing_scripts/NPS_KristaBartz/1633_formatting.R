################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1633
#April 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1633 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1633-noDepth.csv", na.strings = "")

# delete unnecessary rows 
ID1633 <- ID1633[-(1:2),]

# change column names to standard column names
colnames(ID1633) <- c('sampleDate', 'sampleTime', 'Temperature')

# reformat Date
ID1633$sampleDate <- strptime(as.character(ID1633$sampleDate), "%m/%d/%y")
ID1633$sampleDate <- format(ID1633$sampleDate, "%Y-%m-%d")

# add 'AKOATS_ID' attribute
ID1633$AKOATS_ID <- '1633'

# add 'UseData' attribute
ID1633$UseData <- '1'
# index entries with NA Temperature values
a <- which(is.na(ID1633$Temperature))
# use index to replace NA with '0'
ID1633$UseData[a] <- '0'

# write csv
write.csv(ID1633,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1633.csv', row.names = F)


