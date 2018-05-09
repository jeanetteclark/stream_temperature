##################
#Tessa Reeder
#SASAP Ticket #140
#NPS Stream Temperature 
#Metadata update
##################
library(dataone)
library(arcticdatautils)
library(EML)
library(XML)  
library(digest)
library(dplyr)
library(datamgmt)

path1 <- '/home/treeder/Trey Simmons other files/science_metadata.xml'
eml <- read_eml(path1) 

#set environment
cn <- CNode('PROD')
mn <- getMNode(cn,'urn:node:KNB') 

#TOKEN
options(dataone_test_token = "...") 

#publish stream temp files
setwd('/home/treeder/TreySimmons_csv')
file_paths <- dir()
new_pids <- sapply(file_paths, function(path) { publish_object(mn, path) })

#read and publish metadata csv
site <- read.csv('/home/treeder/Trey Simmons other files/SiteLevelMetadata_Simmons.csv', stringsAsFactors = F)
TSmeta_pid <- publish_object(mn, '/home/treeder/Trey Simmons other files/SiteLevelMetadata_Simmons.csv')

#read and publish spot data csv
spot <- read.csv('/home/treeder/Trey Simmons other files/SpotTempData.csv', stringsAsFactors = F)
spot_pid <- publish_object(mn, '/home/treeder/Trey Simmons other files/SpotTempData.csv')

#fix column name
names(spot)[12]<-"Hobo_Sonde"

#remove NR and replace with NA
spot$Hobo_SN <- gsub("NR", NA, spot$Hobo_SN)
spot$sondeTemp <- gsub("NR", NA, spot$sondeTemp)
write.csv(spot, '/home/treeder/Trey Simmons other files/SpotTempData.csv', row.names = F)

#changed wrong column name
spot <- read.csv('/home/treeder/Trey Simmons other files/SpotTempData.csv', stringsAsFactors = F)
names(spot)[11] <- "Hobo_Sonde"
names(spot)[12] <- "notes"
write.csv(spot, '/home/treeder/Trey Simmons other files/SpotTempData.csv', row.names = F)

#Set physicals
physical<- c()
for(i in 1:length(ids$data)){
    physical[i] <- pid_to_eml_physical(mn, ids$data[i]) 
}

physical1 <- physical[c(1:50, 52:58, 60:91)]
file_paths <- names(ids$data[c(1:50, 52:58, 60:91)])
physicalA <- physical[[51]]
physicalS <- physical[[59]]

#Attribute Table for metadata CSV
attributes2 <- read.csv('/home/treeder/Trey Simmons other files/Attributes_Table.csv', stringsAsFactors = F)
attributes2$missingValueCode[36] <- 'NA'
attributes2$missingValueCode[22] <- 'NA'
#Remove enumerated domain from other text
attributes2$domain[22] <- "textDomain"
attributes2$definition <- attributes2$attributeDefinition

factors2 <- read.csv('/home/treeder/Trey Simmons other files/TS_enumeratedDomain.csv', stringsAsFactors = F)
factors2 <- factors2[-c(13,14),]
attributeList2 <- set_attributes(attributes2, factors = factors2)

#Attribute table for Data files. Use this attribute list for all of them
attributes1<- read.csv('/home/treeder/Trey Simmons other files/TS_attributeTable2.csv', stringsAsFactors = F, na.strings = "")

factors1 <- read.csv('/home/treeder/Trey Simmons other files/TS_enumeratedDomain2.csv', stringsAsFactors = F)
attributeList1 <- set_attributes(attributes1, factors = factors1)

#Attribute Table for spot check CSV
attributesS <- read.csv('/home/treeder/Trey Simmons other files/Attributes_Table_Spot.csv', stringsAsFactors = F)
attributesS$attributeName[11]<- "Hobo_Sonde"
attributesS$missingValueCode[c(4, 6:12)] <- "NA"
attributesS$attributeDefinition[3] <- attributes1$attributeDefinition[4]
attributeListS <- set_attributes(attributesS)

#Data tables

dataTableS <- new('dataTable',
                  entityName = 'SpotTempData.csv',
                  entityDescription = 'Spot temperature data recorded with a sonde',
                  physical = physicalS,
                  attributeList = attributeListS) 

dataTableA <- new('dataTable',
                  entityName = 'SiteLevelMetadata_Simmons.csv',
                  entityDescription = 'Site level metadata',
                  physical = physicalA,
                  attributeList = attributeList2) 

