#############
#Formatting Meg Perdue's data from FWS
#August 2017
#Jo Anna Beck
#############

library(tidyr)
library(dataone)
library(arcticdatautils)
library(EML)
library(XML)  
library(digest)

#read in files and rename them to their AKOATS_ID
AKOATS_ID1149 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_571001154134300 (1).csv')
AKOATS_ID1150 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_571221154040300.csv')
AKOATS_ID1151 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_571359154244300.csv')
AKOATS_ID1152 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_572656154082400.csv')
AKOATS_ID1833 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_580223156504500.csv') #needs AKOATS_ID column
AKOATS_ID1153 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_623819141014500.csv')
AKOATS_ID1154 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_623944141034900.csv')
AKOATS_ID1155 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_625113141273500.csv')
AKOATS_ID1156 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_655930151520700.csv')
AKOATS_ID1834 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_660145152074900.csv')
AKOATS_ID1157 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_661223151051100.csv')
AKOATS_ID1158 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_661747151065800.csv')
AKOATS_ID1159 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_665105151054300.csv')
AKOATS_ID1835 <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/USFWS_WRB_Site_665429151405100.csv')

#add in AKOATS_ID 

AKOATS_ID1833$AKOATS_ID <- '1833'

#add in UseData column and fill with '1' 

AKOATS_ID1149$UseData <- '1'
AKOATS_ID1150$UseData <- '1'
AKOATS_ID1151$UseData <- '1'
AKOATS_ID1152$UseData <- '1' 
AKOATS_ID1833$UseData <- '1'
AKOATS_ID1153$UseData <- '1'
AKOATS_ID1154$UseData <- '1'
AKOATS_ID1155$UseData <- '1'
AKOATS_ID1156$UseData <- '1'
AKOATS_ID1834$UseData <- '1'
AKOATS_ID1157$UseData <- '1'
AKOATS_ID1158$UseData <- '1'
AKOATS_ID1159$UseData <- '1'
AKOATS_ID1835$UseData <- '1'

####
#seperate dateTime into sampleTime and sampleDate
####

