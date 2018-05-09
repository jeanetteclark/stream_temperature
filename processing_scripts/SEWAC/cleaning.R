#Reading and reformatting SEWAC temperature data
library(stringi)
library(chron)


files <- dir('/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/raw_data/', full.names = T)
filenames <- dir('/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/raw_data/')


path <- '~/Stream Temperature/Southeast Alaska Watershed Coalition/raw_data/black_river_a_2016-07-09.csv'
outpath <- '/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/reformatted_data/'
    
reformat_clean <- function(path, path2, filename){
    t <- read.csv(path, skip = 23, header = F, stringsAsFactors = F)
    
    installdate <- read.csv(path, skip = 7, header = F, stringsAsFactors = F, nrows = 1)
    installdate <- installdate$V1
    installdate <- as.character(gsub("Install date and time: ", '', installdate))
    if (nchar(installdate) == 10){
        installdate <- as.POSIXct(installdate, format = "%Y-%m-%d")+ (8*60*60)
    }else {
        installdate <- paste(substr(installdate, 1, 13), ":", substr(installdate, 14, 15), sep = "")
        installdate <- as.POSIXct(installdate, format = "%Y-%m-%d %H:%M")+ (8*60*60)
    }
    
    
    
    
    t$V1 <- as.numeric(t$V1)
    t <- t[which(is.na(t$V1) == FALSE), ] #remove header data that is mixed in with real data
    t <- t[, c(2,3)]; colnames(t) <- c('SampleDateTime', 'Temperature')
    t$Temperature <- as.numeric(t$Temperature)
    t$SampleDateTime <- as.POSIXct(t$SampleDateTime, format = "%m/%d/%Y %H:%M") + (8*60*60) # original timezone is GMT-8, convert to GMT
    i <- which(t$SampleDateTime > installdate) #remove data prior to sensor installation
    t <- t[i, ] 
    write.csv(t, file.path(path2,filename),row.names = FALSE)
    
}


for (i in 1:length(files)){
    reformat_clean(files[i], outpath, filenames[i])
}


