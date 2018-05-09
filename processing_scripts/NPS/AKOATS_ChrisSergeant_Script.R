#############
#Stream Temperature - Chris Sergeant
#August 2017
#Jo Anna Beck 
############

#extract Chris Sargeant info only 


library(dataone)
library(arcticdatautils)
library(EML)
library(XML)  
library(digest)
library(dplyr)

############
#Formatting Chris Sargeant's data
############

#read in 

Indian <- read.csv('/home/jbeck/StreamTemperature/ChrisSergeant/FQ_IndianRiver_2016.csv')
Salmon <- read.csv('/home/jbeck/StreamTemperature/ChrisSergeant/FQ_SalmonRiver_2016.csv')
Taiya <- read.csv('/home/jbeck/StreamTemperature/ChrisSergeant/FQ_TaiyaRiver_2016.csv')

#####
#column names should be:
#AKOATS_ID
#sampleDateTime
#Temperature
#UseData - 0 == bad data, 1 == good data
#temp_data_grade
####

#get AKOATS ID from metadata document
#Indian = 757
#Salmon = 758
#Taiya = 759

#derive UseData from their internal QA flags.temp data grade has 5 levels, blank, 'E', 'F', 'G', "P' (excellent, fair, good, poor) retain all for now. See protocol for more information https://science.nature.nps.gov/im/units/sean/AuxRep/FQ/FQ_A/FQ_Protocol%202013.1.pdf

#Indian River 
Indian$UseData <- 1

Indian$SampleDateTime <- strptime(as.character(Indian$DateTime), "%m/%d/%y %H")
Indian$SampleDateTime <- format(Indian$SampleDateTime, "%Y-%m-%d %H:%M:%S")

#replace data grades with full words
Indian$temp_data_grade <- gsub("G", "good", Indian$temp_data_grade)
Indian$temp_data_grade <- gsub("F", "fair", Indian$temp_data_grade)
Indian$temp_data_grade <- gsub("E", "excellent", Indian$temp_data_grade)
Indian$temp_data_grade <- gsub("P", "poor", Indian$temp_data_grade)

t <- select(Indian, AKOATS_ID, SampleDateTime, Temperature, temp_data_grade, UseData) #join these columns 

#Salmon River
Salmon$UseData <- 1

Salmon$SampleDateTime <- strptime(as.character(Salmon$DateTime), "%m/%d/%y %H")
Salmon$SampleDateTime <- format(Salmon$SampleDateTime, "%Y-%m-%d %H:%M:%S")

#replace data grades with full words
Salmon$temp_data_grade <- gsub("G", "good", Salmon$temp_data_grade)
Salmon$temp_data_grade <- gsub("F", "fair", Salmon$temp_data_grade)
Salmon$temp_data_grade <- gsub("E", "excellent", Salmon$temp_data_grade)
Salmon$temp_data_grade <- gsub("P", "poor", Salmon$temp_data_grade)

t2 <- select(Salmon, AKOATS_ID, SampleDateTime, Temperature, temp_data_grade, UseData) #join these columns 

#Taiya River
Taiya$UseData <- 1

Taiya$SampleDateTime <- strptime(as.character(Taiya$DateTime), "%m/%d/%y %H")
Taiya$SampleDateTime <- format(Taiya$SampleDateTime, "%Y-%m-%d %H:%M:%S")

#replace data grades with full words
Taiya$temp_data_grade <- gsub("G", "good", Taiya$temp_data_grade)
Taiya$temp_data_grade <- gsub("F", "fair", Taiya$temp_data_grade)
Taiya$temp_data_grade <- gsub("E", "excellent", Taiya$temp_data_grade)
Taiya$temp_data_grade <- gsub("P", "poor", Taiya$temp_data_grade)

t3 <- select(Taiya, AKOATS_ID, SampleDateTime, Temperature, temp_data_grade, UseData) #join these columns 

write.csv(t,'/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_IndianRiver_2016.csv', row.names = F)
write.csv(t2,'/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_SalmonRiver_2016.csv', row.names = F)
write.csv(t3,'/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_TaiyaRiver_2016.csv', row.names = F)

