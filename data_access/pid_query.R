#PID Query


library(arcticdatautils)
library(ggplot2)
library(dataone)
library(dplyr)
library(tidyr)


cn <- CNode("PROD")
mn <- getMNode(cn, paste('urn:node:',"KNB", sep = ""))

ids <- c("doi:10.5063/F1028PR9",
         "doi:10.5063/F10P0X83",
         "doi:10.5063/F1W0944C",
         "urn:uuid:6a67fcbc-6a2e-4282-b739-486ec9bb02d0",
         "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
         "urn:uuid:f69e1996-e46f-4c67-9963-5c0c3bc8671a",
         "urn:uuid:a98c0f5d-a5e6-49ae-8aa2-132875d35476",
         "urn:uuid:cb0d6944-db7f-438e-8a82-ec4c39972c1b",
         "urn:uuid:b63d3d3f-f745-425f-a69f-998154895f40")

data_pids <- c()
for (i in 1:length(ids)){
  id_temp <- get_package(mn, ids[i], file_names = T)
  data_pids[[i]] <- id_temp$data
}
data_pids <- unlist(data_pids)

i <- grep("SiteLevel", names(data_pids))
temp_pids <- data_pids[-i]
site_info <- data_pids[i]

i <- grep("SpotTemp", names(temp_pids))
temp_pids <- temp_pids[-i]

url_base <- "https://knb.ecoinformatics.org/knb/d1/mn/v2/object/"

temp_pids <- data.frame(FileName = names(temp_pids), pid = unname(temp_pids), stringsAsFactors = F) %>% 
  #warning here about dropping the .csv piece - this is okay
  separate(FileName, into = c("Waterbody", "AKOATS_ID", "Start_Year", "End_Year"), remove = F) %>% 
  mutate(AKOATS_ID = as.numeric(AKOATS_ID)) %>% 
  mutate(URL =  paste0(url_base, pid))



sites <- c()
for (i in 1:length(site_info)){
  t <- read.csv(paste0(url_base, site_info[i]))
  sites <- bind_rows(sites, t)
  
}

sites <- sites %>% 
  select(AKOATS_ID, Contact_person, Contact_email, Latitude, Longitude)

temp_pids_joined <- left_join(temp_pids, sites)
