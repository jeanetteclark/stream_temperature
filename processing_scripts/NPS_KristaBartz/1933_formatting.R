# Issue #168: NPS SW Alaska Stream Temperature
# Data Cleaning - AKOATS 1933
# April 2018
# Sophia Tao



library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_chull_beach_water_20150512raw.csv", na.strings = "", skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1933'

# add UseData column
t$UseData <- '1'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1933_1.csv', row.names = F)



#### Read in 2016-2017 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_chull_beach_water_20170418raw.csv", na.strings = "", skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# add in UseData column
t$UseData <- '1'
# index entry with an outlier Temperature value 
a <- which(t$SampleDateTime == "05/17/16 06:00:00 PM")
# use index to replace NA with '0'
t$UseData[a] <- '0'

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1933'

# rearrange columns
t <- t[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1933_2.csv', row.names = F)



#### Merge 2 files ####
data1 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1933_1.csv', header = T)
data2 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1933_2.csv', header = T)
fulldata <- rbind(data1, data2)

write.csv(fulldata, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2-formatted/1933.csv', row.names = F)

