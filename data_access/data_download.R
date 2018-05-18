#TR updates 5/17/18
#STILL A WORK IN PROGRESS

###################################
# Download stream temperature data
###################################

## Install libraries
install.packages("arcticdatautils")

## Load libraries
library("arcticdatautils")
library("stringr")

## Set to KNB node
cn <- CNode('PROD')
mn <- getMNode(cn, 'urn:node:KNB')

## Packages containing stream temperature data
ids <- c("urn:uuid:66c0bbbb-3cad-4c25-9979-4af62184da07",           
         "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
         "urn:uuid:9864faef-64a9-4686-937b-555d018e1410",
         "urn:uuid:295dcc8a-cb5c-4677-8d58-01211212b9b4",
         "urn:uuid:63477beb-4135-4fbd-b847-86d5f9f00992")

## Get data pids
data_pids <- c()
for (i in 1:4){
  id_temp <- get_package(mn, ids[i], file_names = T)
  data_pids[[i]] <- id_temp$data
}
data_pids <- unlist(data_pids)

## Remove data pids for files that do not contain stream temperature data
i <- grep("SiteLevel", names(data_pids))
data_pids <- data_pids[-i]
i <- grep("SpotTemp", names(data_pids))
data_pids <- data_pids[-i]

###########################################
# To download ALL stream temperature files
###########################################

# Create empty vectors
file.names <- c()
a <- c()

# Set working directory where you want to save the files
directory <- "/home/treeder/scratch" #Insert working directory path here

# Read and write files to the selected directory
for(i in 1:length(data_pids)){
  file.names[i] <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[i]))
  a[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
  write.csv(a[[i]], paste(directory, names(data_pids[i]), sep='/'), row.names = F)
}

########################################
# To download by AKOATSID
########################################

# This creates a vector of all AKOATS IDs 
ak <- gsub("[[:alpha:]]", "", names(data_pids))
ak <- gsub("^_", "", ak)
ak <- gsub("^_", "", ak)
ak <- str_sub(ak, end = 4)
ak <- gsub("_", "", ak)
AKOATS_IDs <- unique(ak)

# Create empty vectors
a <- c()

# Set working directory where you want to save the files
directory <- "/home/treeder/scratch" #Insert working directory path here

# Read and write files to the selected directory
downloadByAkoats <- function(Ak_ID){ 
  j <- which(ak == Ak_ID)
  file.names <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[j]))
  for(i in 1:length(file.names)){
    a[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
    write.csv(a[[i]], paste(directory, names(data_pids[i]), sep='/'), row.names = F)
    }
}

downloadByAkoats(Ak_ID = "1594") ##### this didn't work right 

#####################################
# To download by water body name
#####################################

# This creates a vector of all Waterbody names
wb <- gsub("[0-9]", "", names(data_pids))
wb <- gsub(".csv", "", wb)
wb <- gsub("_", "", wb)
wb <- gsub("DUP", "", wb)
Waterbody_names <- unique(wb)

####################################
# To download by data package
####################################



