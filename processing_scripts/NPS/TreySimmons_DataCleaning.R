##################
# Tessa Reeder
# SASAP Ticket #140
# NPS Stream Temperature
##################

library(readxl)
library(stringr)
library(dplyr)
library(tidyr)

#Read in metadata file for site IDs
md <- read_excel('/home/treeder/Trey Simmons other files/AKOATS_metadata_Simmons_updated_7-26-17.xlsx', sheet = 2)

#Create a subset of the sites relevant to this dataset
relevant.sites <- subset(md, AKOATS_ID > 1588 & AKOATS_ID <1614)
relevant.sites <- relevant.sites[,-39]

#change inflow to Inflow
relevant.sites$SiteID[16] <- "Wonder Lake Inflow"

#write csv
write.csv(relevant.sites, '/home/treeder/Trey Simmons other files/SiteLevelMetadata_Simmons.csv', row.names = F)

#Set working directory
setwd('/home/treeder/TreySimmons_xlsx')

#Define file type to look for and read in (for the stream temp files)
file.list <- list.files(pattern='*.xlsx')
df.list <- sapply(file.list, read_excel, simplify=FALSE)

#Remove first row from some files
x <- c(24,27,35,37,41,59,70,74,75,76,83)
for(i in x){
  df.list[[i]]<-read_excel(file.list[i], skip=1)
}

#Edit file names 
files <- dir('/home/treeder/TreySimmons_xlsx')
fileIDs <- data.frame(files = files, FileNum = c(1:89), stringsAsFactors = F)
ids <- unique(fileIDs$FileNum)
names <- fileIDs$files
names <- gsub("[-]","_", names)
names <- gsub('_TRIMMED',"",names)
names <- gsub("[.]","",names)
names <- str_sub(names, start= 18)
names <- gsub("^\\P{L}*", "", names, perl=T)
names <- gsub(" ","_", names)
names <- gsub('xlsx',".csv",names)
names(df.list) <- names

#Make names match
relevant.sites$SiteID <- gsub(" ","_",relevant.sites$SiteID)

#Fix errors in name 
relevant.sites$SiteID[25] <- "Wonder_Lake_Inflow"
relevant.sites$SiteID[18] <- "EF_Toklat_Trib"
relevant.sites$SiteID[24] <- "Savage_River"

#Put Akoats ID in file name 
y<-c()
newName <-c()
for(i in 1:length(names)){
  for(j in 1:length(relevant.sites$SiteID)){
    if(grepl(relevant.sites$SiteID[j], names[i])){
      newName[i] <- paste0(relevant.sites$AKOATS_ID[j], "_", relevant.sites$SiteID[j] )
      y[i] = gsub(relevant.sites$SiteID[j], replacement = newName[i], x = names[i])
    }  
  }
}

#Long Lake Creek got confused with Lake Creek
y<- gsub('Long_1603_Lake_Creek','1591_Long_Lake_Creek',y)
names(df.list) <- y
names <- names(df.list)


#Select AKOATS_IDs for each file and create AKOATS_ID column and UseData column
AKOATS_ID <-c()
UseData <- c()
for(i in 1:length(names)){
  AKOATS_ID[i] <- str_sub(names[i], start=1, end=4)
  UseData[i] <- '1'
  df.list[[i]] <- cbind(df.list[[i]], AKOATS_ID[i], UseData[i])
}  

#Remove"_" from relevant.sites
relevant.sites$SiteID <- gsub("[_]"," ", relevant.sites$SiteID)

