#PID Query


library(arcticdatautils)
library(ggplot2)
library(dataone)


cn <- CNode("PROD")
mn <- getMNode(cn, paste('urn:node:',"KNB", sep = ""))

ids <- c("urn:uuid:66c0bbbb-3cad-4c25-9979-4af62184da07",           
         "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
         "urn:uuid:9864faef-64a9-4686-937b-555d018e1410",
         "urn:uuid:295dcc8a-cb5c-4677-8d58-01211212b9b4",
         "urn:uuid:63477beb-4135-4fbd-b847-86d5f9f00992")

data_pids <- c()
for (i in 1:4){
  id_temp <- get_package(mn, ids[i], file_names = T)
  data_pids[[i]] <- id_temp$data
}
data_pids <- unlist(data_pids)

i <- grep("SiteLevel", names(data_pids))
data_pids <- data_pids[-i]
i <- grep("SpotTemp", names(data_pids))
data_pids <- data_pids[-i]

data_pids <- data.frame(FileName = names(data_pids), pid = unname(data_pids), stringsAsFactors = F)