##############
#Editing EML in R https://github.nceas.ucsb.edu/KNB/arctic-data/blob/master/datateam/How_To/EML/editingEMLinR.Rmd
#One metadata and 3 data_objects 
##############

#set path to a local copy of the EML 
path1 <- '/home/jbeck/StreamTemperature/ChrisSergeant/IndianRiverMetadata.xml'
eml <- read_eml(path1)

#built attribute table in excel, read it in 
attributes <- read.csv('/home/jbeck/StreamTemperature/ChrisSergeant/Attributes.csv', stringsAsFactors = F)

#enumerated domains need another dataframe: attributeName, code, definition
AKOATS_ID <- c('757' = 'Indian River', '758' = 'Salmon River', '759' = 'Taiya River')
temp_data_grade <- c(excellent = 'Excellent', good = 'Good', fair = 'Fair', poor = 'Poor')
UseData <- c('0' = 'do not use data', '1' = 'use data')

factors1 <- rbind(data.frame(attributeName = 'AKOATS_ID', code = names(AKOATS_ID), definition = unname(AKOATS_ID)),
                  data.frame(attributeName = 'temp_data_grade', code = names(temp_data_grade), definition = unname(temp_data_grade)), 
                  data.frame(attributeName = 'UseData', code = names(UseData), definition = unname(UseData)))

#generate attributeList
attributeList1 <- set_attributes(attributes, factors = factors1) #physical aspects need to be defined 

#######
#Publishing a package to the site
#intro to acrticdatautils https://github.nceas.ucsb.edu/KNB/arctic-data/blob/master/datateam/How_To/introArcticdatautils.Rmd
#######

#set environment
cn <- CNode('STAGING')
mn <- getMNode(cn,'urn:node:mnTestARCTIC')

#TOKEN
options(dataone_test_token = "...")

#publishing a package to the site 
meta_path <- '/home/jbeck/StreamTemperature/ChrisSergeant/IndianRiverMetadata.xml'
#pid <- publish_object(mn, meta_path, format_id = format_eml()) #metadata pid
#"urn:uuid:fe241d4a-7052-451d-95e4-2ecd5fbd5c3b" // has been updated on the test site to include information about the other two rivers 

# adding the datasets / updating a current package / publish the new data objects first

data_path <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_IndianRiver_2016.csv'
data_pid1 <- publish_object(mn, data_path, format_id = 'text/csv')
data_path2 <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_SalmonRiver_2016.csv'
data_pid2 <- publish_object(mn, data_path2, format_id = 'text/csv')
data_path3 <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_TaiyaRiver_2016.csv'
data_pid3 <- publish_object(mn, data_path3, format_id = 'text/csv')

#create and publish resource map
#rm <- create_resource_map(mn, pid, data_pids = data_pid)

#physical section 
physical1 <- pid_to_eml_physical(mn, data_pid1)
physical2 <- pid_to_eml_physical(mn, data_pid2)
physical3 <- pid_to_eml_physical(mn, data_pid3)

dataTable1 <- new('dataTable',
                  entityName = 'Formatted_IndianRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Indian River in southeast AK from 2010 - 2016',
                  physical = physical1,
                  attributeList = attributeList1)

dataTable2 <- new('dataTable',
                  entityName = 'Formatted_SalmonRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Salmon River in southeast AK from 2010 - 2016',
                  physical = physical2,
                  attributeList = attributeList1)

dataTable3 <- new('dataTable',
                  entityName = 'Formatted_TaiyaRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Taiya River in southeast AK from 2011 - 2016',
                  physical = physical3,
                  attributeList = attributeList1)

eml@dataset@dataTable <- c(dataTable1, dataTable2, dataTable3)

write_eml(eml, '/home/jbeck/StreamTemperature/ChrisSergeant/science_metadata.xml')

create_resource_map(mn, metadata_pid = 'autogen.2017081014433467673.2', data_pids = c("urn:uuid:bd0e2e3f-d520-4672-9631-4ed570aa3513", "urn:uuid:5e8e1a0f-4eb0-4118-9f4e-6619dab7c7e9", "urn:uuid:2b0573c0-172f-40a7-8e91-2c5566a7f10f"))