dataTable1<- new('dataTable',
                 entityName = file_paths[1],
                 entityDescription = 'Stream temperature data',
                 physical = physical1[1],
                 attributeList = attributeList1)  

dataTable2 <- new('dataTable',
                  entityName = file_paths[2],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[2],
                  attributeList = attributeList1)   
   
dataTable3 <- new('dataTable',
                  entityName = file_paths[3],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[3],
                  attributeList = attributeList1)

dataTable4 <- new('dataTable',
                  entityName = file_paths[4],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[4],
                  attributeList = attributeList1)
dataTable5 <- new('dataTable',
                  entityName = file_paths[5],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[5],
                  attributeList = attributeList1)

dataTable6 <- new('dataTable',
                  entityName = file_paths[6],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[6],
                  attributeList = attributeList1)

dataTable7 <- new('dataTable',
                  entityName = file_paths[7],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[7],
                  attributeList = attributeList1)

dataTable8 <- new('dataTable',
                  entityName = file_paths[8],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[8],
                  attributeList = attributeList1)

dataTable9 <- new('dataTable',
                  entityName = file_paths[9],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[9],
                  attributeList = attributeList1)

dataTable10 <- new('dataTable',
                  entityName = file_paths[10],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[10],
                  attributeList = attributeList1)

dataTable11 <- new('dataTable',
                  entityName = file_paths[11],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[11],
                  attributeList = attributeList1)

dataTable12 <- new('dataTable',
                  entityName = file_paths[12],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[12],
                  attributeList = attributeList1)

dataTable13 <- new('dataTable',
                  entityName = file_paths[13],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[13],
                  attributeList = attributeList1)

dataTable14 <- new('dataTable',
                  entityName = file_paths[14],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[14],
                  attributeList = attributeList1)

dataTable15 <- new('dataTable',
                  entityName = file_paths[15],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[15],
                  attributeList = attributeList1)

dataTable16 <- new('dataTable',
                  entityName = file_paths[16],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[16],
                  attributeList = attributeList1)

dataTable17 <- new('dataTable',
                  entityName = file_paths[17],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[17],
                  attributeList = attributeList1)

dataTable18 <- new('dataTable',
                  entityName = file_paths[18],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[18],
                  attributeList = attributeList1)

dataTable19 <- new('dataTable',
                  entityName = file_paths[19],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[19],
                  attributeList = attributeList1)

dataTable20 <- new('dataTable',
                  entityName = file_paths[20],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[20],
                  attributeList = attributeList1)

dataTable21 <- new('dataTable',
                  entityName = file_paths[21],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[21],
                  attributeList = attributeList1)

dataTable22 <- new('dataTable',
                  entityName = file_paths[22],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[22],
                  attributeList = attributeList1)

dataTable23 <- new('dataTable',
                  entityName = file_paths[23],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[23],
                  attributeList = attributeList1)

dataTable24 <- new('dataTable',
                  entityName = file_paths[24],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[24],
                  attributeList = attributeList1)

dataTable25 <- new('dataTable',
                  entityName = file_paths[25],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[25],
                  attributeList = attributeList1)

dataTable26 <- new('dataTable',
                  entityName = file_paths[26],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[26],
                  attributeList = attributeList1)

dataTable27 <- new('dataTable',
                  entityName = file_paths[27],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[27],
                  attributeList = attributeList1)

dataTable28 <- new('dataTable',
                  entityName = file_paths[28],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[28],
                  attributeList = attributeList1)

dataTable29 <- new('dataTable',
                  entityName = file_paths[29],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[29],
                  attributeList = attributeList1)

dataTable30 <- new('dataTable',
                  entityName = file_paths[30],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[30],
                  attributeList = attributeList1)

dataTable31 <- new('dataTable',
                  entityName = file_paths[31],
                  entityDescription = 'Stream temperature data',
                  physical = physical1[31],
                  attributeList = attributeList1)

dataTable32 <- new('dataTable',
                   entityName = file_paths[32],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[32],
                   attributeList = attributeList1)

dataTable33 <- new('dataTable',
                   entityName = file_paths[33],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[33],
                   attributeList = attributeList1)

dataTable34 <- new('dataTable',
                   entityName = file_paths[34],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[34],
                   attributeList = attributeList1)

