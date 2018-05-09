# Issue #168: NPS SW Alaska Stream Temperature
# Data Cleaning - AKOATS 1937
# April 2018
# Sophia Tao




library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/KATM_margc_stream_water_20151001raw.csv", 
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


#### Run NCEAS/data-processing/R/SophieTao/FlagData.R script function ####
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

#### Continue cleaning up data ####

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1937'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1937_1.csv', row.names = F)



#### Read in 2016-2017 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/KATM_margc_stream_water_20170911raw.csv", 
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

# add in UseData column
t$UseData <- '1'

# add in AKOATS column
t$AKOATS_ID <- '1937'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1937_2.csv', row.names = F)


#### Merge 2 files ####
data1 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1937_1.csv', header = T)
data2 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1937_2.csv', header = T)
fulldata <- rbind(data1, data2)

# rearrange columns
fulldata <- fulldata[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

write.csv(fulldata, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2-formatted/1937.csv', row.names = F)