ids <- get_package(mn, "resource_map_urn:uuid:d22d8111-8bd0-40b5-8f4a-b8b45a7f382e", file_names = TRUE, rows = 1000)

publish_update(mn, metadata_pid = ids$metadata, 
               resource_map_pid = ids$resource_map, 
               data_pids = ids$data, metadata_path = '/home/jbeck/StreamTemperature/ChrisSergeant/science_metadata.xml')

#found an error in the metadata, so I downloaded the xml file and made the edits, reuploaded it to R , got the new resource map id from the webpage and republished it. 

ids <- get_package(mn, "resource_map_urn:uuid:851199f0-6d48-4e07-9dc3-4880cd2ce4ee", file_names = TRUE, rows = 1000)

publish_update(mn, metadata_pid = ids$metadata, 
               resource_map_pid = ids$resource_map, 
               data_pids = ids$data, metadata_path = '/home/jbeck/StreamTemperature/ChrisSergeant/urn-uuid-851199f0-6d48-4e07-9dc3-4880cd2ce4ee.xml')

eml@dataset@dataTable <- c(dataTable1, dataTable2, dataTable3)

?get_package

?publish_update(mn, pid, rm_pid, datapids, metadata_path = meta_path )

#rename data object file names sitename_AKOATSID_startyear_endyear by updating the sysmeta filename slot

pid1 <- "urn:uuid:bd0e2e3f-d520-4672-9631-4ed570aa3513"
sysmeta1 <- getSystemMetadata(mn, pid1)
sysmeta1@fileName
sysmeta1@fileName <- 'IndianRiver_757_2010_2016.csv'
updateSystemMetadata(mn, pid1, sysmeta1)

pid2 <- "urn:uuid:5e8e1a0f-4eb0-4118-9f4e-6619dab7c7e9"
sysmeta2 <- getSystemMetadata(mn, pid2)
sysmeta2@fileName
sysmeta2@fileName <- 'SalmonRiver_758_2010_2016.csv'
updateSystemMetadata(mn, pid2, sysmeta2)

pid3 <- "urn:uuid:2b0573c0-172f-40a7-8e91-2c5566a7f10f"
sysmeta3 <- getSystemMetadata(mn, pid3)
sysmeta3@fileName
sysmeta3@fileName <- 'TaiyaRiver_759_2011_2016.csv'
updateSystemMetadata(mn, pid3, sysmeta3)

#reformat time in data files YYYY-MM-DD hh:mm:ss and use update_object

ids2 <- get_package(mn, "resource_map_urn:uuid:c8ccd447-3a9f-4c9c-9e89-c494a90e86c6", file_names = TRUE, rows = 1000)

##################
##################

# publish the new data objects first
data_path <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_IndianRiver_2016.csv'
dataPid <- publish_object(mn, data_path) 
data_path2 <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_SalmonRiver_2016.csv'
dataPid2 <- publish_object(mn, data_path2) 
data_path3 <- '/home/jbeck/StreamTemperature/ChrisSergeant/Formatted_TaiyaRiver_2016.csv'
dataPid3 <- publish_object(mn, data_path3) 

# the function get_package is helpful to get all other PIDs in a package if you know the metadata PID
metaPid <- "urn:uuid:c8ccd447-3a9f-4c9c-9e89-c494a90e86c6"
ids <- get_package(mn, metaPid)

#publish updated data objects

publish_update(mn,
               metadata_pid = ids$metadata, # old metadata PID you pulled in originally
               resource_map_pid = ids$resource_map,
               data_pid = c(dataPid, dataPid2, dataPid3), # this can also be 2+ by including the PIDs in a vector c(pid1, pid2,pid3)
               check_first = T,
               use_doi = FALSE,
               public = FALSE)

#######
#built attribute table in excel, read it in 
attributes <- read.csv('/home/jbeck/StreamTemperature/ChrisSergeant/Attributes.csv', stringsAsFactors = F)

