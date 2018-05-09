################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1631
#April 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1631 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1631-noDepth.csv", na.strings = "")

# delete unnecessary rows 
ID1631 <- ID1631[-(1:2),]

# change column names to standard column names
colnames(ID1631) <- c('sampleDate', 'sampleTime', 'Temperature')

# reformat Date
ID1631$sampleDate <- strptime(as.character(ID1631$sampleDate), "%m/%d/%y")
ID1631$sampleDate <- format(ID1631$sampleDate, "%Y-%m-%d")

# add 'AKOATS_ID' attribute
ID1631$AKOATS_ID <- '1631'

# add 'UseData' attribute
ID1631$UseData <- '1'
# index entries with NA Temperature values
a <- which(is.na(ID1631$Temperature))
# use index to replace NA with '0'
ID1631$UseData[a] <- '0'

# write csv
write.csv(ID1631,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1631.csv', row.names = F)