dataTable35 <- new('dataTable',
                   entityName = file_paths[35],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[35],
                   attributeList = attributeList1)

dataTable36 <- new('dataTable',
                   entityName = file_paths[36],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[36],
                   attributeList = attributeList1)

dataTable37 <- new('dataTable',
                   entityName = file_paths[37],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[37],
                   attributeList = attributeList1)

dataTable38 <- new('dataTable',
                   entityName = file_paths[38],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[38],
                   attributeList = attributeList1)

dataTable39 <- new('dataTable',
                   entityName = file_paths[39],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[39],
                   attributeList = attributeList1)

dataTable40 <- new('dataTable',
                   entityName = file_paths[40],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[40],
                   attributeList = attributeList1)

dataTable41 <- new('dataTable',
                   entityName = file_paths[41],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[41],
                   attributeList = attributeList1)

dataTable42 <- new('dataTable',
                   entityName = file_paths[42],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[42],
                   attributeList = attributeList1)

dataTable43 <- new('dataTable',
                   entityName = file_paths[43],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[43],
                   attributeList = attributeList1)

dataTable44 <- new('dataTable',
                   entityName = file_paths[44],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[44],
                   attributeList = attributeList1)

dataTable45 <- new('dataTable',
                   entityName = file_paths[45],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[45],
                   attributeList = attributeList1)

dataTable46 <- new('dataTable',
                   entityName = file_paths[46],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[46],
                   attributeList = attributeList1)

dataTable47 <- new('dataTable',
                   entityName = file_paths[47],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[47],
                   attributeList = attributeList1)

dataTable48 <- new('dataTable',
                   entityName = file_paths[48],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[48],
                   attributeList = attributeList1)

dataTable49 <- new('dataTable',
                   entityName = file_paths[49],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[49],
                   attributeList = attributeList1)

dataTable50 <- new('dataTable',
                   entityName = file_paths[50],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[50],
                   attributeList = attributeList1)

dataTable51 <- new('dataTable',
                   entityName = file_paths[51],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[51],
                   attributeList = attributeList1)

dataTable52 <- new('dataTable',
                   entityName = file_paths[52],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[52],
                   attributeList = attributeList1)

dataTable53 <- new('dataTable',
                   entityName = file_paths[53],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[53],
                   attributeList = attributeList1)

dataTable54 <- new('dataTable',
                   entityName = file_paths[54],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[54],
                   attributeList = attributeList1)

dataTable55 <- new('dataTable',
                   entityName = file_paths[55],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[55],
                   attributeList = attributeList1)

dataTable56 <- new('dataTable',
                   entityName = file_paths[56],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[56],
                   attributeList = attributeList1)

dataTable57 <- new('dataTable',
                   entityName = file_paths[57],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[57],
                   attributeList = attributeList1)

dataTable58 <- new('dataTable',
                   entityName = file_paths[58],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[58],
                   attributeList = attributeList1)

dataTable59 <- new('dataTable',
                   entityName = file_paths[59],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[59],
                   attributeList = attributeList1)

dataTable60 <- new('dataTable',
                   entityName = file_paths[60],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[60],
                   attributeList = attributeList1)

dataTable61 <- new('dataTable',
                   entityName = file_paths[61],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[61],
                   attributeList = attributeList1)

dataTable62 <- new('dataTable',
                   entityName = file_paths[62],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[62],
                   attributeList = attributeList1)

dataTable63 <- new('dataTable',
                   entityName = file_paths[63],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[63],
                   attributeList = attributeList1)

dataTable64 <- new('dataTable',
                   entityName = file_paths[64],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[64],
                   attributeList = attributeList1)

dataTable65 <- new('dataTable',
                   entityName = file_paths[65],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[65],
                   attributeList = attributeList1)

dataTable66 <- new('dataTable',
                   entityName = file_paths[66],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[66],
                   attributeList = attributeList1)

dataTable67 <- new('dataTable',
                   entityName = file_paths[67],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[67],
                   attributeList = attributeList1)

dataTable68 <- new('dataTable',
                   entityName = file_paths[68],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[68],
                   attributeList = attributeList1)

dataTable69 <- new('dataTable',
                   entityName = file_paths[69],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[69],
                   attributeList = attributeList1)

dataTable70 <- new('dataTable',
                   entityName = file_paths[70],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[70],
                   attributeList = attributeList1)

