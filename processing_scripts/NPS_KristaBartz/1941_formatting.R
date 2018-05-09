#### Issue #168: NPS SW Alaska Stream Temperature ####
# Data Cleaning - AKOATS 1941
# April 2018
# Sophia Tao


library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_tlikr_stream_water_20151009raw.csv", 
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

# Run NCEAS/data-processing/R/SophieTao/FlagData.R script function
library(plotly)
library(shiny)
library(ggplot2)
library(dplyr)
# Format data
t$SampleDateTime <- as.POSIXct(t$SampleDateTime)
# Get time scale origin
origin = t$SampleDateTime[1] - as.numeric (t$SampleDateTime[1])
# Run app
t <- flagData(t, "SampleDateTime", "Temperature", origin)
# Change flagging if needed
t$FLAG <- as.numeric(!t$FLAG)
# remove index, rename columns
t$INDEX <- NULL
colnames(t) <- c('SampleDateTime', 'Temperature', 'UseData')

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t$AKOATS_ID <- '1941'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1941_1.csv', row.names = F)



#### Read in 2015-2016 file ####
t2 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_tlikr_stream_water_20160422raw.csv", 
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

# Run NCEAS/data-processing/R/SophieTao/FlagData.R script function
# Format data
t2$SampleDateTime <- as.POSIXct(t2$SampleDateTime)
# Get time scale origin
origin = t2$SampleDateTime[1] - as.numeric (t2$SampleDateTime[1])
# Run app
t2 <- flagData(t2, "SampleDateTime", "Temperature", origin)
# Change flagging if needed
t2$FLAG <- as.numeric(!t2$FLAG)
# remove index, rename columns
t2$INDEX <- NULL
colnames(t) <- c('SampleDateTime', 'Temperature', 'UseData')

# separate SampleDateTime into sampleDate and sampleTime
t2 <- separate(t2, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t2$AKOATS_ID <- '1941'

#write csv
write.csv(t2, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1941_2.csv', row.names = F)



#### Read in 2016-2017 file ####
t3 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_tlikr_A_stream_water_20170419raw.csv", 
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
t3$AKOATS_ID <- '1941'

#write csv
write.csv(t3, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/1941_3.csv', row.names = F)



#### Merge files ####
all <- rbind(t, t2, t3)

# rearrange columns
all <- all[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

write.csv(all, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3-formatted/TlikakilaRiver_1941_2014_2017.csv', row.names = F)

