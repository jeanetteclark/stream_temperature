
library(tidyverse)

files <- dir('/home/stao/my-sasap/stemp_SueMauger_CIK/CIK Bristol Bay village and lodge sites')

fileIDs <- data.frame(files = files, FileNum = c(1:27), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- c("Big Creek_Naknek_09_2016.csv", 
               "Copper River_08_2016.csv", 
               "Gibraltar River_08_2016.csv", 
               "Lost Dog Creek_08_2016.csv", 
               "McGeary Creek_08_2016.csv",
               "Napotoli Creek_06_2014.csv", "Napotoli Creek_06_2015.csv", "Napotoli Creek_06_2016.csv", "Napotoli Creek_06_2017.csv",
               "Neilson Creek_05_2015.csv", "Neilson Creek_06_2014.csv", 
               "Panaruqak Creek_06_2014.csv", "Panaruqak Creek_06_2015.csv", "Panaruqak Creek_07_2014.csv",
               "Silver Salmon Creek_05_2015.csv", "Silver Salmon Creek_05_2016.csv", "Silver Salmon Creek_06_2014.csv",
               "Sivanguq Creek_06_2014.csv", "Sivanguq Creek_06_2015.csv", "Sivanguq Creek_06_2016.csv", "Sivanguq Creek_06_2017.csv", "Sivanguq Creek_10_2016.csv",
               "Squaw Creek_05_2015.csv", "Squaw Creek_06_2014.csv",
               "Tunravik Creek_06_2014.csv", 
               "Yellow Creek_05_2016.csv", "Yellow Creek_06_2015.csv")
path <- '/home/stao/my-sasap/stemp_SueMauger_CIK/CIK Bristol Bay village and lodge sites'

for (z in 1:27){
    files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
    t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
    t <- unite(t, "Date Time", c("Date", "Time..GMT.08.00"), sep = " ")
    t$`Date Time` <- as.POSIXct(t$`Date Time`, format = "%m/%d/%Y %H:%M") + (8*60*60)  # original timezone is GMT-8, convert to GMT
    t <- separate(t, `Date Time`, c("Date", "Time"), sep = " ")
    colnames(t) <- c("sampleDate", "sampleTime", "Temperature")
    write.csv(t, file.path('/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted', filenames[z]), row.names = F)
    
}


# reformat the rest of Bristol Bay files
a <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/Big Creek_06_2014.csv")
b <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/Big Creek_06_2015.csv")
colnames(a) <- c("Date", "Time", "Temperature")
colnames(b) <- c("Date", "Time", "Temperature")
c <- rbind(a,b)
c <- unite(c, "Date Time", c("Date", "Time"), sep = " ")
c$`Date Time` <- as.POSIXct(c$`Date Time`, format = "%m/%d/%Y %H:%M") + (8*60*60)
c <- separate(c, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
c$AKOATS_ID <- "1784"
c$UseData <- "1"
write.csv(c, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/BigCreek_1784_2014_2016.csv", row.names = F)


# Merge files that are the same site ####
d1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Napotoli Creek_06_2014.csv")
d2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Napotoli Creek_06_2015.csv")
d3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Napotoli Creek_06_2016.csv")
d4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Napotoli Creek_06_2017.csv")
d <- rbind(d1,d2,d3,d4)
d$AKOATS_ID <- "1373"
d$UseData <- "1"
write.csv(d, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/NapotoliCreek_1373_2014_2017.csv", row.names = F)

e1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Neilson Creek_05_2015.csv")
e2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Neilson Creek_06_2014.csv")
e <- rbind(e2,e1)
e$AKOATS_ID <- "1365"
e$UseData <- "1"
write.csv(e, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/NeilsonCreek_1365_2014_2016.csv", row.names = F)

f1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Panaruqak Creek_06_2014.csv")
f2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Panaruqak Creek_06_2015.csv")
f3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Panaruqak Creek_07_2014.csv")
f <- rbind(f1,f3,f2)
f$AKOATS_ID <- "1370"
f$UseData <- "1"
write.csv(f, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/PanaruqakCreek_1370_2014_2016.csv", row.names = F)

g1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Silver Salmon Creek_05_2015.csv")
g2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Silver Salmon Creek_05_2016.csv")
g3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Silver Salmon Creek_06_2014.csv")
g3$NA. <- NULL
g3$NA..1 <- NULL
g <- rbind(g3,g1,g2)
g$AKOATS_ID <- "1367"
g$UseData <- "1"
write.csv(g, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/SilverSalmonCreek_1367_2014_2016.csv", row.names = F)

h1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Sivanguq Creek_06_2014.csv")
h2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Sivanguq Creek_06_2015.csv")
h3 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Sivanguq Creek_06_2016.csv")
h4 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Sivanguq Creek_06_2017.csv")
h5 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Sivanguq Creek_10_2016.csv")
h <- rbind(h1,h2,h3,h5,h4)
h$AKOATS_ID <- "1372"
h$UseData <- "1"
write.csv(h, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/SivanguqCreek_1372_2014_2017.csv", row.names = F)

j1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Squaw Creek_05_2015.csv")
j2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Squaw Creek_06_2014.csv")
j <- rbind(j2,j1)
j$AKOATS_ID <- "1363"
j$UseData <- "1"
write.csv(j, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/SquawCreek_1363_2014_2016.csv", row.names = F)

k1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Yellow Creek_05_2016.csv")
k2 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_formatted/Yellow Creek_06_2015.csv")
k <- rbind(k2,k1)
k$AKOATS_ID <- "1616"
k$UseData <- "1"
write.csv(k, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/YellowCreek_1616_2015_2017.csv", row.names = F)

# Add in AKOATS_ID and UseData columns to files that don't have them ####
l <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/BigCreek_1943_2016_2016.csv")
l$AKOATS_ID <- "1943"
l$UseData <- "1"
write.csv(l, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/BigCreek_1943_2016_2016.csv", row.names = F)

m <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/CopperRiver_1828_2016_2016.csv")
m$AKOATS_ID <- "1828"
m$UseData <- "1"
write.csv(m, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/CopperRiver_1828_2016_2016.csv", row.names = F)

n <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/GibraltarRiver_1829_2016_2016.csv")
n$AKOATS_ID <- "1829"
n$UseData <- "1"
write.csv(n, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/GibraltarRiver_1829_2016_2016.csv", row.names = F)

o <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/LostDogCreek_1830_2016_2016.csv")
o$AKOATS_ID <- "1830"
o$UseData <- "1"
write.csv(o, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/LostDogCreek_1830_2016_2016.csv", row.names = F)

p <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/McGearyCreek_1831_2016_2016.csv")
p$AKOATS_ID <- "1831"
p$UseData <- "1"
write.csv(p, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/McGearyCreek_1831_2016_2016.csv", row.names = F)

q <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/TunravikCreek_1371_2014_2014.csv")
q$AKOATS_ID <- "1371"
q$UseData <- "1"
write.csv(q, "/home/stao/my-sasap/stemp_SueMauger_CIK/BristolBay_publish/TunravikCreek_1371_2014_2014.csv", row.names = F)
