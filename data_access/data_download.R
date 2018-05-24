#TR updates 5/24/18
####################################
####################################
# Download stream temperature data #
####################################
####################################

#This script will allow you to download and save stream temperature data files. 
#All users should run the code in the "Setup" section. After running this code, you can select which data files you want to download. To download all files see option 1. Options 2-4 allow you to select files to download by AKOATS ID (Option 2), waterbody name (Option 3), or data package (Option 4). 

####################################
# Setup
####################################

## Run the whole "Setup" section to pull in all stream temperature data pids. 

## Install libraries
install.packages("arcticdatautils")
install.packages("stringr")

## Load libraries
library("arcticdatautils")
library("stringr")

## Set to KNB node
cn <- CNode('PROD')
mn <- getMNode(cn, 'urn:node:KNB')

## Packages containing stream temperature data
ids <- c("urn:uuid:6a67fcbc-6a2e-4282-b739-486ec9bb02d0",           
         "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
         "urn:uuid:9864faef-64a9-4686-937b-555d018e1410",
         "urn:uuid:295dcc8a-cb5c-4677-8d58-01211212b9b4",
         "urn:uuid:0da185e2-2c78-4b5e-bb24-2c3863084e67")

## Get data pids
all_data_pids <- c()
for (i in 1:length(ids)){
  id_temp <- get_package(mn, ids[i], file_names = T)
  all_data_pids[[i]] <- id_temp$data
}
unl_data_pids <- unlist(all_data_pids)

## Remove data pids for files that do not contain stream temperature data
i <- grep("SiteLevel", names(unl_data_pids))
data_pids <- unl_data_pids[-i]

i <- grep("SpotTemp", names(data_pids))
data_pids <- data_pids[-i]

## Set directory where you want to save the files
directory <- "/home/treeder/scratch" #Insert working directory path here

##################################################
# Option 1: download ALL stream temperature files
##################################################

## This option allows you to download all of the available stream temperature files. 

## Create empty vectors
file.names <- c()
a <- c()

## Read and write files to the selected directory
for(i in 1:length(data_pids)){
  file.names[i] <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[i]))
  a[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
  write.csv(a[[i]], paste(directory, names(data_pids[i]), sep='/'), row.names = F)
}

########################################
# Option 2: download by AKOATS ID
########################################

## This option allows you to download files by AKOATS ID, one at a time. 

## Setup
# Create a vector of all AKOATS IDs 
ak <- gsub("[[:alpha:]]", "", names(data_pids))
ak <- gsub("^_", "", ak)
ak <- gsub("^_", "", ak)
ak <- str_sub(ak, end = 4)
ak <- gsub("_", "", ak)
AKOATS_IDs <- unique(ak)

# Create a data frame with the available AKOATS IDs and waterbodies.This dataframe can be used to select AKOATS IDs of interest
i <- grep("SiteLevel", names(unl_data_pids))
md_pids <- unl_data_pids[i]
md <- c()
md_df <- c()
for(i in 1:length(md_pids)){
  file.names[i] <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", md_pids[i]))
  md[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
}
md_df <- rbind(md[[1]], md[[2]], md[[3]], md[[4]], md[[5]])
md_df <- md_df[, c(1,13)] # Final dataframe

# View the dataframe to see AKOATS IDs of interest
View(md_df)

## Run the function to initiate
# Then run in the console using selectAKOATS(), function will prompt you for inputs. Repeat for each desired AKOATS ID. 
selectAKOATS <- function(){
  b <- c()
  x <- readline("Which AKOATS_ID do you want to download? Input one ID:")  
  x <- as.character(x)
  j <- which(ak == x)
  file.names <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[j]))
  out.names <- names(data_pids[j])
  for(i in 1:length(file.names)){
    b[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
    write.csv(b[[i]], paste(directory, out.names[i], sep='/'), row.names = F)
  }
}

#######################################
# Option 3: download by waterbody name
#######################################

## This option allows you to download files by waterbody name, one at a time. 

## Setup
# This creates a vector of all Waterbody names
wb <- gsub("[0-9]", "", names(data_pids))
wb <- gsub(".csv", "", wb)
wb <- gsub("_", "", wb)
wb <- gsub("DUP", "", wb)
Waterbody_names <- unique(wb)
# Final Vector of water body names in alphabetical order
Waterbody_names <- sort(Waterbody_names) 

## Run the function to initiate
# Then run in the console using selectWaterBody(), function will prompt you for inputs. Repeat for each desired waterbody name. 
selectWaterBody <- function(){
  b <- c()
  x <- readline("Use the 'Waterbody_names' vector to copy and paste the name you want to download. Input one name (do not use quotes):")  
  x <- as.character(x)
  j <- which(wb == x)
  file.names <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[j]))
  out.names <- names(data_pids[j])
  for(i in 1:length(file.names)){
    b[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
    write.csv(b[[i]], paste(directory, out.names[i], sep='/'), row.names = F)
  }
}

#####################################
# Option 4: download by data package
#####################################

## This option allows you to download files by AKOATS ID, one at a time. 

## Setup
#PackageName
Kodiak_Island <- all_data_pids[[1]]
North_Slope <- all_data_pids[[2]]
USFWS <- all_data_pids[[3]]
Southwest <- all_data_pids[[4]]
Central <- all_data_pids[[5]]

## Run the function to initiate
# Then run in the console using selectPackage(Package = PackageName). Set "Package" equal to the vector that represents the package of interest (See above)
selectPackage <- function(Package){
  b <- c()
  x <- Package 
  j <- which(names(data_pids) %in% names(x))
  file.names <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", data_pids[j]))
  out.names <- names(data_pids[j])
  for(i in 1:length(file.names)){
    b[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
    write.csv(b[[i]], paste(directory, out.names[i], sep='/'), row.names = F)
  }
}

#e.g. To download all files from the Kodiak Island package:
# selectPackage(Package = Kodiak_Island)

