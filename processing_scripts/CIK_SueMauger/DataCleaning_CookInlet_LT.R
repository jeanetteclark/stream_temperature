
library(datamgmt)
library(readxl)
library(tidyverse)

# Convert excel files to csv ####
temp <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK Cook Inlet long term sites", full.names = T)

for (i in 1:length(temp)){
    excel_to_csv(path = temp[i], directory = "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm")
}

# Error converting: /home/stao/my-sasap/stemp_SueMauger_CIK/CIK Cook Inlet long term sites/CIK_12_05_2008.xlsx to csv
# manually convert from excel to csv and save in directory



# Data cleaning ####
files <- dir('/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm')

fileIDs <- data.frame(files = files, FileNum = c(1:175), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm")
path <- '/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm'

for (z in 1:175){
    files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
    t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
    colnames(t) <- c("sampleDate", "sampleTime", "Temperature")
    t$sampleTime <- as.POSIXct(t$sampleTime, format = "%Y-%m-%d %H:%M:%S")
    t$sampleTime <- format(t$sampleTime, "%H:%M:%S")
    t <- unite(t, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
    t$`Date Time` <- as.POSIXct(t$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming all files' original timezone is GMT-8, convert to GMT
    t <- separate(t, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
    t$UseData <- "1"
    write.csv(t, file.path('/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted', filenames[z]), row.names = F)
}



# Read in files individually to merge later on ####

a1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_10_05_2008.csv", stringsAsFactors = F)
a1[,c(4:5)] <- NULL
colnames(a1) <- c("sampleDate", "sampleTime", "Temperature")
a1$sampleTime <- as.POSIXct(a1$sampleTime, format = "%Y-%m-%d %H:%M:%S")
a1$sampleTime <- format(a1$sampleTime, "%H:%M:%S")
a1 <- unite(a1, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
a1$`Date Time` <- as.POSIXct(a1$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
a1 <- separate(a1, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
a1$UseData <- "1"

a2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_10_05_2009.csv", stringsAsFactors = F)
a3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_10_05_2010.csv", stringsAsFactors = F)
a4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_10_05_2011.csv", stringsAsFactors = F)
a5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_10_05_2012.csv", stringsAsFactors = F)
a6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_10_06_2013.csv", stringsAsFactors = F)

b1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2008.csv", stringsAsFactors = F)
b2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2009.csv", stringsAsFactors = F)
b3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2010.csv", stringsAsFactors = F)
b4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2011.csv", stringsAsFactors = F)
b5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2012.csv", stringsAsFactors = F)
b6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_06_2013.csv", stringsAsFactors = F)
b7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2014.csv", stringsAsFactors = F)
b8 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_11_05_2015.csv", stringsAsFactors = F)

c1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_12_05_2008.csv", stringsAsFactors = F)
colnames(c1) <- c("sampleDate", "sampleTime", "Temperature")
c1$sampleDate <- strptime(as.character(c1$sampleDate), "%m/%d/%y")
c1$sampleTime <- strptime(as.character(c1$sampleTime), "%H:%M")
c1$sampleTime <- format(c1$sampleTime, "%H:%M:%S")
c1 <- unite(c1, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
c1$`Date Time` <- as.POSIXct(c1$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
c1 <- separate(c1, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
c1$UseData <- "1"

c2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2009.csv", stringsAsFactors = F)
c3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2010.csv", stringsAsFactors = F)
c4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2011.csv", stringsAsFactors = F)
c5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2012.csv", stringsAsFactors = F)
c6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_06_2013.csv", stringsAsFactors = F)
c7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2014.csv", stringsAsFactors = F)
c8 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_12_05_2015.csv", stringsAsFactors = F)

d1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2008.csv", stringsAsFactors = F)
d2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2009.csv", stringsAsFactors = F)
d3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2010.csv", stringsAsFactors = F)
d4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2011.csv", stringsAsFactors = F)
d5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_06_2013.csv", stringsAsFactors = F)
d6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2014.csv", stringsAsFactors = F)
d7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_13_05_2015.csv", stringsAsFactors = F)

e1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2002.csv", stringsAsFactors = F)

e2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_14_06_2003.csv", stringsAsFactors = F)
e2[,4] <- NULL
colnames(e2) <- c("sampleDate", "sampleTime", "Temperature")
e2$sampleTime <- as.POSIXct(e2$sampleTime, format = "%Y-%m-%d %H:%M:%S")
e2$sampleTime <- format(e2$sampleTime, "%H:%M:%S")
e2 <- unite(e2, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
e2$`Date Time` <- as.POSIXct(e2$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
e2 <- separate(e2, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
e2$UseData <- "1"

e3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2004.csv", stringsAsFactors = F)
e4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_05_2005.csv", stringsAsFactors = F)

e5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_14_05_2006.csv", stringsAsFactors = F)
colnames(e5) <- c("sampleDate", "sampleTime", "Temperature")
e5$sampleDate <- as.POSIXct(e5$sampleDate, format = "%Y-%m-%d %H:%M:%S")
e5$sampleDate <- format(e5$sampleDate, "%Y-%m-%d")
e5$sampleTime <- as.POSIXct(e5$sampleTime, format = "%Y-%m-%d %H:%M:%S")
e5$sampleTime <- format(e5$sampleTime, "%H:%M:%S")
e5 <- unite(e5, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
e5$`Date Time` <- as.POSIXct(e5$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
e5 <- separate(e5, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
e5$UseData <- "1"

e6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_14_01_2007.csv", stringsAsFactors = F)
colnames(e6) <- c("sampleDate", "sampleTime", "Temperature")
e6$sampleDate <- strptime(as.character(e6$sampleDate), format = "%Y-%m-%d")
e6$sampleTime <- as.POSIXct(e6$sampleTime, format = "%Y-%m-%d %H:%M:%S")
e6$sampleTime <- format(e6$sampleTime, "%H:%M:%S")
e6 <- unite(e6, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
e6$`Date Time` <- as.POSIXct(e6$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
e6 <- separate(e6, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
e6$UseData <- "1"

e7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_01_2008.csv", stringsAsFactors = F)
e8 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_01_2009.csv", stringsAsFactors = F)
e9 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2010.csv", stringsAsFactors = F)

# actually 2010-10 to 2011-05
e10 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_14_10_2009.csv", stringsAsFactors = F) 
colnames(e10) <- c("sampleDate", "sampleTime", "Temperature")
e10$sampleTime <- as.POSIXct(e10$sampleTime, format = "%Y-%m-%d %H:%M:%S")
e10$sampleTime <- format(e10$sampleTime, "%H:%M:%S")
e10 <- unite(e10, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
e10$`Date Time` <- as.POSIXct(e10$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
e10 <- separate(e10, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
e10$UseData <- "1"
e10[16835:22083,4] <- "0" # change UseData to "0" for duplicate data 

e11 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_04_2011.csv", stringsAsFactors = F)
e12 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_10_2011.csv", stringsAsFactors = F)
e13 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2012.csv", stringsAsFactors = F)
e14 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_01_2013.csv", stringsAsFactors = F)
e15 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_01_2014.csv", stringsAsFactors = F)
e16 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2015.csv", stringsAsFactors = F)
e17 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2016.csv", stringsAsFactors = F)
e18 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_10_2016.csv", stringsAsFactors = F)
e19 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_14_06_2017.csv", stringsAsFactors = F)

f1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_06_2002.csv", stringsAsFactors = F)
f2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_06_2003.csv", stringsAsFactors = F)
f3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_05_2004.csv", stringsAsFactors = F)
f4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_05_2005.csv", stringsAsFactors = F)

f5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_15_05_2006.csv", stringsAsFactors = F)
colnames(f5) <- c("sampleDate", "sampleTime", "Temperature")
f5$sampleDate <- strptime(as.character(f5$sampleDate), format = "%Y-%m-%d")
f5$sampleDate <- format(f5$sampleDate, "%Y-%m-%d")
f5$sampleTime <- strptime(as.character(f5$sampleTime), format = "%Y-%m-%d %H:%M:%S")
f5$sampleTime <- format(f5$sampleTime, "%H:%M:%S")
f5 <- unite(f5, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
f5$`Date Time` <- as.POSIXct(f5$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
f5 <- separate(f5, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
f5$UseData <- "1"

f6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_15_01_2007.csv", stringsAsFactors = F)
colnames(f6) <- c("sampleDate", "sampleTime", "Temperature")
f6$sampleDate <- strptime(as.character(f6$sampleDate), format = "%Y-%m-%d")
f6$sampleDate <- format(f6$sampleDate, "%Y-%m-%d")
f6$sampleTime <- strptime(as.character(f6$sampleTime), format = "%Y-%m-%d %H:%M:%S")
f6$sampleTime <- format(f6$sampleTime, "%H:%M:%S")
f6 <- unite(f6, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
f6$`Date Time` <- as.POSIXct(f6$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
f6 <- separate(f6, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
f6$UseData <- "1"

f7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_06_2008.csv", stringsAsFactors = F)
f8 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_05_2009.csv", stringsAsFactors = F)
f9 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_15_05_2011.csv", stringsAsFactors = F)

g1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_06_2008.csv", stringsAsFactors = F)
g2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_05_2009.csv", stringsAsFactors = F)
g3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_05_2010.csv", stringsAsFactors = F)
g4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_05_2011.csv", stringsAsFactors = F)
g5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_05_2012.csv", stringsAsFactors = F)
g6 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_06_2013.csv", stringsAsFactors = F)
g7 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_06_2014.csv", stringsAsFactors = F)
g8 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted/CIK_23_06_2015.csv", stringsAsFactors = F)

# setwd to make it easier to access files ####
setwd('/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_formatted')

h1 <- read.csv("./CIK_28_06_2008.csv", stringsAsFactors = F)
h2 <- read.csv("./CIK_28_05_2009.csv", stringsAsFactors = F)
h3 <- read.csv("./CIK_28_06_2010.csv", stringsAsFactors = F)
h4 <- read.csv("./CIK_28_05_2011.csv", stringsAsFactors = F)
h5 <- read.csv("./CIK_28_05_2012.csv", stringsAsFactors = F)
h6 <- read.csv("./CIK_28_05_2014.csv", stringsAsFactors = F)
h7 <- read.csv("./CIK_28_06_2016.csv", stringsAsFactors = F)

j1 <- read.csv("./CIK_30_06_2008.csv", stringsAsFactors = F)
j2 <- read.csv("./CIK_30_05_2009.csv", stringsAsFactors = F)
j3 <- read.csv("./CIK_30_05_2010.csv", stringsAsFactors = F)
j4 <- read.csv("./CIK_30_05_2011.csv", stringsAsFactors = F)
j5 <- read.csv("./CIK_30_05_2012.csv", stringsAsFactors = F)
j6 <- read.csv("./CIK_30_06_2013.csv", stringsAsFactors = F)
j7 <- read.csv("./CIK_30_05_2014.csv", stringsAsFactors = F)
j8 <- read.csv("./CIK_30_10_2014.csv", stringsAsFactors = F)
j9 <- read.csv("./CIK_30_05_2015.csv", stringsAsFactors = F)
j10 <- read.csv("./CIK_30_10_2015.csv", stringsAsFactors = F)
j11 <- read.csv("./CIK_30_05_2016.csv", stringsAsFactors = F)
j12 <- read.csv("./CIK_30_10_2016.csv", stringsAsFactors = F)
j13 <- read.csv("./CIK_30_06_2017.csv", stringsAsFactors = F)

k1 <- read.csv("./CIK_35_06_2008.csv", stringsAsFactors = F)
k2 <- read.csv("./CIK_35_05_2009.csv", stringsAsFactors = F)
k3 <- read.csv("./CIK_35_05_2010.csv", stringsAsFactors = F)
k4 <- read.csv("./CIK_35_05_2011.csv", stringsAsFactors = F)
k5 <- read.csv("./CIK_35_05_2012.csv", stringsAsFactors = F)
k6 <- read.csv("./CIK_35_06_2013.csv", stringsAsFactors = F)
k7 <- read.csv("./CIK_35_05_2014.csv", stringsAsFactors = F)
k8 <- read.csv("./CIK_35_10_2014.csv", stringsAsFactors = F)
k9 <- read.csv("./CIK_35_06_2015.csv", stringsAsFactors = F)
k10 <- read.csv("./CIK_35_10_2015.csv", stringsAsFactors = F)
k11 <- read.csv("./CIK_35_05_2016.csv", stringsAsFactors = F)
k12 <- read.csv("./CIK_35_10_2016.csv", stringsAsFactors = F)
k13 <- read.csv("./CIK_35_06_2017.csv", stringsAsFactors = F)

l1 <- read.csv("./CIK_38_06_2008.csv")
l2 <- read.csv("./CIK_38_05_2009.csv")
l3 <- read.csv("./CIK_38_08_2010.csv")
l4 <- read.csv("./CIK_38_05_2011.csv")
l5 <- read.csv("./CIK_38_05_2012.csv")
l6 <- read.csv("./CIK_38_06_2013.csv")
l7 <- read.csv("./CIK_38_05_2014.csv")
l8 <- read.csv("./CIK_38_10_2014.csv")
l9 <- read.csv("./CIK_38_05_2015.csv")
l10 <- read.csv("./CIK_38_10_2015.csv")
l11 <- read.csv("./CIK_38_05_2016.csv")
l12 <- read.csv("./CIK_38_10_2016.csv")
l13 <- read.csv("./CIK_38_06_2017.csv")

m1 <- read.csv("./CIK_3_05_2008.csv", stringsAsFactors = F)
m2 <- read.csv("./CIK_3_06_2009.csv", stringsAsFactors = F)
m3 <- read.csv("./CIK_3_05_2010.csv", stringsAsFactors = F)
m4 <- read.csv("./CIK_3_05_2011.csv", stringsAsFactors = F)
m5 <- read.csv("./CIK_3_06_2013.csv", stringsAsFactors = F)
m6 <- read.csv("./CIK_3_05_2014.csv", stringsAsFactors = F)
m7 <- read.csv("./CIK_3_10_2014.csv", stringsAsFactors = F)
m8 <- read.csv("./CIK_3_05_2015.csv", stringsAsFactors = F)
m9 <- read.csv("./CIK_3_10_2015.csv", stringsAsFactors = F)
m10 <- read.csv("./CIK_3_05_2016.csv", stringsAsFactors = F)
m11 <- read.csv("./CIK_3_10_2016.csv", stringsAsFactors = F)
m12 <- read.csv("./CIK_3_06_2017.csv", stringsAsFactors = F)

n1 <- read.csv("./CIK_4_05_2008.csv", stringsAsFactors = F)
n2 <- read.csv("./CIK_4_05_2009.csv", stringsAsFactors = F)
n3 <- read.csv("./CIK_4_05_2010.csv", stringsAsFactors = F)
n4 <- read.csv("./CIK_4_07_2011.csv", stringsAsFactors = F)
n5 <- read.csv("./CIK_4_05_2012.csv", stringsAsFactors = F)
n6 <- read.csv("./CIK_4_06_2013.csv", stringsAsFactors = F)
n7 <- read.csv("./CIK_4_05_2014.csv", stringsAsFactors = F)
n8 <- read.csv("./CIK_4_10_2014.csv", stringsAsFactors = F)
n9 <- read.csv("./CIK_4_05_2015.csv", stringsAsFactors = F)
n10 <- read.csv("./CIK_4_10_2015.csv", stringsAsFactors = F)
n11 <- read.csv("./CIK_4_05_2016.csv", stringsAsFactors = F)
n12 <- read.csv("./CIK_4_10_2016.csv", stringsAsFactors = F)
n13 <- read.csv("./CIK_4_06_2017.csv", stringsAsFactors = F)

o1 <- read.csv("./CIK_6_06_2002.csv", stringsAsFactors = F)
o2 <- read.csv("./CIK_6_06_2003.csv", stringsAsFactors = F)
o3 <- read.csv("./CIK_6_05_2004.csv", stringsAsFactors = F)
o4 <- read.csv("./CIK_6_05_2005.csv", stringsAsFactors = F)
o5 <- read.csv("./CIK_6_05_2006.csv", stringsAsFactors = F)
o6 <- read.csv("./CIK_6_10_2007.csv", stringsAsFactors = F)
o7 <- read.csv("./CIK_6_10_2008.csv", stringsAsFactors = F)
o8 <- read.csv("./CIK_6_05_2009.csv", stringsAsFactors = F)
o9 <- read.csv("./CIK_6_06_2010.csv", stringsAsFactors = F)
o10 <- read.csv("./CIK_6_10_2010.csv", stringsAsFactors = F)
o11 <- read.csv("./CIK_6_05_2011.csv", stringsAsFactors = F)
o12 <- read.csv("./CIK_6_07_2012.csv", stringsAsFactors = F)
o13 <- read.csv("./CIK_6_10_2012.csv", stringsAsFactors = F)
o14 <- read.csv("./CIK_6_06_2013.csv", stringsAsFactors = F)
o15 <- read.csv("./CIK_6_10_2013.csv", stringsAsFactors = F)
o16 <- read.csv("./CIK_6_05_2014.csv", stringsAsFactors = F)
o17 <- read.csv("./CIK_6_10_2014.csv", stringsAsFactors = F)
o18 <- read.csv("./CIK_6_06_2015.csv", stringsAsFactors = F)

o19 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_6_09_2015.csv", stringsAsFactors = F)
colnames(o19) <- c("sampleDate", "sampleTime", "Temperature")
o19$sampleTime <- as.POSIXct(o19$sampleTime, format = "%Y-%m-%d %H:%M:%S")
o19$sampleTime <- format(o19$sampleTime, "%H:%M:%S")
o19 <- unite(o19, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
o19$`Date Time` <- as.POSIXct(o19$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # original timezone is GMT-8, convert to GMT
o19 <- separate(o19, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
o19$UseData <- "1"
o19[1,4] <- "0" # change UseData to "0" for duplicate data 

o20 <- read.csv("./CIK_6_06_2016.csv", stringsAsFactors = F)
o21 <- read.csv("./CIK_6_10_2016.csv", stringsAsFactors = F)
o22 <- read.csv("./CIK_6_06_2017.csv", stringsAsFactors = F)

p0 <- read.csv("./CIK_8_06_2003.csv", stringsAsFactors = F)
p1 <- read.csv("./CIK_8_05_2004.csv", stringsAsFactors = F)
p2 <- read.csv("./CIK_8_05_2005.csv", stringsAsFactors = F)

p3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_8_05_2006.csv", stringsAsFactors = F)
colnames(p3) <- c("sampleDate", "sampleTime", "Temperature")
p3$sampleDate <- as.POSIXct(p3$sampleDate, format = "%Y-%m-%d") 
p3$sampleTime <- as.POSIXct(p3$sampleTime, format = "%Y-%m-%d %H:%M:%S")
p3$sampleTime <- format(p3$sampleTime, "%H:%M:%S")
p3 <- unite(p3, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
p3$`Date Time` <- as.POSIXct(p3$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # original timezone is GMT-8, convert to GMT
p3 <- separate(p3, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
p3$UseData <- "1"

p4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_8_01_2007.csv", stringsAsFactors = F)
colnames(p4) <- c("sampleDate", "sampleTime", "Temperature")
p4$sampleDate <- as.POSIXct(p4$sampleDate, format = "%Y-%m-%d") 
p4$sampleTime <- as.POSIXct(p4$sampleTime, format = "%Y-%m-%d %H:%M:%S")
p4$sampleTime <- format(p4$sampleTime, "%H:%M:%S")
p4 <- unite(p4, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
p4$`Date Time` <- as.POSIXct(p4$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # original timezone is GMT-8, convert to GMT
p4 <- separate(p4, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
p4$UseData <- "1"

p5 <- read.csv("./CIK_8_06_2008.csv", stringsAsFactors = F)
p6 <- read.csv("./CIK_8_10_2008.csv", stringsAsFactors = F)
p7 <- read.csv("./CIK_8_05_2009.csv", stringsAsFactors = F)
p8 <- read.csv("./CIK_8_10_2009.csv", stringsAsFactors = F)
p9 <- read.csv("./CIK_8_05_2010.csv", stringsAsFactors = F)
p10 <- read.csv("./CIK_8_05_2011.csv", stringsAsFactors = F)
p11 <- read.csv("./CIK_8_06_2012.csv", stringsAsFactors = F)
p12 <- read.csv("./CIK_8_06_2013.csv", stringsAsFactors = F)
p13 <- read.csv("./CIK_8_10_2013.csv", stringsAsFactors = F)
p14 <- read.csv("./CIK_8_05_2014.csv", stringsAsFactors = F)
p15 <- read.csv("./CIK_8_10_2014.csv", stringsAsFactors = F)
p16 <- read.csv("./CIK_8_06_2015.csv", stringsAsFactors = F)
p17 <- read.csv("./CIK_8_09_2015.csv", stringsAsFactors = F)
p18 <- read.csv("./CIK_8_06_2016.csv", stringsAsFactors = F)
p19 <- read.csv("./CIK_8_04_2017.csv", stringsAsFactors = F)

q1 <- read.csv("./CIK_9_06_2008.csv", stringsAsFactors = F)
q2 <- read.csv("./CIK_9_05_2009.csv", stringsAsFactors = F)
q3 <- read.csv("./CIK_9_05_2010.csv", stringsAsFactors = F)
q4 <- read.csv("./CIK_9_05_2011.csv", stringsAsFactors = F)
q5 <- read.csv("./CIK_9_05_2012.csv", stringsAsFactors = F)
q6 <- read.csv("./CIK_9_06_2013.csv", stringsAsFactors = F)
q7 <- read.csv("./CIK_9_05_2014.csv", stringsAsFactors = F)
q8 <- read.csv("./CIK_9_05_2015.csv", stringsAsFactors = F)



# Merge files that are same site ####
a <- rbind(a1, a2, a3, a4, a5, a6)
b <- rbind(b1, b2, b3, b4, b5, b6, b7, b8)
c <- rbind(c1, c2, c3, c4, c5, c6, c7, c8)
d <- rbind(d1, d2, d3, d4, d5, d6, d7)
e <- rbind(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18, e19)
f <- rbind(f1, f2, f3, f4, f5, f6, f7, f8, f9)
g <- rbind(g1, g2, g3, g4, g5, g6, g7, g8)
h <- rbind(h1, h2, h3, h4, h5, h6, h7)
j <- rbind(j1, j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13)
k <- rbind(k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13)
l <- rbind(l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13)
m <- rbind(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12)
n <- rbind(n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13)
o <- rbind(o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21,o22)
p <- rbind(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19)
q <- rbind(q1,q2,q3,q4,q5,q6,q7,q8)

# add AKOATS ID's 
a$AKOATS_ID <- "1389"
b$AKOATS_ID <- "1385"
c$AKOATS_ID <- "1384"
d$AKOATS_ID <- "1390"
e$AKOATS_ID <- "1374"
f$AKOATS_ID <- "1378"
g$AKOATS_ID <- "1386"
h$AKOATS_ID <- "1407"
j$AKOATS_ID <- "1410"
k$AKOATS_ID <- "1404"
l$AKOATS_ID <- "1399"
m$AKOATS_ID <- "1396"
n$AKOATS_ID <- "1395"
o$AKOATS_ID <- "1379"
p$AKOATS_ID <- "1376"
q$AKOATS_ID <- "1382"

# save merged files into formatted folder
write.csv(a, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/BeaverCreek_1389_2008_2013.csv", row.names = F)
write.csv(b, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/SoldotnaCreek_1385_2008_2015.csv", row.names = F)
write.csv(c, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/SlikokCreek_1384_2008_2015.csv", row.names = F)
write.csv(d, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/BishopCreek_1390_2008_2015.csv", row.names = F)
write.csv(e, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/AnchorCreek_1374_2002_2017.csv", row.names = F)
write.csv(f, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/DeepCreek_1378_2002_2011.csv", row.names = F)
write.csv(g, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/FunnyRiver_1386_2008_2015.csv", row.names = F)
write.csv(h, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/KrotoCreek_1407_2008_2017.csv", row.names = F)
write.csv(j, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/LittleWillowCreek_1410_2008_2017.csv", row.names = F)
write.csv(k, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/WasillaCreek_1404_2008_2017.csv", row.names = F)
write.csv(l, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/FishCreek_1399_2008_2017.csv", row.names = F)
write.csv(m, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/ChesterCreek_1396_2008_2017.csv", row.names = F)
write.csv(n, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/NorthForkCampbellCreek_1395_2008_2017.csv", row.names = F)
write.csv(o, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/NinilchikRiver_1379_2003_2017.csv", row.names = F)
write.csv(p, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/StariskiCreek_1376_2003_2017.csv", row.names = F)
write.csv(q, "/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish/CrookedCreek_1382_2008_2015.csv", row.names = F)

# rearrange columns
files <- dir('/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish')

fileIDs <- data.frame(files = files, FileNum = c(1:16), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish")
path <- '/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish'

for (z in 1:16){
    files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
    t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
    t <- t[,c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID", "UseData")]
    write.csv(t, file.path('/home/stao/my-sasap/stemp_SueMauger_CIK/LongTerm_publish', filenames[z]), row.names = F)
}