dataTable71 <- new('dataTable',
                   entityName = file_paths[71],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[71],
                   attributeList = attributeList1)

dataTable72 <- new('dataTable',
                   entityName = file_paths[72],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[72],
                   attributeList = attributeList1)

dataTable73 <- new('dataTable',
                   entityName = file_paths[73],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[73],
                   attributeList = attributeList1)

dataTable74 <- new('dataTable',
                   entityName = file_paths[74],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[74],
                   attributeList = attributeList1)

dataTable75 <- new('dataTable',
                   entityName = file_paths[75],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[75],
                   attributeList = attributeList1)

dataTable76 <- new('dataTable',
                   entityName = file_paths[76],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[76],
                   attributeList = attributeList1)

dataTable77 <- new('dataTable',
                   entityName = file_paths[77],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[77],
                   attributeList = attributeList1)

dataTable78 <- new('dataTable',
                   entityName = file_paths[78],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[78],
                   attributeList = attributeList1)

dataTable79 <- new('dataTable',
                   entityName = file_paths[79],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[79],
                   attributeList = attributeList1)

dataTable80 <- new('dataTable',
                   entityName = file_paths[80],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[80],
                   attributeList = attributeList1)

dataTable81 <- new('dataTable',
                   entityName = file_paths[81],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[81],
                   attributeList = attributeList1)

dataTable82 <- new('dataTable',
                   entityName = file_paths[82],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[82],
                   attributeList = attributeList1)

dataTable83 <- new('dataTable',
                   entityName = file_paths[83],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[83],
                   attributeList = attributeList1)

dataTable84 <- new('dataTable',
                   entityName = file_paths[84],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[84],
                   attributeList = attributeList1)

dataTable85 <- new('dataTable',
                   entityName = file_paths[85],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[85],
                   attributeList = attributeList1)

dataTable86 <- new('dataTable',
                   entityName = file_paths[86],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[86],
                   attributeList = attributeList1)

dataTable87 <- new('dataTable',
                   entityName = file_paths[87],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[87],
                   attributeList = attributeList1)

dataTable88 <- new('dataTable',
                   entityName = file_paths[88],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[88],
                   attributeList = attributeList1)

dataTable89 <- new('dataTable',
                   entityName = file_paths[89],
                   entityDescription = 'Stream temperature data',
                   physical = physical1[89],
                   attributeList = attributeList1)



eml@dataset@dataTable <- c(dataTableA, dataTableS, dataTable1, dataTable2, dataTable3, dataTable4, dataTable5, dataTable6, dataTable7, dataTable8, dataTable9, dataTable10, dataTable11, dataTable12, dataTable13, dataTable14, dataTable15, dataTable16, dataTable17, dataTable18, dataTable19, dataTable20, dataTable21, dataTable22, dataTable23, dataTable24, dataTable25, dataTable26, dataTable27, dataTable28, dataTable29, dataTable30, dataTable31, dataTable32, dataTable33, dataTable34, dataTable35, dataTable36, dataTable37, dataTable38, dataTable39, dataTable40, dataTable41, dataTable42, dataTable43, dataTable44, dataTable45, dataTable46, dataTable47, dataTable48, dataTable49, dataTable50, dataTable51, dataTable52, dataTable53, dataTable54, dataTable55, dataTable56, dataTable57, dataTable58, dataTable59, dataTable60, dataTable61, dataTable62, dataTable63, dataTable64, dataTable65, dataTable66, dataTable67, dataTable68, dataTable69, dataTable70, dataTable71, dataTable72, dataTable73, dataTable74, dataTable75, dataTable76, dataTable77, dataTable78, dataTable79, dataTable80, dataTable81, dataTable82, dataTable83, dataTable84, dataTable85, dataTable86, dataTable87, dataTable88, dataTable89)


#Set source
source('~/sasap-data/data-submission/Helpers/SasapProjectCreator.R')
eml@dataset@project <- sasap_project()

#write eml and publish update
write_eml(eml, path1)
eml_validate(path1)

ids <- publish_update(mn,
                         metadata_pid =  ids$metadata,
                         resource_map_pid = ids$resource_map,
                         metadata_path = path1,
                         data_pid = unlist(ids$data),
                         check_first = T,
                         use_doi = FALSE,
                         public = FALSE)