#put date and time in different columns 
AKOATS_ID1149 <- separate(AKOATS_ID1149, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1150 <- separate(AKOATS_ID1150, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1151 <- separate(AKOATS_ID1151, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1152 <- separate(AKOATS_ID1152, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1833 <- separate(AKOATS_ID1833, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1153 <- separate(AKOATS_ID1153, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1154 <- separate(AKOATS_ID1154, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1155 <- separate(AKOATS_ID1155, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1156 <- separate(AKOATS_ID1156, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1834 <- separate(AKOATS_ID1834, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1157 <- separate(AKOATS_ID1157, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1158 <- separate(AKOATS_ID1158, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1159 <- separate(AKOATS_ID1159, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")
AKOATS_ID1835 <- separate(AKOATS_ID1835, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

#reformat Date, except on 1833 (already formatted correctly)
AKOATS_ID1149$sampleDate <- strptime(as.character(AKOATS_ID1149$sampleDate), "%m/%d/%y")
AKOATS_ID1149$sampleDate <- format(AKOATS_ID1149$sampleDate, "%Y-%m-%d")

AKOATS_ID1150$sampleDate <- strptime(as.character(AKOATS_ID1150$sampleDate), "%m/%d/%y")
AKOATS_ID1150$sampleDate <- format(AKOATS_ID1150$sampleDate, "%Y-%m-%d")

AKOATS_ID1151$sampleDate <- strptime(as.character(AKOATS_ID1151$sampleDate), "%m/%d/%y")
AKOATS_ID1151$sampleDate <- format(AKOATS_ID1151$sampleDate, "%Y-%m-%d")

AKOATS_ID1152$sampleDate <- strptime(as.character(AKOATS_ID1152$sampleDate), "%m/%d/%y")
AKOATS_ID1152$sampleDate <- format(AKOATS_ID1152$sampleDate, "%Y-%m-%d")

AKOATS_ID1153$sampleDate <- strptime(as.character(AKOATS_ID1153$sampleDate), "%m/%d/%y")
AKOATS_ID1153$sampleDate <- format(AKOATS_ID1153$sampleDate, "%Y-%m-%d")

AKOATS_ID1154$sampleDate <- strptime(as.character(AKOATS_ID1154$sampleDate), "%m/%d/%y")
AKOATS_ID1154$sampleDate <- format(AKOATS_ID1154$sampleDate, "%Y-%m-%d")

AKOATS_ID1155$sampleDate <- strptime(as.character(AKOATS_ID1155$sampleDate), "%m/%d/%y")
AKOATS_ID1155$sampleDate <- format(AKOATS_ID1155$sampleDate, "%Y-%m-%d")

AKOATS_ID1156$sampleDate <- strptime(as.character(AKOATS_ID1156$sampleDate), "%m/%d/%y")
AKOATS_ID1156$sampleDate <- format(AKOATS_ID1156$sampleDate, "%Y-%m-%d")

AKOATS_ID1834$sampleDate <- strptime(as.character(AKOATS_ID1834$sampleDate), "%m/%d/%y")
AKOATS_ID1834$sampleDate <- format(AKOATS_ID1834$sampleDate, "%Y-%m-%d")

AKOATS_ID1157$sampleDate <- strptime(as.character(AKOATS_ID1157$sampleDate), "%m/%d/%y")
AKOATS_ID1157$sampleDate <- format(AKOATS_ID1157$sampleDate, "%Y-%m-%d")

AKOATS_ID1158$sampleDate <- strptime(as.character(AKOATS_ID1158$sampleDate), "%m/%d/%y")
AKOATS_ID1158$sampleDate <- format(AKOATS_ID1158$sampleDate, "%Y-%m-%d")

AKOATS_ID1159$sampleDate <- strptime(as.character(AKOATS_ID1159$sampleDate), "%m/%d/%y")
AKOATS_ID1159$sampleDate <- format(AKOATS_ID1159$sampleDate, "%Y-%m-%d")

AKOATS_ID1835$sampleDate <- strptime(as.character(AKOATS_ID1835$sampleDate), "%m/%d/%y")
AKOATS_ID1835$sampleDate <- format(AKOATS_ID1835$sampleDate, "%Y-%m-%d")

####
#index the observations that have NAs for any of the columns 
####

#replace '---' with NA 
AKOATS_ID1149$Temperature <- gsub("---", NA, AKOATS_ID1149$Temperature)
AKOATS_ID1150$Temperature <- gsub("---", NA, AKOATS_ID1150$Temperature)
AKOATS_ID1151$Temperature <- gsub("---", NA, AKOATS_ID1151$Temperature)
AKOATS_ID1152$Temperature <- gsub("---", NA, AKOATS_ID1152$Temperature)
AKOATS_ID1153$Temperature <- gsub("---", NA, AKOATS_ID1153$Temperature)
AKOATS_ID1154$Temperature <- gsub("---", NA, AKOATS_ID1154$Temperature)
AKOATS_ID1155$Temperature <- gsub("---", NA, AKOATS_ID1155$Temperature)
AKOATS_ID1156$Temperature <- gsub("---", NA, AKOATS_ID1156$Temperature)
AKOATS_ID1157$Temperature <- gsub("---", NA, AKOATS_ID1157$Temperature)
AKOATS_ID1158$Temperature <- gsub("---", NA, AKOATS_ID1158$Temperature)
AKOATS_ID1159$Temperature <- gsub("---", NA, AKOATS_ID1159$Temperature)
AKOATS_ID1833$Temperature <- gsub("---", NA, AKOATS_ID1833$Temperature)
AKOATS_ID1834$Temperature <- gsub("---", NA, AKOATS_ID1834$Temperature)
AKOATS_ID1835$Temperature <- gsub("---", NA, AKOATS_ID1835$Temperature)

#NA in the date and time columns, and '0' to the UseData column

a <- which(is.na(AKOATS_ID1149$sampleDate))
b <- which(is.na(AKOATS_ID1150$sampleDate))
c <- which(is.na(AKOATS_ID1151$sampleDate))
d <- which(is.na(AKOATS_ID1152$sampleDate))
e <- which(is.na(AKOATS_ID1153$sampleDate))
f <- which(is.na(AKOATS_ID1154$sampleDate))
g <- which(is.na(AKOATS_ID1155$sampleDate))
h <- which(is.na(AKOATS_ID1156$sampleDate))
i <- which(is.na(AKOATS_ID1157$sampleDate))
j <- which(is.na(AKOATS_ID1158$sampleDate))
k <- which(is.na(AKOATS_ID1159$sampleDate))
l <- which(is.na(AKOATS_ID1833$sampleDate))
m <- which(is.na(AKOATS_ID1834$sampleDate))
n <- which(is.na(AKOATS_ID1835$sampleDate))

#using the index, fill in the word 'in' for those particular rows 
AKOATS_ID1149$UseData[a] <- '0'
AKOATS_ID1150$UseData[b] <- '0'
AKOATS_ID1151$UseData[c] <- '0'
AKOATS_ID1152$UseData[d] <- '0'
AKOATS_ID1153$UseData[e] <- '0'
AKOATS_ID1154$UseData[f] <- '0'
AKOATS_ID1155$UseData[g] <- '0'
AKOATS_ID1156$UseData[h] <- '0'
AKOATS_ID1157$UseData[i] <- '0'
AKOATS_ID1158$UseData[j] <- '0'
AKOATS_ID1159$UseData[k] <- '0'
AKOATS_ID1833$UseData[l] <- '0'
AKOATS_ID1834$UseData[m] <- '0'
AKOATS_ID1835$UseData[n] <- '0'

#write csv

write.csv(AKOATS_ID1149,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1149.csv', row.names = F)
write.csv(AKOATS_ID1150,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1150.csv', row.names = F)
write.csv(AKOATS_ID1151,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1151.csv', row.names = F)
write.csv(AKOATS_ID1152,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1152.csv', row.names = F)
write.csv(AKOATS_ID1153,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1153.csv', row.names = F)
write.csv(AKOATS_ID1154,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1154.csv', row.names = F)
write.csv(AKOATS_ID1155,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1155.csv', row.names = F)
write.csv(AKOATS_ID1156,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1156.csv', row.names = F)
write.csv(AKOATS_ID1157,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1157.csv', row.names = F)
write.csv(AKOATS_ID1158,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1158.csv', row.names = F)
write.csv(AKOATS_ID1159,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1159.csv', row.names = F)
write.csv(AKOATS_ID1833,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1833.csv', row.names = F)
write.csv(AKOATS_ID1834,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1834.csv', row.names = F)
write.csv(AKOATS_ID1835,'/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1835.csv', row.names = F)

#######
#Editing the EML in R
#######

#set path to a local copy of the EML 
path1 <- '/home/jbeck/StreamTemperature/MegPerdue/PerdueXML.xml'
eml <- read_eml(path1)

#built attribute table in excel, read it in 
attributes <- read.csv('/home/jbeck/StreamTemperature/MegPerdue/Attributes.csv', stringsAsFactors = F)
attributes

#enumerated domains need to be defined by their siteID based on Meg Perdue's metadata on the google drive
AKOATS_ID <- c('1149' = '571001154134300', '1150' = '571221154040300', '1151' = '571359154244300', '1152' = '572656154082400', '1153' = '623819141014500', '1154' = '623944141034900', '1155' = '625113141273500', '1156' = '655930151520700', '1157' = '661223151051100', '1158' = '661747151065800', '1159' = '665105151054300', '1833' = '580223156504500', '1834' = '660145152074900', '1835' = '665429151405100', '1848' = '551842162394700', '1849' = '551737162402700', '1850' = '550002162533500', '1851' = '550044162532100', '1852' = '552014162191000', '1853' = '551929162142200', '1854' = '551839162163700', '1855' = '545720163050900', '1856' = '545922163070500', '1857' = '550229162574000', '1858' = '552901162274900', '1859' = '552822162275800', '1860' = '552648162280800', '1861' = '552357162272100', '1862' = '550933163014100', '1863' = '550636162582800', '1864' = '550835162563400', '1865' = '551655162462500', '1866' = '551639162245700', '1867' = '551108162223100', '1868' = '551556162154100', '1869' = '551520162180900', '1870' = '551829162264800', '1871' = '552021162286000', '1872' = '654154156044000', '1873' = '654110156050500', '1874' = '660729156160900', '1875' = '660318156514300', '1876' = '660401157135600')

factors1 <- rbind(data.frame(attributeName = 'AKOATS_ID', code = names(AKOATS_ID), definition = unname(AKOATS_ID)))

#generate attributeList
attributeList1 <- set_attributes(attributes, factors = factors1) 

#defining the physical aspects // i ran the code thru 'publish data objects' first in order to get the PIDs
physical <- pid_to_eml_physical(mn, data_pid)
physical1 <- pid_to_eml_physical(mn, data_pid1)
physical2 <- pid_to_eml_physical(mn, data_pid2)
physical3 <- pid_to_eml_physical(mn, data_pid3)
physical4 <- pid_to_eml_physical(mn, data_pid4)
physical5 <- pid_to_eml_physical(mn, data_pid5)
physical6 <- pid_to_eml_physical(mn, data_pid6)
physical7 <- pid_to_eml_physical(mn, data_pid7)
physical8 <- pid_to_eml_physical(mn, data_pid8)
physical9 <- pid_to_eml_physical(mn, data_pid9)
physical10 <- pid_to_eml_physical(mn, data_pid10)
physical11 <- pid_to_eml_physical(mn, data_pid11)
physical12 <- pid_to_eml_physical(mn, data_pid12)
physical13 <- pid_to_eml_physical(mn, data_pid13)

dataTable1 <- new('dataTable',
                  entityName = 'AKOATSID_1149.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1149, SiteID 571001154134300 from 2004 - 2007',
                  physical = physical,
                  attributeList = attributeList1)

dataTable2 <- new('dataTable',
                  entityName = 'AKOATSID_1150.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1150, SiteID 571221154040300 from 2004 - 2007',
                  physical = physical1,
                  attributeList = attributeList1)

dataTable3 <- new('dataTable',
                  entityName = 'AKOATSID_1151.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1151, SiteID 571359154244300 from 2005 - 2007',
                  physical = physical2,
                  attributeList = attributeList1)

dataTable4 <- new('dataTable',
                  entityName = 'AKOATSID_1152.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1152, SiteID 572656154082400 from 2004 - 2007',
                  physical = physical3,
                  attributeList = attributeList1)

dataTable5 <- new('dataTable',
                  entityName = 'AKOATSID_1153.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1153, SiteID 623819141014500 from 2006 - 2013',
                  physical = physical4,
                  attributeList = attributeList1)

dataTable6 <- new('dataTable',
                  entityName = 'AKOATSID_1154.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1154, SiteID 623944141034900 from 2006 - 2012',
                  physical = physical5,
                  attributeList = attributeList1)

dataTable7 <- new('dataTable',
                  entityName = 'AKOATSID_1155.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1155, SiteID 625113141273500 from 2006 - 2012',
                  physical = physical6,
                  attributeList = attributeList1)

dataTable8 <- new('dataTable',
                  entityName = 'AKOATSID_1156.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1156, SiteID 655930151520700 from 2010 - 2011',
                  physical = physical7,
                  attributeList = attributeList1)

dataTable9 <- new('dataTable',
                  entityName = 'AKOATSID_1157.csv',
                  entityDescription = 'Stream temperature data for AKOATS ID 1157, SiteID 661223151051100 from 2010 - 2015',
                  physical = physical8,
                  attributeList = attributeList1)

dataTable10 <- new('dataTable',
                   entityName = 'AKOATSID_1158.csv',
                   entityDescription = 'Stream temperature data for AKOATS ID 1158, SiteID 661747151065800 from 2010 - 2014',
                   physical = physical9,
                   attributeList = attributeList1)

dataTable11 <- new('dataTable',
                   entityName = 'AKOATSID_1159.csv',
                   entityDescription = 'Stream temperature data for AKOATS ID 1159, SiteID 665105151054300 from 2011 - 2015',
                   physical = physical10,
                   attributeList = attributeList1)

dataTable12 <- new('dataTable',
                   entityName = 'AKOATSID_1833.csv',
                   entityDescription = 'Stream temperature data for AKOATS ID 1833, SiteID 580223156504500 from 2015 - 2016',
                   physical = physical11,
                   attributeList = attributeList1)

dataTable13 <- new('dataTable',
                   entityName = 'AKOATSID_1834.csv',
                   entityDescription = 'Stream temperature data for AKOATS ID 1834, SiteID 660145152074900 from 2010 - 2015',
                   physical = physical12,
                   attributeList = attributeList1)

dataTable14 <- new('dataTable',
                   entityName = 'AKOATSID_1835.csv',
                   entityDescription = 'Stream temperature data for AKOATS ID 1835, SiteID 665429151405100 from 2015 - 2016',
                   physical = physical13,
                   attributeList = attributeList1)

#add these datables to the eml 
eml@dataset@dataTable <- c(dataTable1, dataTable2, dataTable3, dataTable4, dataTable5, dataTable6, dataTable7, dataTable8, dataTable9, dataTable10, dataTable11, dataTable12, dataTable13, dataTable14)

#writing and validating the eml 
write_eml(eml, '/home/jbeck/StreamTemperature/MegPerdue/science_metadata.xml')
path2 <- '/home/jbeck/StreamTemperature/MegPerdue/science_metadata.xml'
eml_validate(path2)

#validate eml did not work, got the error -- "Element 'textDomain': Missing child element(s). Expected is ( definition )." Went in and manually fixed this error by corraborating with the eml for Chris Sergeant that worked and has the same attribute list. Followed this schema: https://knb.ecoinformatics.org/emlparser/docs/eml-2.1.1/eml-attribute.png


#######
#Publishing a package to the site
#intro to acrticdatautils https://github.nceas.ucsb.edu/KNB/arctic-data/blob/master/datateam/How_To/introArcticdatautils.Rmd
#######

#set environment
cn <- CNode('PROD')
mn <- getMNode(cn,'urn:node:KNB') 

#TOKEN
options(dataone_test_token = "...") #pull token from https://search.dataone.org/#profile/http://orcid.org/0000-0003-0740-3649

#publish package to site
meta_path <- '/home/jbeck/StreamTemperature/MegPerdue/PerdueXML.xml'
pid <- publish_object(mn, meta_path, format_id = format_eml()) #"urn:uuid:885d8428-efa6-452f-9ae2-090e53b35189"

#publish data objects 
data_path <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1149.csv'
data_pid <- publish_object(mn, data_path, format_id = 'text/csv')

data_path1 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1150.csv'
data_pid1 <- publish_object(mn, data_path1, format_id = 'text/csv')

data_path2 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1151.csv'
data_pid2 <- publish_object(mn, data_path2, format_id = 'text/csv')

data_path3 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1152.csv'
data_pid3 <- publish_object(mn, data_path3, format_id = 'text/csv')

data_path4 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1153.csv'
data_pid4 <- publish_object(mn, data_path4, format_id = 'text/csv')

data_path5 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1154.csv'
data_pid5 <- publish_object(mn, data_path5, format_id = 'text/csv')

data_path6 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1155.csv'
data_pid6 <- publish_object(mn, data_path6, format_id = 'text/csv')

data_path7 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1156.csv'
data_pid7 <- publish_object(mn, data_path7, format_id = 'text/csv')

data_path8 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1157.csv'
data_pid8 <- publish_object(mn, data_path8, format_id = 'text/csv')

data_path9 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1158.csv'
data_pid9 <- publish_object(mn, data_path9, format_id = 'text/csv')

data_path10 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1159.csv'
data_pid10 <- publish_object(mn, data_path10, format_id = 'text/csv')

data_path11 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1833.csv'
data_pid11 <- publish_object(mn, data_path11, format_id = 'text/csv')

data_path12 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1834.csv'
data_pid12 <- publish_object(mn, data_path12, format_id = 'text/csv')

data_path13 <- '/home/jbeck/StreamTemperature/MegPerdue/Formatted/AKOATSID_1835.csv'
data_pid13 <- publish_object(mn, data_path13, format_id = 'text/csv')

#create resource map 

rm <- create_resource_map(mn, metadata_pid = 'urn:uuid:885d8428-efa6-452f-9ae2-090e53b35189', data_pids = c("urn:uuid:7e4999b9-38a2-46a7-ac5b-69754b800f0c", "urn:uuid:697e832c-55e3-445a-aec7-08f42effd05b", "urn:uuid:7b778b1a-0017-4e43-9890-c499d83c6bd9", "urn:uuid:3c0a5ea8-039a-4fd3-acf3-06622cd1fc68", "urn:uuid:cae0e1ac-fba0-4e90-bdeb-df2c24e229e2", "urn:uuid:41bffd73-cb48-430c-be5e-e02b675c0dee", "urn:uuid:17fc1f08-c897-46db-a3de-51e9324e98e8", "urn:uuid:f194bb3c-4812-42f6-b263-841cfc936bfe", "urn:uuid:e2db7d01-4bbc-4df9-91f7-8c57c4cfe25e", "urn:uuid:5b0e4369-bc49-4e4a-a179-21c14d97dfb5", "urn:uuid:2c238212-a12b-494d-a6cb-03a540e0b1e4", "urn:uuid:287f63cd-0a53-41b5-bc0e-e5256d93f05f", "urn:uuid:f5dca4c3-ec39-42c2-a7f6-343c9ba6e49f", "urn:uuid:9bcbbfed-f118-4c2b-9143-3a6a73415af3"))

#getpackage 

#rename data object file names siteID_AKOATSID_startyear_endyear by updating the sysmeta filename slot

sysmeta1 <- getSystemMetadata(mn, data_pid)
sysmeta1@fileName
sysmeta1@fileName <- '571001154134300_1149_2004_2007.csv'
updateSystemMetadata(mn, data_pid, sysmeta1)

sysmeta2 <- getSystemMetadata(mn, data_pid1)
sysmeta2@fileName
sysmeta2@fileName <- '571221154040300_1150_2004_2007.csv'
updateSystemMetadata(mn, data_pid1, sysmeta2)

sysmeta3 <- getSystemMetadata(mn, data_pid2)
sysmeta3@fileName
sysmeta3@fileName <- '571359154244300_1151_2005_2007.csv'
updateSystemMetadata(mn, data_pid2, sysmeta3)

sysmeta4 <- getSystemMetadata(mn, data_pid3)
sysmeta4@fileName
sysmeta4@fileName <- '572656154082400_1152_2004_2007.csv'
updateSystemMetadata(mn, data_pid3, sysmeta4)

sysmeta5 <- getSystemMetadata(mn, data_pid4)
sysmeta5@fileName
sysmeta5@fileName <- '623819141014500_1153_2006_2013.csv'
updateSystemMetadata(mn, data_pid4, sysmeta5)

sysmeta6 <- getSystemMetadata(mn, data_pid5)
sysmeta6@fileName
sysmeta6@fileName <- '623944141034900_1154_2006_2012.csv'
updateSystemMetadata(mn, data_pid5, sysmeta6)

sysmeta7 <- getSystemMetadata(mn, data_pid6)
sysmeta7@fileName
sysmeta7@fileName <- '625113141273500_1155_2006_2012.csv'
updateSystemMetadata(mn, data_pid6, sysmeta7)

sysmeta8 <- getSystemMetadata(mn, data_pid7)
sysmeta8@fileName
sysmeta8@fileName <- '655930151520700_1156_2010_2011.csv'
updateSystemMetadata(mn, data_pid7, sysmeta8)

sysmeta9 <- getSystemMetadata(mn, data_pid8)
sysmeta9@fileName
sysmeta9@fileName <- '661223151051100_1157_2010_2015.csv'
updateSystemMetadata(mn, data_pid8, sysmeta9)

sysmeta10 <- getSystemMetadata(mn, data_pid9)
sysmeta10@fileName
sysmeta10@fileName <- '661747151065800_1158_2010_2014.csv'
updateSystemMetadata(mn, data_pid9, sysmeta10)

sysmeta11 <- getSystemMetadata(mn, data_pid10)
sysmeta11@fileName
sysmeta11@fileName <- '665105151054300_1159_2011_2015.csv'
updateSystemMetadata(mn, data_pid10, sysmeta11)

sysmeta12 <- getSystemMetadata(mn, data_pid11)
sysmeta12@fileName
sysmeta12@fileName <- '580223156504500_1833_2015_2016.csv'
updateSystemMetadata(mn, data_pid11, sysmeta12)

sysmeta13 <- getSystemMetadata(mn, data_pid12)
sysmeta13@fileName
sysmeta13@fileName <- '660145152074900_1834_2010_2015.csv'
updateSystemMetadata(mn, data_pid12, sysmeta13)

sysmeta14 <- getSystemMetadata(mn, data_pid13)
sysmeta14@fileName
sysmeta14@fileName <- '665429151405100_1835_2015_2016.csv'
updateSystemMetadata(mn, data_pid13, sysmeta14)


#updated lat and long in science_metadata.xml 

# the function get_package is helpful to get all other PIDs in a package if you know the metadata PID
metaPid <- "urn:uuid:15a21f9a-8a35-478f-a720-83e6083acbc6"
ids <- get_package(mn, metaPid)

publish_update(mn,
               metadata_pid = ids$metadata, # old metadata PID you pulled in originally
               resource_map_pid = ids$resource_map,
               metadata_path = '/home/jbeck/StreamTemperature/MegPerdue/science_metadata.xml',
               data_pid = ids$data, # this can also be 2+ by including the PIDs in a vector c(pid1, pid2,pid3)
               check_first = T,
               use_doi = FALSE,
               public = FALSE)

#set public access

set_rights_and_access(mn, 
                      c("urn:uuid:cdecd94a-7722-41e2-b8a2-537048b7fe24", c("urn:uuid:7e4999b9-38a2-46a7-ac5b-69754b800f0c", "urn:uuid:697e832c-55e3-445a-aec7-08f42effd05b", "urn:uuid:7b778b1a-0017-4e43-9890-c499d83c6bd9", "urn:uuid:3c0a5ea8-039a-4fd3-acf3-06622cd1fc68", "urn:uuid:cae0e1ac-fba0-4e90-bdeb-df2c24e229e2", "urn:uuid:41bffd73-cb48-430c-be5e-e02b675c0dee", "urn:uuid:17fc1f08-c897-46db-a3de-51e9324e98e8", "urn:uuid:f194bb3c-4812-42f6-b263-841cfc936bfe", "urn:uuid:e2db7d01-4bbc-4df9-91f7-8c57c4cfe25e", "urn:uuid:5b0e4369-bc49-4e4a-a179-21c14d97dfb5", "urn:uuid:2c238212-a12b-494d-a6cb-03a540e0b1e4", "urn:uuid:287f63cd-0a53-41b5-bc0e-e5256d93f05f", "urn:uuid:f5dca4c3-ec39-42c2-a7f6-343c9ba6e49f", "urn:uuid:9bcbbfed-f118-4c2b-9143-3a6a73415af3"), "resource_map_urn:uuid:cdecd94a-7722-41e2-b8a2-537048b7fe24"),'http://orcid.org/0000-0003-0740-3649', c('read', 'write', 'changePermission'))  


set_public_read(mn, 'urn:uuid:cdecd94a-7722-41e2-b8a2-537048b7fe24')
set_public_read(mn, "urn:uuid:7e4999b9-38a2-46a7-ac5b-69754b800f0c")
set_public_read(mn, "urn:uuid:697e832c-55e3-445a-aec7-08f42effd05b")
set_public_read(mn, "urn:uuid:7b778b1a-0017-4e43-9890-c499d83c6bd9")
set_public_read(mn, "urn:uuid:3c0a5ea8-039a-4fd3-acf3-06622cd1fc68")
set_public_read(mn, "urn:uuid:cae0e1ac-fba0-4e90-bdeb-df2c24e229e2")
set_public_read(mn, "urn:uuid:41bffd73-cb48-430c-be5e-e02b675c0dee")
set_public_read(mn, "urn:uuid:17fc1f08-c897-46db-a3de-51e9324e98e8")
set_public_read(mn, "urn:uuid:f194bb3c-4812-42f6-b263-841cfc936bfe")
set_public_read(mn, "urn:uuid:e2db7d01-4bbc-4df9-91f7-8c57c4cfe25e")
set_public_read(mn, "urn:uuid:5b0e4369-bc49-4e4a-a179-21c14d97dfb5")
set_public_read(mn, "urn:uuid:2c238212-a12b-494d-a6cb-03a540e0b1e4")
set_public_read(mn, "urn:uuid:287f63cd-0a53-41b5-bc0e-e5256d93f05f")
set_public_read(mn, "urn:uuid:f5dca4c3-ec39-42c2-a7f6-343c9ba6e49f")
set_public_read(mn, "urn:uuid:9bcbbfed-f118-4c2b-9143-3a6a73415af3")

set_public_read(mn, ids$resource_map)


#entity names are wrong 
####need to archive site level metadata too 

# publish the new data objects first
data_path <- '/home/jbeck/StreamTemperature/MegPerdue/SiteLevelMetadata.csv'
dataPid <-publish_object(mn, data_path) 

# the function get_package is helpful to get all other PIDs in a package if you know the metadata PID
metaPid <- "urn:uuid:5933a052-5493-4f50-8622-ed83231d3fee"
ids <- get_package(mn, metaPid)

### update metadata with the otherEntities added
meta_path <- "path/to/metadata/file.xml"
publish_update(mn,
               metadata_pid = metaPid # old metadata PID you pulled in originally. Alternatively could paste in the string:  "urn:uuid:a592a9a2-547c-48ee-bff2-add133aa64ee"
               resource_map_pid = ids$resource_map,
               metadata_path = meta_path, # new updated EML file,
               data_pid = dataPid, # this can also be 2+ by including the PIDs in a vector c(pid1, pid2,pid3)
               check_first = T,
               use_doi = FALSE,
               public = FALSE)
