#### Issue #168: NPS SW Alaska Stream Temperature ####
# Data Cleaning - AKOATS 1939
# April 2018
# Sophia Tao


library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_lkijr_stream_water_20150527raw.csv", 
              sep = ",",
              na.strings = "", 
              strip.white = T,
              skip = 1)
# delete unnecessary column
t <- t[,-(1)]
# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t$UseData <- '1'
t$AKOATS_ID <- '1939'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1939_1.csv', row.names = F)



#### Read in 2015-2016 file ####
t2 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_lkijr_stream_water_20160713raw.csv", 
              sep = ",",
              na.strings = "", 
              strip.white = T,
              skip = 1)
# delete unnecessary column
t2 <- t2[,-(1)]
# change column names
colnames(t2) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t2$SampleDateTime <- strptime(as.character(t2$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t2 <- separate(t2, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t2$UseData <- '1'
t2$AKOATS_ID <- '1939'

#write csv
write.csv(t2, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1939_2.csv', row.names = F)



#### Read in 2016-2017 file ####
t3 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_lkijr_stream_water_20170621raw.csv", 
               sep = ",",
               na.strings = "", 
               strip.white = T,
               skip = 1)
# delete unnecessary column
t3 <- t3[,-(1)]
# change column names
colnames(t3) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t3$SampleDateTime <- strptime(as.character(t3$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t3 <- separate(t3, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t3$UseData <- '1'
t3$AKOATS_ID <- '1939'

#write csv
write.csv(t3, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1939_3.csv', row.names = F)



#### Read in 2017 file ####
t4 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_lkijr_stream_water_20170922raw.csv", 
               sep = ",",
               na.strings = "", 
               strip.white = T,
               skip = 1)
# delete unnecessary column
t4 <- t4[,-(1)]
# change column names
colnames(t4) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t4$SampleDateTime <- strptime(as.character(t4$SampleDateTime), "%m/%d/%y %I:%M:%S %p")
# separate SampleDateTime into sampleDate and sampleTime
t4 <- separate(t4, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t4$UseData <- '1'
t4$AKOATS_ID <- '1939'

#write csv
write.csv(t4, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1939_4.csv', row.names = F)



#### Merge files ####
all <- rbind(t, t2, t3, t4)

# rearrange columns
all <- all[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

write.csv(all, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3-formatted/LittleKijikRiver_1939_2014_2017.csv', row.names = F)

