#PID Query


library(arcticdatautils)
library(ggplot2)
library(dataone)


cn <- CNode("PROD")
mn <- getMNode(cn, paste('urn:node:',"KNB", sep = ""))

ids <- c("urn:uuid:ab948ece-eede-4f7f-bc03-756b50b6e7b4",
         "urn:uuid:148c64a3-c4ff-4b0f-b3bf-e3b3f14b088b",
         "urn:uuid:295dcc8a-cb5c-4677-8d58-01211212b9b4",
         "urn:uuid:cfee4086-62cf-482b-b1c6-b7194bfd095b")

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