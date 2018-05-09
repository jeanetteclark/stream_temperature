files <- dir('~/Desktop/FQ_formatted_Data/')

#column names should be:
#AKOATS_ID
#sampleDateTime
#Temperature
#UseData - 0 == bad data, 1 == good data

#derive UseData from their internal QA flags
#get AKOATS ID from metadata document

fileIDs <- data.frame(files = files, FileNum = c(1:3), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- c("FQ_IndianRiver_2016.csv", "FQ_SalmonRiver_2016.csv", "FQ_TaiyaRiver_2016.csv")
path <- '~/Desktop/FQ_formatted_Data/'

for (z in 1:3){
  files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
  t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
  t$SampleDateTime <-  as.POSIXct(t$DateTime, format="%m/%d/%y %H:%M:%S")
  colnames(t)[6] <- "Temperature"
  i <- order(t$SampleDateTime)
  t <- t[i, ]
  #fix path name to write to somewhere you know where it is here:
  write.csv(t, file.path('~/Desktop/FQ_formatted_Data/', filenames[z]), row.names = F)
  
}
