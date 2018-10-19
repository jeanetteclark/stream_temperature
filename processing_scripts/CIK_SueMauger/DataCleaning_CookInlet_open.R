
library(datamgmt)
library(readxl)
library(tidyverse)

# Convert excel files to csv ####
temp <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK Cook Inlet open water only sites", full.names = T)

for (i in 1:length(temp)){
    excel_to_csv(path = temp[i], directory = "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater")
}

# Data cleaning ####
files <- dir('/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater')

fileIDs <- data.frame(files = files, FileNum = c(1:142), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater")
path <- '/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater'

for (z in 1:142){
    files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
    t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
    colnames(t) <- c("sampleDate", "sampleTime", "Temperature")
    t$sampleTime <- as.POSIXct(t$sampleTime, format = "%Y-%m-%d %H:%M:%S")
    t$sampleTime <- format(t$sampleTime, "%H:%M:%S")
    t <- unite(t, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
    t$`Date Time` <- as.POSIXct(t$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming all files' original timezone is GMT-8, convert to GMT
    t <- separate(t, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
    t$UseData <- "1"
    write.csv(t, file.path('/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_formatted', filenames[z]), row.names = F)
}



# Read in individual files to merge later on ####
setwd("/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_formatted")

a1 <- read.csv("./CIK_0_05_2009.csv", stringsAsFactors = F)
a2 <- read.csv("./CIK_0_05_2010.csv", stringsAsFactors = F)
a3 <- read.csv("./CIK_0_05_2011.csv", stringsAsFactors = F)
a4 <- read.csv("./CIK_0_05_2012.csv", stringsAsFactors = F)

b1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_16_07_2008.csv", stringsAsFactors = F)
b1[,4] <- NULL
colnames(b1) <- c("sampleDate", "sampleTime", "Temperature")
b1$sampleTime <- as.POSIXct(b1$sampleTime, format = "%Y-%m-%d %H:%M:%S")
b1$sampleTime <- format(b1$sampleTime, "%H:%M:%S")
b1 <- unite(b1, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
b1$`Date Time` <- as.POSIXct(b1$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
b1 <- separate(b1, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
b1$UseData <- "1"

b2 <- read.csv("./CIK_16_05_2009.csv", stringsAsFactors = F)
b3 <- read.csv("./CIK_16_05_2010.csv", stringsAsFactors = F)
b4 <- read.csv("./CIK_16_05_2011.csv", stringsAsFactors = F)
b5 <- read.csv("./CIK_16_05_2012.csv", stringsAsFactors = F)

c1 <- read.csv("./CIK_17_06_2008.csv", stringsAsFactors = F)
c2 <- read.csv("./CIK_17_05_2009.csv", stringsAsFactors = F)
c3 <- read.csv("./CIK_17_05_2010.csv", stringsAsFactors = F)
c4 <- read.csv("./CIK_17_05_2011.csv", stringsAsFactors = F)
c5 <- read.csv("./CIK_17_05_2012.csv", stringsAsFactors = F)

d1 <- read.csv("./CIK_18_06_2008.csv", stringsAsFactors = F)
d2 <- read.csv("./CIK_18_06_2009.csv", stringsAsFactors = F)
d3 <- read.csv("./CIK_18_06_2010.csv", stringsAsFactors = F)
d4 <- read.csv("./CIK_18_06_2011.csv", stringsAsFactors = F)
d5 <- read.csv("./CIK_18_06_2012.csv", stringsAsFactors = F)

e1 <- read.csv("./CIK_19_06_2008.csv", stringsAsFactors = F)
e2 <- read.csv("./CIK_19_06_2009.csv", stringsAsFactors = F)
e3 <- read.csv("./CIK_19_06_2010.csv", stringsAsFactors = F)
e4 <- read.csv("./CIK_19_06_2011.csv", stringsAsFactors = F)
e5 <- read.csv("./CIK_19_06_2012.csv", stringsAsFactors = F)

f1 <- read.csv("./CIK_1_05_2008.csv", stringsAsFactors = F)
f2 <- read.csv("./CIK_1_05_2009.csv", stringsAsFactors = F)
f3 <- read.csv("./CIK_1_05_2010.csv", stringsAsFactors = F)
f4 <- read.csv("./CIK_1_05_2011.csv", stringsAsFactors = F)

g1 <- read.csv("./CIK_20_05_2008.csv", stringsAsFactors = F)
g2 <- read.csv("./CIK_20_06_2009.csv", stringsAsFactors = F)
g3 <- read.csv("./CIK_20_06_2010.csv", stringsAsFactors = F)
g4 <- read.csv("./CIK_20_06_2011.csv", stringsAsFactors = F)
g5 <- read.csv("./CIK_20_06_2012.csv", stringsAsFactors = F)

h1 <- read.csv("./CIK_21_05_2008.csv", stringsAsFactors = F)
h2 <- read.csv("./CIK_21_06_2009.csv", stringsAsFactors = F)
h3 <- read.csv("./CIK_21_06_2010.csv", stringsAsFactors = F)
h4 <- read.csv("./CIK_21_06_2011.csv", stringsAsFactors = F)
h5 <- read.csv("./CIK_21_06_2012.csv", stringsAsFactors = F)

j1 <- read.csv("./CIK_22_06_2008.csv", stringsAsFactors = F)
j2 <- read.csv("./CIK_22_05_2009.csv", stringsAsFactors = F)
j3 <- read.csv("./CIK_22_05_2010.csv", stringsAsFactors = F)
j4 <- read.csv("./CIK_22_08_2011.csv", stringsAsFactors = F)

k1 <- read.csv("./CIK_24_05_2009.csv", stringsAsFactors = F)
k2 <- read.csv("./CIK_24_05_2010.csv", stringsAsFactors = F)
k3 <- read.csv("./CIK_24_05_2011.csv", stringsAsFactors = F)
k4 <- read.csv("./CIK_24_06_2012.csv", stringsAsFactors = F)

l1 <- read.csv("./CIK_25_06_2008.csv", stringsAsFactors = F)
l2 <- read.csv("./CIK_25_07_2009.csv", stringsAsFactors = F)
l3 <- read.csv("./CIK_25_05_2010.csv", stringsAsFactors = F)
l4 <- read.csv("./CIK_25_08_2011.csv", stringsAsFactors = F)
l5 <- read.csv("./CIK_25_05_2012.csv", stringsAsFactors = F)

m1 <- read.csv("./CIK_26_06_2008.csv", stringsAsFactors = F)
m2 <- read.csv("./CIK_26_05_2009.csv", stringsAsFactors = F)
m3 <- read.csv("./CIK_26_05_2010.csv", stringsAsFactors = F)
m4 <- read.csv("./CIK_26_05_2011.csv", stringsAsFactors = F)
m5 <- read.csv("./CIK_26_05_2012.csv", stringsAsFactors = F)

n1 <- read.csv("./CIK_27_06_2008.csv", stringsAsFactors = F)
n2 <- read.csv("./CIK_27_05_2009.csv", stringsAsFactors = F)
n3 <- read.csv("./CIK_27_05_2010.csv", stringsAsFactors = F)
n4 <- read.csv("./CIK_27_05_2011.csv", stringsAsFactors = F)

o1 <- read.csv("./CIK_29_06_2008.csv", stringsAsFactors = F)
o2 <- read.csv("./CIK_29_05_2009.csv", stringsAsFactors = F)
o3 <- read.csv("./CIK_29_05_2010.csv", stringsAsFactors = F)
o4 <- read.csv("./CIK_29_07_2011.csv", stringsAsFactors = F)
o5 <- read.csv("./CIK_29_06_2012.csv", stringsAsFactors = F)

p1 <- read.csv("/home/stao/my-sasap/stemp_SueMauger_CIK/CIK_2_05_2008.csv", stringsAsFactors = F) 
p1[,4] <- NULL
colnames(p1) <- c("sampleDate", "sampleTime", "Temperature")
p1$sampleTime <- as.POSIXct(p1$sampleTime, format = "%Y-%m-%d %H:%M:%S")
p1$sampleTime <- format(p1$sampleTime, "%H:%M:%S")
p1 <- unite(p1, "Date Time", c("sampleDate", "sampleTime"), sep = " ")
p1$`Date Time` <- as.POSIXct(p1$`Date Time`, format = "%Y-%m-%d %H:%M:%S") + (8*60*60)  # assuming original timezone is GMT-8, convert to GMT
p1 <- separate(p1, `Date Time`, c("sampleDate", "sampleTime"), sep = " ")
p1$UseData <- "1"

p2 <- read.csv("./CIK_2_05_2009.csv", stringsAsFactors = F)
p3 <- read.csv("./CIK_2_05_2010.csv", stringsAsFactors = F)

q1 <- read.csv("./CIK_31_06_2008.csv", stringsAsFactors = F)
q2 <- read.csv("./CIK_31_05_2009.csv", stringsAsFactors = F)
q3 <- read.csv("./CIK_31_05_2010.csv", stringsAsFactors = F)
q4 <- read.csv("./CIK_31_05_2011.csv", stringsAsFactors = F)
q5 <- read.csv("./CIK_31_05_2012.csv", stringsAsFactors = F)

r1 <- read.csv("./CIK_32_05_2009.csv", stringsAsFactors = F)
r2 <- read.csv("./CIK_32_05_2010.csv", stringsAsFactors = F)
r3 <- read.csv("./CIK_32_06_2011.csv", stringsAsFactors = F)

s1 <- read.csv("./CIK_33_06_2008.csv", stringsAsFactors = F)
s2 <- read.csv("./CIK_33_05_2009.csv", stringsAsFactors = F)
s3 <- read.csv("./CIK_33_05_2010.csv", stringsAsFactors = F)
s4 <- read.csv("./CIK_33_05_2011.csv", stringsAsFactors = F)

u1 <- read.csv("./CIK_34_06_2008.csv", stringsAsFactors = F)
u2 <- read.csv("./CIK_34_06_2009.csv", stringsAsFactors = F)
u3 <- read.csv("./CIK_34_05_2010.csv", stringsAsFactors = F)
u4 <- read.csv("./CIK_34_05_2011.csv", stringsAsFactors = F)

v1 <- read.csv("./CIK_36_06_2008.csv", stringsAsFactors = F)
v2 <- read.csv("./CIK_36_05_2009.csv", stringsAsFactors = F)
v3 <- read.csv("./CIK_36_05_2010.csv", stringsAsFactors = F)
v4 <- read.csv("./CIK_34_05_2011.csv", stringsAsFactors = F)

w1 <- read.csv("./CIK_37_06_2008.csv", stringsAsFactors = F)
w2 <- read.csv("./CIK_37_06_2009.csv", stringsAsFactors = F)
w3 <- read.csv("./CIK_37_05_2010.csv", stringsAsFactors = F)
w4 <- read.csv("./CIK_37_05_2011.csv", stringsAsFactors = F)

x1 <- read.csv("./CIK_39_06_2008.csv", stringsAsFactors = F)
x2 <- read.csv("./CIK_39_05_2009.csv", stringsAsFactors = F)
x3 <- read.csv("./CIK_39_05_2010.csv", stringsAsFactors = F)
x4 <- read.csv("./CIK_39_05_2011.csv", stringsAsFactors = F)
x5 <- read.csv("./CIK_39_05_2012.csv", stringsAsFactors = F)

y1 <- read.csv("./CIK_40_06_2008.csv", stringsAsFactors = F)
y2 <- read.csv("./CIK_40_05_2009.csv", stringsAsFactors = F)
y3 <- read.csv("./CIK_40_05_2010.csv", stringsAsFactors = F)
y4 <- read.csv("./CIK_40_05_2011.csv", stringsAsFactors = F)
y5 <- read.csv("./CIK_40_05_2012.csv", stringsAsFactors = F)

z1 <- read.csv("./CIK_41_06_2008.csv", stringsAsFactors = F)
z2 <- read.csv("./CIK_41_05_2009.csv", stringsAsFactors = F)
z3 <- read.csv("./CIK_41_05_2010.csv", stringsAsFactors = F)
z4 <- read.csv("./CIK_41_07_2011.csv", stringsAsFactors = F)
z5 <- read.csv("./CIK_41_06_2012.csv", stringsAsFactors = F)

aa1 <- read.csv("./CIK_42_06_2008.csv", stringsAsFactors = F)
aa2 <- read.csv("./CIK_42_06_2009.csv", stringsAsFactors = F)
aa3 <- read.csv("./CIK_42_06_2010.csv", stringsAsFactors = F)
aa4 <- read.csv("./CIK_42_06_2011.csv", stringsAsFactors = F)

ab1 <- read.csv("./CIK_43_06_2008.csv", stringsAsFactors = F)
ab2 <- read.csv("./CIK_43_05_2009.csv", stringsAsFactors = F)
ab3 <- read.csv("./CIK_43_05_2011.csv", stringsAsFactors = F)
ab4 <- read.csv("./CIK_43_05_2012.csv", stringsAsFactors = F)

ac1 <- read.csv("./CIK_44_07_2008.csv", stringsAsFactors = F)
ac2 <- read.csv("./CIK_44_06_2009.csv", stringsAsFactors = F)
ac3 <- read.csv("./CIK_44_06_2010.csv", stringsAsFactors = F)
ac4 <- read.csv("./CIK_44_06_2011.csv", stringsAsFactors = F)
ac5 <- read.csv("./CIK_44_06_2012.csv", stringsAsFactors = F)

ad1 <- read.csv("./CIK_45_07_2008.csv", stringsAsFactors = F)
ad2 <- read.csv("./CIK_45_06_2010.csv", stringsAsFactors = F)
ad3 <- read.csv("./CIK_45_06_2011.csv", stringsAsFactors = F)

ae1 <- read.csv("./CIK_46_07_2008.csv", stringsAsFactors = F)
ae2 <- read.csv("./CIK_46_06_2010.csv", stringsAsFactors = F)
ae3 <- read.csv("./CIK_46_05_2011.csv", stringsAsFactors = F)

af1 <- read.csv("./CIK_47_06_2008.csv", stringsAsFactors = F)
af2 <- read.csv("./CIK_47_06_2009.csv", stringsAsFactors = F)
af3 <- read.csv("./CIK_47_06_2010.csv", stringsAsFactors = F)
af4 <- read.csv("./CIK_47_06_2011.csv", stringsAsFactors = F)
af5 <- read.csv("./CIK_47_06_2012.csv", stringsAsFactors = F)

ag1 <- read.csv("./CIK_48_06_2008.csv", stringsAsFactors = F)
ag2 <- read.csv("./CIK_48_06_2009.csv", stringsAsFactors = F)
ag3 <- read.csv("./CIK_48_06_2010.csv", stringsAsFactors = F)
ag4 <- read.csv("./CIK_48_06_2011.csv", stringsAsFactors = F)

ah1 <- read.csv("./CIK_5_06_2008.csv", stringsAsFactors = F)
ah2 <- read.csv("./CIK_5_05_2009.csv", stringsAsFactors = F)
ah3 <- read.csv("./CIK_5_05_2010.csv", stringsAsFactors = F)
ah4 <- read.csv("./CIK_5_05_2011.csv", stringsAsFactors = F)
ah5 <- read.csv("./CIK_5_05_2012.csv", stringsAsFactors = F)

ai1 <- read.csv("./CIK_7_06_2008.csv", stringsAsFactors = F)
ai2 <- read.csv("./CIK_7_05_2009.csv", stringsAsFactors = F)
ai3 <- read.csv("./CIK_7_05_2010.csv", stringsAsFactors = F)
ai4 <- read.csv("./CIK_7_05_2011.csv", stringsAsFactors = F)



# Merge files that are same site ####
a <- rbind(a1,a2,a3,a4)
b <- rbind(b1,b2,b3,b4,b5)
c <- rbind(c1,c2,c3,c4,c5)
d <- rbind(d1,d2,d3,d4,d5)
e <- rbind(e1,e2,e3,e4,e5)
f <- rbind(f1,f2,f3,f4)
g <- rbind(g1,g2,g3,g4,g5)
h <- rbind(h1,h2,h3,h4,h5)
j <- rbind(j1,j2,j3,j4)
k <- rbind(k1,k2,k3,k4)
l <- rbind(l1,l2,l3,l4,l5)
m <- rbind(m1,m2,m3,m4,m5)
n <- rbind(n1,n2,n3,n4)
o <- rbind(o1,o2,o3,o4,o5)
p <- rbind(p1,p2,p3)
q <- rbind(q1,q2,q3,q4,q5)
r <- rbind(r1,r2,r3)
s <- rbind(s1,s2,s3,s4)
u <- rbind(u1,u2,u3,u4)
v <- rbind(v1,v2,v3,v4)
w <- rbind(w1,w2,w3,w4)
x <- rbind(x1,x2,x3,x4,x5)
y <- rbind(y1,y2,y3,y4,y5)
z <- rbind(z1,z2,z3,z4,z5)
aa <- rbind(aa1,aa2,aa3,aa4)
ab <- rbind(ab1,ab2,ab3,ab4)
ac <- rbind(ac1,ac2,ac3,ac4,ac5)
ad <- rbind(ad1,ad2,ad3)
ae <- rbind(ae1,ae2,ae3)
af <- rbind(af1,af2,af3,af4,af5)
ag <- rbind(ag1,ag2,ag3,ag4)
ah <- rbind(ah1,ah2,ah3,ah4,ah5)
ai <- rbind(ai1,ai2,ai3,ai4)

# add AKOATS IDs
a$AKOATS_ID <- "1401"
b$AKOATS_ID <- "1392"
c$AKOATS_ID <- "1383"
d$AKOATS_ID <- "1368"
e$AKOATS_ID <- "1369"
f$AKOATS_ID <- "1397"
g$AKOATS_ID <- "1380"
h$AKOATS_ID <- "1381"
j$AKOATS_ID <- "1387"
k$AKOATS_ID <- "1375"
l$AKOATS_ID <- "1413"
m$AKOATS_ID <- "1411"
n$AKOATS_ID <- "1405"
o$AKOATS_ID <- "1414"
p$AKOATS_ID <- "1393"
q$AKOATS_ID <- "1402"
r$AKOATS_ID <- "1403"
s$AKOATS_ID <- "1412"
u$AKOATS_ID <- "1409"
v$AKOATS_ID <- "1408"
w$AKOATS_ID <- "1406"
x$AKOATS_ID <- "1416"
y$AKOATS_ID <- "1417"
z$AKOATS_ID <- "1418"
aa$AKOATS_ID <- "1400"
ab$AKOATS_ID <- "1415"
ac$AKOATS_ID <- "1398"
ad$AKOATS_ID <- "1394"
ae$AKOATS_ID <- "1377"
af$AKOATS_ID <- "1366"
ag$AKOATS_ID <- "1364"
ah$AKOATS_ID <- "1388"
ai$AKOATS_ID <- "1391"

# save merged files into formatted folder
write.csv(a, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/BodenburgCreek_1401_2009_2012.csv", row.names = F)
write.csv(b, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ResurrectionCreek_1392_2008_2012.csv", row.names = F)
write.csv(c, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/HiddenCreek_1383_2008_2012.csv", row.names = F)
write.csv(d, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/EnglishBayRiver_1368_2008_2012.csv", row.names = F)
write.csv(e, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/SeldoviaRiver_1369_2008_2012.csv", row.names = F)
write.csv(f, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ShipCreek_1397_2008_2011.csv", row.names = F)
write.csv(g, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/NikolaiCreek_1380_2008_2012.csv", row.names = F)
write.csv(h, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ShantatalikCreek_1381_2008_2012.csv", row.names = F)
write.csv(j, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/QuartzCreek_1387_2008_2011.csv", row.names = F)
write.csv(k, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/FoxCreek_1375_2009_2012.csv", row.names = F)
write.csv(l, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/MooseCreek_1413_2008_2012.csv", row.names = F)
write.csv(m, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ChijukCreek_1411_2008_2012.csv", row.names = F)
write.csv(n, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/MeadowCreek_1405_2008_2011.csv", row.names = F)
write.csv(o, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/TrapperCreek_1414_2008_2012.csv", row.names = F)
write.csv(p, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/RabbitCreek_1393_2008_2010.csv", row.names = F)
write.csv(q, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/CottonwoodCreek_1402_2008_2012.csv", row.names = F)
write.csv(r, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/JimCreek_1403_2009_2011.csv", row.names = F)
write.csv(s, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/MontanaCreek_1412_2008_2011.csv", row.names = F)
write.csv(u, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/WillowCreek_1409_2008_2011.csv", row.names = F)
write.csv(v, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/DeceptionCreek_1408_2008_2011.csv", row.names = F)
write.csv(w, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/MooseCreek_1406_2008_2011.csv", row.names = F)
write.csv(x, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/TroublesomeCreek_1416_2008_2012.csv", row.names = F)
write.csv(y, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ByersCreek_1417_2008_2012.csv", row.names = F)
write.csv(z, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/EastForkChulitna_1418_2008_2012.csv", row.names = F)
write.csv(aa, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/AlexanderCreek_1400_2008_2011.csv", row.names = F)
write.csv(ab, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/CacheCreek_1415_2008_2012.csv", row.names = F)
write.csv(ac, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/TheodoreCreek_1398_2008_2012.csv", row.names = F)
write.csv(ad, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ChuitnaRiver_1394_2008_2011.csv", row.names = F)
write.csv(ae, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/SilverSalmonCreek_1377_2008_2011.csv", row.names = F)
write.csv(af, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/ChenikCreek_1366_2008_2012.csv", row.names = F)
write.csv(ag, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/McNeilRiver_1364_2008_2011.csv", row.names = F)
write.csv(ah, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/MooseRiver_1388_2008_2012.csv", row.names = F)
write.csv(ai, "/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish/SwansonRiver_1391_2008_2011.csv", row.names = F)

# rearrange columns
files <- dir('/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish')

fileIDs <- data.frame(files = files, FileNum = c(1:33), stringsAsFactors = F)

ids <- unique(fileIDs$FileNum)
filenames <- list.files("/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish")
path <- '/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish'

for (z in 1:33){
    files2 <- fileIDs$files[which(fileIDs$FileNum == ids[z])]
    t <- do.call(data.frame,lapply(file.path(path,files2), read.csv))
    t <- t[,c("sampleDate", "sampleTime", "Temperature", "AKOATS_ID", "UseData")]
    write.csv(t, file.path('/home/stao/my-sasap/stemp_SueMauger_CIK/OpenWater_publish', filenames[z]), row.names = F)
}
