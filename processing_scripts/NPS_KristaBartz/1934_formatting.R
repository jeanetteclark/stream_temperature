# Issue #168: NPS SW Alaska Stream Temperature
# Data Cleaning - AKOATS 1934
# April 2018
# Sophia Tao



library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_kijil_beach_water_20150604raw.csv", na.strings = "", skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")

# add in UseData column
t$UseData <- '1'
# index entry with an outlier Temperature value 
a <- which(t$SampleDateTime == "2014-05-29 18:00:00")
b <- which(t$SampleDateTime == "2014-05-29 19:00:00")
c <- which(t$SampleDateTime == "2014-05-29 20:00:00")
d <- which(t$SampleDateTime == "2014-05-29 21:00:00")
e <- which(t$SampleDateTime == "2014-05-29 22:00:00")
# use index to replace NA with '0'
t$UseData[a] <- '0'
t$UseData[b] <- '0'
t$UseData[c] <- '0'
t$UseData[d] <- '0'
t$UseData[e] <- '0'

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1934'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1934_1.csv', row.names = F)



#### Read in 2016-2017 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_kijil_beach_water_20170928raw.csv", na.strings = "", skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")

# add in UseData column
t$UseData <- '1'
# index entry with an outlier Temperature value 
a <- which(t$SampleDateTime == "2016-10-19 18:00:00")
b <- which(t$SampleDateTime == "2016-10-19 19:00:00")
# use index to replace NA with '0'
t$UseData[a] <- '0'
t$UseData[b] <- '0'

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1934' 

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1934_2.csv', row.names = F)



#### Merge 2 files ####
data1 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1934_1.csv', header = T)
data2 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1934_2.csv', header = T)
fulldata <- rbind(data1, data2)

# rearrange columns
fulldata <- fulldata[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

write.csv(fulldata, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2-formatted/1934.csv', row.names = F)
