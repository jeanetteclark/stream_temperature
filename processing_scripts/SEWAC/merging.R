m <- read.csv('/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/SEAWC_metadata.csv')

files <- dir('/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/reformatted_data/')

fileIDs <- data.frame(files = files, AKOATS_ID = c(1640, 1640,
                                                   1638, 1638, 1638, 1638,
                                                   1639, 1639,
                                                   1641, 1641,
                                                   1642, 1642,
                                                   1647, 1647,
                                                   1644,1644,
                                                   1646,1646,
                                                   1643,
                                                   1637, 1637), stringsAsFactors = F)

ids <- unique(fileIDs$AKOATS_ID)
filenames <- c('SEAWC_BlackRiver.csv', 'SEAWC_FordArm.csv', 'SEAWC_Goulding.csv', 'SEAWC_Leos.csv', 'SEAWC_Nakwasina.csv', 'SEAWC_Necker.csv', 'SEAWC_NoName.csv', 'SEAWC_SalmonLakeCreek.csv', 'SEAWC_Starrigavan.csv', 'SEAWC_Waterfall.csv')
path <- '/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/reformatted_data/'

for (z in 1:10){
    files2 <- fileIDs$files[which(fileIDs$AKOATS_ID == ids[z])]
    t <- do.call(rbind,lapply(file.path(path,files2),read.csv))
    t$SampleDateTime <- as.POSIXct(t$SampleDateTime)
    t$AKOATS_ID <- ids[z]
    i <- order(t$SampleDateTime)
    t <- t[i, ]
    write.csv(t, file.path('/home/sjclark/Stream Temperature/Southeast Alaska Watershed Coalition/merged_data/', filenames[z]), row.names = F)
    
    
}