#enumerated domains need another dataframe: attributeName, code, definition
AKOATS_ID <- c('757' = 'Indian River', '758' = 'Salmon River', '759' = 'Taiya River')
temp_data_grade <- c(excellent = 'Excellent', good = 'Good', fair = 'Fair', poor = 'Poor')
UseData <- c('0' = 'do not use data', '1' = 'use data')

factors1 <- rbind(data.frame(attributeName = 'AKOATS_ID', code = names(AKOATS_ID), definition = unname(AKOATS_ID)),
                  data.frame(attributeName = 'temp_data_grade', code = names(temp_data_grade), definition = unname(temp_data_grade)), 
                  data.frame(attributeName = 'UseData', code = names(UseData), definition = unname(UseData)))

#generate attributeList
attributeList1 <- set_attributes(attributes, factors = factors1) #physical aspects need to be defined 

#
physical1 <- pid_to_eml_physical(mn, dataPid)
physical2 <- pid_to_eml_physical(mn, dataPid2)
physical3 <- pid_to_eml_physical(mn, dataPid3)

dataTable1 <- new('dataTable',
                  entityName = 'Formatted_IndianRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Indian River in southeast AK from 2010 - 2016',
                  physical = physical1,
                  attributeList = attributeList1)

dataTable2 <- new('dataTable',
                  entityName = 'Formatted_SalmonRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Salmon River in southeast AK from 2010 - 2016',
                  physical = physical2,
                  attributeList = attributeList1)

dataTable3 <- new('dataTable',
                  entityName = 'Formatted_TaiyaRiver_2016.csv',
                  entityDescription = 'Stream temperature data for Taiya River in southeast AK from 2011 - 2016',
                  physical = physical3,
                  attributeList = attributeList1)

eml <- read_eml('/home/jbeck/StreamTemperature/ChrisSergeant/urn-uuid-851199f0-6d48-4e07-9dc3-4880cd2ce4ee.xml')

eml@dataset@dataTable <- c(dataTable1, dataTable2, dataTable3)

eml_validate(eml)

write_eml(eml, '/home/jbeck/StreamTemperature/ChrisSergeant/science_metadata.xml')

# the function get_package is helpful to get all other PIDs in a package if you know the metadata PID
metaPid <- "urn:uuid:998e5fc2-c0df-4831-a944-caabec8b79a6"
ids <- get_package(mn, metaPid)

#publish updated data objects

publish_update(mn,
               metadata_pid = ids$metadata, # old metadata PID you pulled in originally
               resource_map_pid = ids$resource_map,
               metadata_path = '/home/jbeck/StreamTemperature/ChrisSergeant/science_metadata.xml',
               data_pid = ids$data, # this can also be 2+ by including the PIDs in a vector c(pid1, pid2,pid3)
               check_first = T,
               use_doi = FALSE,
               public = FALSE)

#rename data object file names sitename_AKOATSID_startyear_endyear by updating the sysmeta filename slot

pid1 <- "urn:uuid:1dda6e4e-e063-40dc-be78-d6104c97c5b1"
sysmeta1 <- getSystemMetadata(mn, pid1)
sysmeta1@fileName
sysmeta1@fileName <- 'SalmonRiver_758_2010_2016.csv'
updateSystemMetadata(mn, pid1, sysmeta1)

pid2 <- "urn:uuid:c4b0339f-4cdf-4341-b7b3-0a65d015ceb1"
sysmeta2 <- getSystemMetadata(mn, pid2)
sysmeta2@fileName
sysmeta2@fileName <- 'IndianRiver_757_2010_2016.csv'
updateSystemMetadata(mn, pid2, sysmeta2)

pid3 <- "urn:uuid:cea9b5af-9863-485e-bbd3-b116ea7b6873"
sysmeta3 <- getSystemMetadata(mn, pid3)
sysmeta3@fileName
sysmeta3@fileName <- 'TaiyaRiver_759_2011_2016.csv'
updateSystemMetadata(mn, pid3, sysmeta3)

set_public_read(mn, ids$data)
set_public_read(mn, ids$metadata)
set_public_read(mn, ids$resource_map)