#set intellectual rights
rights <- new('intellectualRights', .Data = 'These data were provided by the National Park Service (NPS). Most NPS information resides in the public domain and may be used without restriction.')
eml@dataset@intellectualRights@.Data <- c(rights)
set_file_name(mn, ids$metadata, "science_metadata.xml")

#Change dataset creator
NPSadd <- new('address',
              deliveryPoint = '4175 Geist Rd',
              city = 'Fairbanks',
              administrativeArea = 'AK',
              postalCode = '99709-3420')
NPS_creator <- eml_creator(organizationName = "National Park Service, Central Alaska Network",
                           phone = "907-455-0600",
                           address = NPSadd)
#Change title
title <- new('title', .Data = 'In-situ stream temperature monitoring, central Alaska, 2008-2017')
eml@dataset@title <- c(title)

#write eml and publish update
write_eml(eml, path1)
eml_validate(path1)

ids <- publish_update(mn,
                      metadata_pid =  ids$metadata,
                      resource_map_pid = ids$resource_map,
                      metadata_path = path1,
                      data_pid = unlist(ids$data),
                      check_first = T,
                      use_doi = FALSE,
                      public = FALSE)

set_rights_and_access(mn, unlist(ids), 'CN=SASAP,DC=dataone,DC=org', permissions = c('read', 'write', 'changePermission'))

#################################################
#Change file names to name_akoatsid_start_end.csv
rs <- read.csv('/home/treeder/Trey Simmons other files/SiteLevelMetadata_Simmons.csv', stringsAsFactors= F)
A <- rs$AKOATS_ID

#call on filenames from the pids
filenames <- names(ids$data)

#file names with no underscores
nosymb <- gsub("_", "", filenames)

#separate into the three parts
justnames <- gsub("[0-9]", "", nosymb)
justnames <- gsub(".csv", "", justnames)
justnames <- gsub("DUP", "_DUP", justnames)

justAkoats <- str_sub(nosymb, end = 4)
justAkoats <- gsub("[A-z]", "", justAkoats)   

justdates <- gsub("[[:alpha:]]", "", filenames)
justdates <- gsub("[.]", "", justdates)
justdates <- str_sub(justdates, start = 8)
justdates <- gsub("^[_]", "", justdates)
justdates <- gsub("^[_]", "", justdates)

newName <- c()
for(i in 1:length(filenames)){
    for(j in 1:length(A)){
    if(grepl(A[j], filenames[i])){
        newName[i] <- paste0(justnames[i], "_", justAkoats[i], "_", justdates[i], ".csv")
    }
    }
}

data_pids <- unlist(ids$data)
data_pids <- data_pids[-c(52,90,91)]
newName <- newName[-c(52,90,91)]

