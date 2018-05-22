#TR updates 5/17/18
#STILL A WORK IN PROGRESS

###################################
# Download stream temperature data
###################################

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
ids <- c("urn:uuid:66c0bbbb-3cad-4c25-9979-4af62184da07",           
         "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
         "urn:uuid:9864faef-64a9-4686-937b-555d018e1410",
         "urn:uuid:295dcc8a-cb5c-4677-8d58-01211212b9b4",
         "urn:uuid:63477beb-4135-4fbd-b847-86d5f9f00992")

## Get data pids
all_data_pids <- c()
for (i in 1:4){
  id_temp <- get_package(mn, ids[i], file_names = T)
  all_data_pids[[i]] <- id_temp$data
}
all_data_pids <- unlist(all_data_pids)

## Remove data pids for files that do not contain stream temperature data
i <- grep("SiteLevel", names(all_data_pids))
data_pids <- all_data_pids[-i]

##########Need to check if this file got removed or something
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

## Set up
# Create a vector of all AKOATS IDs 
ak <- gsub("[[:alpha:]]", "", names(data_pids))
ak <- gsub("^_", "", ak)
ak <- gsub("^_", "", ak)
ak <- str_sub(ak, end = 4)
ak <- gsub("_", "", ak)
AKOATS_IDs <- unique(ak)

# Create a data frame with the available AKOATS IDs and waterbodies.This dataframe can be used to select AKOATS IDs of interest
i <- grep("SiteLevel", names(all_data_pids))
md_pids <- all_data_pids[i]

md <- c()
for(i in 1:length(md_pids)){
  file.names[i] <- (paste0("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/", md_pids[i]))
  md[[i]]<- read.csv(file.names[i], stringsAsFactors = F)
}

l <- length(md)
md_df <- rbind(md[[1]], md[[2]], md[[3]], md[[4]])
md_df <- md_df[, c(1,13)]

# View the dataframe to see AKOATS IDs of interest
View(md_df)

#set working directory
directory <- "/home/treeder/scratch" #Insert working directory path here

# Run the function to initiate
# The run in the console using selectAKOATS()
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

#need to figure out how to add checks for it it isnt an ID

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



