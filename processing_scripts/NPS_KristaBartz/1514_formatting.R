################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1514
#March-April 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1514 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1514.csv", na.strings = "")

# delete unnecessary rows & Grades columns 
ID1514 <- ID1514[-(1:2),-c(3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57)]

# change column names to standard column names
colnames(ID1514) <- c('dateTime', 'Temp', 'UseData', 'Temp5', 'UseData5', 'Temp10', 'UseData10', 'Temp20', 'UseData20', 'Temp30', 'UseData30', 'Temp40', 'UseData40', 'Temp50', 'UseData50', 'Temp60', 'UseData60', 'Temp70', 'UseData70', 'Temp80', 'UseData80', 'Temp90', 'UseData90', 'Temp100', 'UseData100', 'Temp120', 'UseData120', 'Temp140', 'UseData140', 'Temp160', 'UseData160', 'Temp180', 'UseData180', 'Temp200', 'UseData200', 'Temp220', 'UseData220', 'Temp240', 'UseData240')

# gather
ID1514 <- ID1514 %>%
    unite(Temp_UseData, Temp, UseData, sep = "_") %>%
    unite(Temp5_UseData5, Temp5, UseData5, sep = "_") %>%
    unite(Temp10_UseData10, Temp10, UseData10, sep = "_") %>%
    unite(Temp20_UseData20, Temp20, UseData20, sep = "_") %>%
    unite(Temp30_UseData30, Temp30, UseData30, sep = "_") %>%
    unite(Temp40_UseData40, Temp40, UseData40, sep = "_") %>%
    unite(Temp50_UseData50, Temp50, UseData50, sep = "_") %>%
    unite(Temp60_UseData60, Temp60, UseData60, sep = "_") %>%
    unite(Temp70_UseData70, Temp70, UseData70, sep = "_") %>%
    unite(Temp80_UseData80, Temp80, UseData80, sep = "_") %>%
    unite(Temp90_UseData90, Temp90, UseData90, sep = "_") %>%
    unite(Temp100_UseData100, Temp100, UseData100, sep = "_") %>%
    unite(Temp120_UseData120, Temp120, UseData120, sep = "_") %>%
    unite(Temp140_UseData140, Temp140, UseData140, sep = "_") %>%
    unite(Temp160_UseData160, Temp160, UseData160, sep = "_") %>%
    unite(Temp180_UseData180, Temp180, UseData180, sep = "_") %>%
    unite(Temp200_UseData200, Temp200, UseData200, sep = "_") %>%
    unite(Temp220_UseData220, Temp220, UseData220, sep = "_") %>%
    unite(Temp240_UseData240, Temp240, UseData240, sep = "_") %>%
    gather(key = Depth, 
           -dateTime,
           value = Temp_UseData) %>%
    separate(Temp_UseData, c("Temp", "UseData"), sep = "_")

# replace with proper depth value
ID1514$Depth[ID1514$Depth == "Temp_UseData"] <- 0 
ID1514$Depth[ID1514$Depth == "Temp5_UseData5"] <- 5
ID1514$Depth[ID1514$Depth == "Temp10_UseData10"] <- 10
ID1514$Depth[ID1514$Depth == "Temp20_UseData20"] <- 20
ID1514$Depth[ID1514$Depth == "Temp30_UseData30"] <- 30
ID1514$Depth[ID1514$Depth == "Temp40_UseData40"] <- 40
ID1514$Depth[ID1514$Depth == "Temp50_UseData50"] <- 50
ID1514$Depth[ID1514$Depth == "Temp60_UseData60"] <- 60
ID1514$Depth[ID1514$Depth == "Temp70_UseData70"] <- 70
ID1514$Depth[ID1514$Depth == "Temp80_UseData80"] <- 80
ID1514$Depth[ID1514$Depth == "Temp90_UseData90"] <- 90
ID1514$Depth[ID1514$Depth == "Temp100_UseData100"] <- 100
ID1514$Depth[ID1514$Depth == "Temp120_UseData120"] <- 120
ID1514$Depth[ID1514$Depth == "Temp140_UseData140"] <- 140
ID1514$Depth[ID1514$Depth == "Temp160_UseData160"] <- 160
ID1514$Depth[ID1514$Depth == "Temp180_UseData180"] <- 180
ID1514$Depth[ID1514$Depth == "Temp200_UseData200"] <- 200
ID1514$Depth[ID1514$Depth == "Temp220_UseData220"] <- 220
ID1514$Depth[ID1514$Depth == "Temp240_UseData240"] <- 240

#replace UseData values of '3' (approved) with '1' 
ID1514$UseData <- gsub("3", "1", ID1514$UseData)
# change UseData values of '4' (rejected) to '0'
ID1514$UseData <- gsub("4", "0", ID1514$UseData)
# replace UseData values of 'NA' to '0'
ID1514$UseData[ID1514$UseData == "NA"] <- 0

# separate dateTime into sampleDate and sampleTime
ID1514 <- separate(ID1514, dateTime, into = c("sampleDate", "sampleTime"), sep = " ")
# reformat Date
ID1514$sampleDate <- strptime(as.character(ID1514$sampleDate), "%m/%d/%y")
ID1514$sampleDate <- format(ID1514$sampleDate, "%Y-%m-%d")
# reformat Time
ID1514$sampleTime <- strptime(as.character(ID1514$sampleTime), "%H:%M")
ID1514$sampleTime <- format(ID1514$sampleTime, "%H:%M:%S")

# add 'AKOATS_ID' attribute
ID1514$AKOATS_ID <- '1514'

# rearrange columns
colnames(ID1514) <- c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'UseData', 'AKOATS_ID')
ID1514 <- ID1514[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

# write csv
write.csv(ID1514,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1514.csv', row.names = F)