#the for loop didn't work right, so will update individually
set_file_name(mn, data_pids[1], newName[1])
set_file_name(mn, data_pids[2], newName[2])
set_file_name(mn, data_pids[3], newName[3])
set_file_name(mn, data_pids[4], newName[4])
set_file_name(mn, data_pids[5], newName[5])
set_file_name(mn, data_pids[6], newName[6])
set_file_name(mn, data_pids[7], newName[7])
set_file_name(mn, data_pids[8], newName[8])
set_file_name(mn, data_pids[9], newName[9])
set_file_name(mn, data_pids[10], newName[10])
set_file_name(mn, data_pids[11], newName[11])
set_file_name(mn, data_pids[12], newName[12])
set_file_name(mn, data_pids[13], newName[13])
set_file_name(mn, data_pids[14], newName[14])
set_file_name(mn, data_pids[15], newName[15])
set_file_name(mn, data_pids[16], newName[16])
set_file_name(mn, data_pids[17], newName[17])
set_file_name(mn, data_pids[18], newName[18])
set_file_name(mn, data_pids[19], newName[19])
set_file_name(mn, data_pids[20], newName[20])
set_file_name(mn, data_pids[21], newName[21])
set_file_name(mn, data_pids[22], newName[22])
set_file_name(mn, data_pids[23], newName[23])
set_file_name(mn, data_pids[24], newName[24])
set_file_name(mn, data_pids[25], newName[25])
set_file_name(mn, data_pids[26], newName[26])
set_file_name(mn, data_pids[27], newName[27])
set_file_name(mn, data_pids[28], newName[28])
set_file_name(mn, data_pids[29], newName[29])
set_file_name(mn, data_pids[30], newName[30])
set_file_name(mn, data_pids[31], newName[31])
set_file_name(mn, data_pids[32], newName[32])
set_file_name(mn, data_pids[33], newName[33])
set_file_name(mn, data_pids[34], newName[34])
set_file_name(mn, data_pids[35], newName[35])
set_file_name(mn, data_pids[36], newName[36])
set_file_name(mn, data_pids[37], newName[37])
set_file_name(mn, data_pids[38], newName[38])
set_file_name(mn, data_pids[39], newName[39])
set_file_name(mn, data_pids[40], newName[40])
set_file_name(mn, data_pids[41], newName[41])
set_file_name(mn, data_pids[42], newName[42])
set_file_name(mn, data_pids[43], newName[43])
set_file_name(mn, data_pids[44], newName[44])
set_file_name(mn, data_pids[45], newName[45])
set_file_name(mn, data_pids[46], newName[46])
set_file_name(mn, data_pids[47], newName[47])
set_file_name(mn, data_pids[48], newName[48])
set_file_name(mn, data_pids[49], newName[49])
set_file_name(mn, data_pids[50], newName[50])
set_file_name(mn, data_pids[51], newName[51])
set_file_name(mn, data_pids[52], newName[52])
set_file_name(mn, data_pids[53], newName[53])
set_file_name(mn, data_pids[54], newName[54])
set_file_name(mn, data_pids[55], newName[55])
set_file_name(mn, data_pids[56], newName[56])
set_file_name(mn, data_pids[57], newName[57])
set_file_name(mn, data_pids[58], newName[58])
set_file_name(mn, data_pids[59], newName[59])
set_file_name(mn, data_pids[60], newName[60])
set_file_name(mn, data_pids[61], newName[61])
set_file_name(mn, data_pids[62], newName[62])
set_file_name(mn, data_pids[63], newName[63])
set_file_name(mn, data_pids[64], newName[64])
set_file_name(mn, data_pids[65], newName[65])
set_file_name(mn, data_pids[66], newName[66])
set_file_name(mn, data_pids[67], newName[67])
set_file_name(mn, data_pids[68], newName[68])
set_file_name(mn, data_pids[69], newName[69])
set_file_name(mn, data_pids[70], newName[70])
set_file_name(mn, data_pids[71], newName[71])
set_file_name(mn, data_pids[72], newName[72])
set_file_name(mn, data_pids[73], newName[73])
set_file_name(mn, data_pids[74], newName[74])
set_file_name(mn, data_pids[75], newName[75])
set_file_name(mn, data_pids[76], newName[76])
set_file_name(mn, data_pids[77], newName[77])
set_file_name(mn, data_pids[78], newName[78])
set_file_name(mn, data_pids[79], newName[79])
set_file_name(mn, data_pids[80], newName[80])
set_file_name(mn, data_pids[81], newName[81])
set_file_name(mn, data_pids[82], newName[82])
set_file_name(mn, data_pids[83], newName[83])
set_file_name(mn, data_pids[84], newName[84])
set_file_name(mn, data_pids[85], newName[85])
set_file_name(mn, data_pids[86], newName[86])
set_file_name(mn, data_pids[87], newName[87])
set_file_name(mn, data_pids[88], newName[88])


#Update abstract
ids <- publish_update(mn,
                      metadata_pid =  ids$metadata,
                      resource_map_pid = ids$resource_map,
                      metadata_path = path1,
                      data_pid = unlist(ids$data),
                      check_first = T,
                      use_doi = FALSE,
                      public = FALSE)


#need to update object for spot file
update_package_object(mn, 
                      ids$data[1], 
                      '/home/treeder/Trey Simmons other files/SpotTempData.csv', 
                      ids$resource_map, 
                      public = FALSE, 
                      use_doi = FALSE)

#load in updated metadata in case any more changes need to be made
eml <- read_eml(path1)

#publish updated LakeCreekDena_1603_2015_2017.csv
update_package_object(mn, ids$data[55], '~/TreySimmons_csv/LakeCreekDENA_1603_2015_2017.csv', ids$resource_map, public = FALSE, use_doi = FALSE)

ids <- publish_update(mn,
                      metadata_pid =  ids$metadata,
                      resource_map_pid = ids$resource_map,
                      metadata_path = path1,
                      data_pid = unlist(ids$data),
                      check_first = T,
                      use_doi = FALSE,
                      public = TRUE)


