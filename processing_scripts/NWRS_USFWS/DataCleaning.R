files <- dir('~/Desktop/USFWS_WRB_formatted_Data/')

fileIDs <- data.frame(files = files, FileNum = c(1:14), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- c("USFWS_WRB_Site_571001154134300.csv", "USFWS_WRB_Site_571221154040300.csv",
               "USFWS_WRB_Site_571359154244300.csv", "USFWS_WRB_Site_572656154082400.csv",
               "USFWS_WRB_Site_580223156504500.csv", "USFWS_WRB_Site_623819141014500.csv",
               "USFWS_WRB_Site_623944141034900.csv", "USFWS_WRB_Site_625113141273500.csv",
               "USFWS_WRB_Site_655930151520700.csv", "USFWS_WRB_Site_660145152074900.csv",
               "USFWS_WRB_Site_661223151051100.csv", "USFWS_WRB_Site_661747151065800.csv",
               "USFWS_WRB_Site_665105151054300.csv", "USFWS_WRB_Site_665429151405100.csv")
path <- '~/Desktop/USFWS_WRB_formatted_Data/'

for (z in 1:14){
  files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
  t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
  t$SampleDateTime <- as.POSIXct(paste(t$Date, t$Time), format="%m/%d/%y %H:%M:%S")
  t$Temperature <- t$Water_Temperature_C
  i <- order(t$SampleDateTime)
  t <- t[i, ]
  t <- t[,c(4,5)]
  write.csv(t, file.path('~/Desktop/USFWS_WRB_formatted_Data/', filenames[z]), row.names = F)
  
  
}
