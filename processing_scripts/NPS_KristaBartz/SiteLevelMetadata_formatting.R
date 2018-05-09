################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - Site level metadata
#March-April 2018
#Sophia Tao
################



library(readxl)
library(tidyr)
library(dplyr)
library(eeptools)

# Read in metadata file for site IDs
md <- read_excel('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw3/AKOATS_NPS_SWAN_DATA_Apr2018_update_KB (1).xlsx', 
                 sheet = 1, 
                 col_names = T, 
                 trim_ws = T)

# Sort data 
md <- md[order(md$seq_id),]

# delete unnecessary rows and columns
md <- md[-c(3,6:7,10,12,14:16,26:39),-c(2,40)]

# rename columns
colnames(md)[colnames(md) == "seq_id"] <- "AKOATS_ID"
colnames(md)[colnames(md) == "Agency_ID"] <- "SiteID"
colnames(md)[colnames(md) == "Initial_date"] <- "start_date"

# index site ID's to assign new AKOATS ID's
a <- which(md$SiteID == "LACL_lkijr_stream_water")
b <- which(md$SiteID == "LACL_tazir_stream_water")
c <- which(md$SiteID == "LACL_tlikr_stream_water")

# replace indexed values with proper AKOATS ID's
md$AKOATS_ID[a] <- "1939"
md$AKOATS_ID[b] <- "1940"
md$AKOATS_ID[c] <- "1941"

# Write csv for metadata spreadsheet
write.csv(md, '/home/stao/my-sasap/168_streamTemp_NPS_SW/SiteLevelMetadata_Bartz.csv', row.names = F)



