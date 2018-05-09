#### Issue #168: NPS SW Alaska Stream Temperature ####
# Data Cleaning - AKOATS 1940
# April 2018
# Sophia Tao


library(tidyr)

#### Read in file ####
# file edited beforehand to allow for easier read in, and changed time zone 
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/LACL_tazir_edited.csv", 
              sep = ",",
              na.strings = "", 
              strip.white = T)
# delete unnecessary column
t <- t[,-(1)]

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %H:%M")

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
colnames(t) <- c('Temperature', 'SampleDateTime', 'UseData')

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in missing columns
t$AKOATS_ID <- '1940'

# rearrange columns
t <- t[,c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID", "UseData")]

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3-formatted/TaziminaRiver_1940_2014_2017.csv', row.names = F)
