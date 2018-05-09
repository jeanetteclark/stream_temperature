################
#Issue #168: NPS SW Alaska Stream Temperature
#Data Cleaning - AKOATS 1523
#April 2018
#Sophia Tao
################



library(tidyr)

# read in file
ID1523 <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs/1523.csv", na.strings = "")

# delete unnecessary rows & Grades columns 
ID1523 <- ID1523[-(1:2),-c(4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46)]

# change column names to standard column names
colnames(ID1523) <- c('sampleDate', 'sampleTime', 'Temp', 'UseData', 'Temp5', 'UseData5', 'Temp10', 'UseData10', 'Temp20', 'UseData20', 'Temp30', 'UseData30', 'Temp40', 'UseData40', 'Temp50', 'UseData50', 'Temp60', 'UseData60', 'Temp70', 'UseData70', 'Temp80', 'UseData80', 'Temp90', 'UseData90')

# gather
ID1523 <- ID1523 %>%
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
    gather(key = Depth, 
           -sampleDate, -sampleTime,
           value = Temp_UseData) %>%
    separate(Temp_UseData, c("Temp", "UseData"), sep = "_")

# replace with proper depth value
ID1523$Depth[ID1523$Depth == "Temp_UseData"] <- 0 
ID1523$Depth[ID1523$Depth == "Temp5_UseData5"] <- 5
ID1523$Depth[ID1523$Depth == "Temp10_UseData10"] <- 10
ID1523$Depth[ID1523$Depth == "Temp20_UseData20"] <- 20
ID1523$Depth[ID1523$Depth == "Temp30_UseData30"] <- 30
ID1523$Depth[ID1523$Depth == "Temp40_UseData40"] <- 40
ID1523$Depth[ID1523$Depth == "Temp50_UseData50"] <- 50
ID1523$Depth[ID1523$Depth == "Temp60_UseData60"] <- 60
ID1523$Depth[ID1523$Depth == "Temp70_UseData70"] <- 70
ID1523$Depth[ID1523$Depth == "Temp80_UseData80"] <- 80
ID1523$Depth[ID1523$Depth == "Temp90_UseData90"] <- 90

#replace UseData values of '3' (approved) with '1' 
ID1523$UseData <- gsub("3", "1", ID1523$UseData)
# change UseData values of '4' (rejected) to '0'
ID1523$UseData <- gsub("4", "0", ID1523$UseData)
# replace UseData values of 'NA' to '0'
ID1523$UseData[ID1523$UseData == "NA"] <- 0

# reformat Date
ID1523$sampleDate <- strptime(as.character(ID1523$sampleDate), "%m/%d/%y")
ID1523$sampleDate <- format(ID1523$sampleDate, "%Y-%m-%d")

# add 'AKOATS_ID' attribute
ID1523$AKOATS_ID <- '1523'

# rearrange columns
colnames(ID1523) <- c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'UseData', 'AKOATS_ID')
ID1523 <- ID1523[, c('sampleDate', 'sampleTime', 'Depth', 'Temperature', 'AKOATS_ID', 'UseData')]

# write csv
write.csv(ID1523,'/home/stao/my-sasap/168_streamTemp_NPS_SW/csvs-formatted/1523.csv', row.names = F)


