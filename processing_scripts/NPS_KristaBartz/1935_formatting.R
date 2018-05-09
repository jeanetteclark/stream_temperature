# Issue #168: NPS SW Alaska Stream Temperature
# Data Cleaning - AKOATS 1935
# April 2018
# Sophia Tao



library(tidyr)

#### Read in 2014-2015 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_porta_beach_water_20150516raw.csv", 
              sep = ",",
              na.strings = "", 
              strip.white = T,
              skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")

# add in AKOATS column
t$AKOATS_ID <- '1935'

# add in UseData column
t$UseData <- '0'
# index entries with usable data - data after 2014-10-30 11:00:00 are air temps because lake level dropped below logger
a <- which(t$SampleDateTime == "2014-10-30 00:00:00")
b <- which(t$SampleDateTime == "2014-10-30 1:00:00")
c <- which(t$SampleDateTime == "2014-10-30 2:00:00")
d <- which(t$SampleDateTime == "2014-10-30 3:00:00")
e <- which(t$SampleDateTime == "2014-10-30 4:00:00")
f <- which(t$SampleDateTime == "2014-10-30 5:00:00")
g <- which(t$SampleDateTime == "2014-10-30 6:00:00")
h <- which(t$SampleDateTime == "2014-10-30 7:00:00")
i <- which(t$SampleDateTime == "2014-10-30 8:00:00")
j <- which(t$SampleDateTime == "2014-10-30 9:00:00")
k <- which(t$SampleDateTime == "2014-10-30 10:00:00")
# use indices to replace '0' with '1'
t$UseData[a] <- '1'
t$UseData[b] <- '1'
t$UseData[c] <- '1'
t$UseData[d] <- '1'
t$UseData[e] <- '1'
t$UseData[f] <- '1'
t$UseData[g] <- '1'
t$UseData[h] <- '1'
t$UseData[i] <- '1'
t$UseData[j] <- '1'
t$UseData[k] <- '1'

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# index entries with usable data - data after 2014-10-30 11:00:00 are air temps because lake level dropped below logger
l <- which(t$sampleDate == "2014-10-01")
m <- which(t$sampleDate == "2014-10-02")
n <- which(t$sampleDate == "2014-10-03")
o <- which(t$sampleDate == "2014-10-04")
p <- which(t$sampleDate == "2014-10-05")
q <- which(t$sampleDate == "2014-10-06")
r <- which(t$sampleDate == "2014-10-07")
s <- which(t$sampleDate == "2014-10-08")
u <- which(t$sampleDate == "2014-10-09")
v <- which(t$sampleDate == "2014-10-10")
w <- which(t$sampleDate == "2014-10-11")
x <- which(t$sampleDate == "2014-10-12")
y <- which(t$sampleDate == "2014-10-13")
z <- which(t$sampleDate == "2014-10-14")
aa <- which(t$sampleDate == "2014-10-15")
ab <- which(t$sampleDate == "2014-10-16")
ac <- which(t$sampleDate == "2014-10-17")
ad <- which(t$sampleDate == "2014-10-18")
ae <- which(t$sampleDate == "2014-10-19")
af <- which(t$sampleDate == "2014-10-20")
ag <- which(t$sampleDate == "2014-10-21")
ah <- which(t$sampleDate == "2014-10-22")
ai <- which(t$sampleDate == "2014-10-23")
aj <- which(t$sampleDate == "2014-10-24")
ak <- which(t$sampleDate == "2014-10-25")
al <- which(t$sampleDate == "2014-10-26")
am <- which(t$sampleDate == "2014-10-27")
an <- which(t$sampleDate == "2014-10-28")
ao <- which(t$sampleDate == "2014-10-29")
# use index to replace NA with '0'
t$UseData[l] <- '1'
t$UseData[m] <- '1'
t$UseData[n] <- '1'
t$UseData[o] <- '1'
t$UseData[p] <- '1'
t$UseData[q] <- '1'
t$UseData[r] <- '1'
t$UseData[s] <- '1'
t$UseData[u] <- '1'
t$UseData[v] <- '1'
t$UseData[w] <- '1'
t$UseData[x] <- '1'
t$UseData[y] <- '1'
t$UseData[z] <- '1'
t$UseData[aa] <- '1'
t$UseData[ab] <- '1'
t$UseData[ac] <- '1'
t$UseData[ad] <- '1'
t$UseData[ae] <- '1'
t$UseData[af] <- '1'
t$UseData[ag] <- '1'
t$UseData[ah] <- '1'
t$UseData[ai] <- '1'
t$UseData[aj] <- '1'
t$UseData[ak] <- '1'
t$UseData[al] <- '1'
t$UseData[am] <- '1'
t$UseData[an] <- '1'
t$UseData[ao] <- '1'

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1935_1.csv', row.names = F)



#### Read in 2016-2017 file ####
t <- read.csv("/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/LACL_porta_beach_water_20160513raw.csv", na.strings = "", skip = 1)

# delete unnecessary column
t <- t[,-(1)]

# change column names
colnames(t) <- c('SampleDateTime', 'Temperature')

# specify SampleDateTime format
t$SampleDateTime <- strptime(as.character(t$SampleDateTime), "%m/%d/%y %I:%M:%S %p")

# add in UseData column
t$UseData <- '1'

# separate SampleDateTime into sampleDate and sampleTime
t <- separate(t, SampleDateTime, into = c("sampleDate", "sampleTime"), sep = " ")

# add in AKOATS column
t$AKOATS_ID <- '1935' 

#write csv
write.csv(t, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1935_2.csv', row.names = F)



#### Merge 2 files ####
data1 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1935_1.csv', header = T)
data2 <- read.csv('/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2/1935_2.csv', header = T)
fulldata <- rbind(data1, data2)

# rearrange columns
fulldata <- fulldata[,c('sampleDate', 'sampleTime', 'Temperature', 'AKOATS_ID', 'UseData')]

write.csv(fulldata, '/home/stao/my-sasap/168_streamTemp_NPS_SW/raw2-formatted/1935.csv', row.names = F)