#Separate Date and Time where necessary
sampleDate <- as.Date(df.list[[4]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[4]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[4]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[4]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[5]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[5]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[5]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[5]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[7]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[7]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[7]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[7]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[8]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[8]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[8]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[8]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[9]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[9]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[9]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[9]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[10]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[10]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[10]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[10]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[13]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[13]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[13]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[13]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[14]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[14]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[14]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[14]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[15]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[15]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[15]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[15]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[18]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[18]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[18]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[18]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[19]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[19]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[19]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[19]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[20]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[20]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[20]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[20]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[24]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[24]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[24]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[24]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[25]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[25]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[25]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[25]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[26]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[26]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[26]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[26]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[27]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[27]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[27]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[27]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[28]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[28]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[28]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[28]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[29]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[29]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[29]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[29]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[30]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[30]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[30]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[30]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[33]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[33]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[33]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[33]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[34]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[34]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[34]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[34]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[37]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[37]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[37]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[37]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[39]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[39]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[39]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[39]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[40]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[40]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[40]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[40]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[41]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[41]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[41]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[41]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[42]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[42]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[42]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[42]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[43]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[43]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[43]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[43]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[47]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[47]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[47]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[47]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[48]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[48]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[48]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[48]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[49]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[49]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[49]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[49]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[53]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[53]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[53]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[53]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[57]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[57]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[57]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[57]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[58]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[58]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[58]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[58]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[59]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[59]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[59]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[59]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[63]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[63]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[63]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[63]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[66]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[66]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[66]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[66]]<- cbind(sampleDate, sampleTime, z)
colnames(df.list[[66]])<- c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID","UseData")

sampleDate <- as.Date(df.list[[67]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[67]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[67]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[67]]<- cbind(sampleDate, sampleTime, z)
colnames(df.list[[67]])<- c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID","UseData")

sampleDate <- as.Date(df.list[[70]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[70]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[70]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[70]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[73]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[73]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[73]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[73]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[74]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[74]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[74]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[74]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[80]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[80]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[80]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[80]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[81]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[81]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[81]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[81]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[82]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[82]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[82]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[82]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[83]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[83]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[83]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[83]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[85]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[85]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[85]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[85]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[87]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[87]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[87]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[87]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[88]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[88]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[88]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[88]]<- cbind(sampleDate, sampleTime, z)

sampleDate <- as.Date(df.list[[89]]$`Date Time, GMT-08:00`)
sampleTime <- format(as.POSIXct(df.list[[89]]$`Date Time, GMT-08:00`) ,format = "%H:%M:%S") 
z <- subset(df.list[[89]], select = -c(`#`, `Date Time, GMT-08:00`) )
df.list[[89]]<- cbind(sampleDate, sampleTime, z)

#Rename Columns
for(i in 1:length(df.list)){
  colnames(df.list[[i]])<- c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID","UseData")
}

#Write csvs
for(i in 1:length(df.list)){
  write.csv(df.list[[i]], file.path('/home/treeder/TreySimmons_csv/', names[i]), row.names = F) 
}


####################Read spot data
spot1 <- read.csv('/home/treeder/Trey Simmons other files/Spot temp data for hobotemps.csv', stringsAsFactors = F)

#fix site names
spot1$Sitename <- gsub("  "," ", spot1$Sitename)
spot1$Sitename <- ifelse(spot1$Sitename == 'E.F. Toklat trib', 'East Fork Toklat River tributary', spot1$Sitename)
spot1$Sitename[2] <- 'Rock Creek WRST' #based on Sitecode
spot1 <- spot1[-c(174:175), ]
spot1$Sitename <- gsub("@", "at", spot1$Sitename)

#change time format to hh:mm    
spot1$Hobo.time..ADT. <- format(as.POSIXlt(spot1$Hobo.time..ADT., format = "%H:%M"), format = "%H:%M")
spot1$Sonde.time..ADT. <- format(as.POSIXlt(spot1$Sonde.time..ADT., format = "%H:%M"), format = "%H:%M")

#change date format
library(lubridate)
spot1$Date <- mdy(spot1$Date)


#Unify missing value codes in sonde.temp
spot1$sonde.temp <- ifelse(spot1$sonde.temp == "DRY", "NR", spot1$sonde.temp)

#Add in Akoats
spot1$AKOATS_ID <- 'TEST'
for(i in 1:173){
    for(j in 1:length(relevant.sites$AKOATS_ID)){
        if(grepl(relevant.sites$SiteID[j], spot1$Sitename[i])){
            spot1$AKOATS_ID[i]<- relevant.sites$AKOATS_ID[j]
        }
    }
}


colnames(spot1)<- c('siteCode','siteName','Hobo_SN','sampleDate','HoboTime_ADT','HoboTemp','sondeTime_ADT','sondeTemp','ABS_diff','Hobo-Sonde','notes','AKOATS_ID')
spot1 <- spot1[c(1,2,12,3,4,5,6,7,8,9,10,11)]
write.csv(spot1, '/home/treeder/Trey Simmons other files/SpotTempData.csv', row.names = F)

################################
#Fix LC DENA 2015-2017 

#read csv
lc <- read.csv('~/TreySimmons_csv/1603_Lake_Creek_DENA_2015_2017.csv', stringsAsFactors = F)
lc <- lc[,-4]
colnames(lc) <- c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID","UseData")
write.csv(lc, '~/TreySimmons_csv/LakeCreekDENA_1603_2015_2017.csv', row.names = F)
