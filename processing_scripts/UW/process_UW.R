# Process UW stream temperature data

library(dataone)
library(EML)
library(arcticdatautils)
library(datamgmt)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)


# Reformat data files

files <- list.files("../../../files/Stream_Temperature/UW/raw", full.names = TRUE)
data <- lapply(files, read_csv)
for (i in seq_along(data)) names(data)[i] <- data[[i]][1, 4]

# Make common changes across data files
data <- lapply(data, function(x) select(x, "AKOATS_ID" = 1, "sampleDate" = 5, "sampleTime" = 6, "Temperature" = 7) %>%
                 mutate("sampleDate" = mdy(sampleDate)))

# Little Togiak A Beach
data[[1]]$AKOATS_ID <- "853"
plot(data[[1]]$sampleDate, data[[1]]$Temperature)
data[[1]]$UseData <- 1
summary(data[[1]])

# Nerka Allah Creek
data[[2]]$AKOATS_ID <- "834"
plot(data[[2]]$sampleDate, data[[2]]$Temperature)
data[[2]]$UseData <- ifelse(data[[2]]$Temperature < 1, 0, 1)
summary(data[[2]])

# Beverley B12 Creek???
data[[3]]$AKOATS_ID <- NA
plot(data[[3]]$sampleDate, data[[3]]$Temperature)
data[[3]]$UseData <- 1
summary(data[[3]])

# Nerka Beaver Creek
data[[4]]$AKOATS_ID <- "849"
plot(data[[4]]$sampleDate, data[[4]]$Temperature)
data[[4]]$UseData <- ifelse(data[[4]]$Temperature < 1, 0, 1)
summary(data[[4]])

# Nerka Bug Creek
data[[5]]$AKOATS_ID <- "839"
plot(data[[5]]$sampleDate, data[[5]]$Temperature)
data[[5]]$UseData <- ifelse(data[[5]]$Temperature < 1, 0, 1)
summary(data[[5]])

# Little Togiak C Creek
data[[6]]$AKOATS_ID <- "856"
plot(data[[6]]$sampleDate, data[[6]]$Temperature)
data[[6]]$UseData <- ifelse(data[[6]]$Temperature < 1, 0, 1)
summary(data[[6]])

# Nerka Chamee Creek???
data[[7]]$AKOATS_ID <- NA
plot(data[[7]]$sampleDate, data[[7]]$Temperature)
data[[7]]$UseData <- ifelse(data[[7]]$Temperature > 11, 0, 1)
summary(data[[7]])

# Nerka Coffee Creek???
data[[8]]$AKOATS_ID <- NA
plot(data[[8]]$sampleDate, data[[8]]$Temperature)
data[[8]]$UseData <- ifelse(data[[8]]$Temperature < 1 | data[[8]]$Temperature > 14, 0, 1)
summary(data[[8]])

# Nerka Cottonwood Creek
data[[9]]$AKOATS_ID <- "862"
plot(data[[9]]$sampleDate, data[[9]]$Temperature)
data[[9]]$UseData <- 1
summary(data[[9]])

# Nerka Elva Creek Lower
data[[10]]$AKOATS_ID <- "855"
plot(data[[10]]$sampleDate, data[[10]]$Temperature)
data[[10]]$UseData <- ifelse(data[[10]]$Temperature < 1, 0, 1)
summary(data[[10]])

# Nerka Fenno Creek
data[[11]]$AKOATS_ID <- "833"
plot(data[[11]]$sampleDate, data[[11]]$Temperature)
data[[11]]$UseData <- ifelse(data[[11]]$Temperature < 1 | data[[11]]$Temperature > 20, 0, 1)
summary(data[[11]])

# Kulik Grant River
data[[12]]$AKOATS_ID <- "873"
plot(data[[12]]$sampleDate, data[[12]]$Temperature)
data[[12]]$UseData <- ifelse(data[[12]]$Temperature < 1, 0, 1)
summary(data[[12]])

# Nerka Hidden Lake Creek
data[[13]]$AKOATS_ID <- "846"
plot(data[[13]]$sampleDate, data[[13]]$Temperature)
data[[13]]$UseData <- ifelse(data[[13]]$Temperature < 1, 0, 1)
summary(data[[13]])

# Beverley Hope Creek
data[[14]]$AKOATS_ID <- "864"
plot(data[[14]]$sampleDate, data[[14]]$Temperature)
data[[14]]$UseData <- ifelse(data[[14]]$Temperature < 1, 0, 1)
summary(data[[14]])

# Nerka Joe Creek
data[[15]]$AKOATS_ID <- "859"
plot(data[[15]]$sampleDate, data[[15]]$Temperature)
data[[15]]$UseData <- ifelse(data[[15]]$Temperature < 1 | data[[15]]$Temperature > 15, 0, 1)
summary(data[[15]])

# Kulik K-3 Creek
data[[16]]$AKOATS_ID <- "874"
plot(data[[16]]$sampleDate, data[[16]]$Temperature)
data[[16]]$UseData <- ifelse(data[[16]]$Temperature < 1, 0, 1)
summary(data[[16]])

# Nerka Kema Creek Lower
data[[17]]$AKOATS_ID <- "847"
plot(data[[17]]$sampleDate, data[[17]]$Temperature)
data[[17]]$UseData <- ifelse(data[[17]]$Temperature < 1, 0, 1)
summary(data[[17]])

# Kulik Kulik Creek
data[[18]]$AKOATS_ID <- "872"
plot(data[[18]]$sampleDate, data[[18]]$Temperature)
data[[18]]$UseData <- ifelse(data[[18]]$Temperature > 12, 0, 1)
summary(data[[18]])

# Nerka Little Beaver Creek??? Big and little?
data[[19]]$AKOATS_ID <- NA
plot(data[[19]]$sampleDate, data[[19]]$Temperature)
data[[19]]$UseData <- ifelse(data[[19]]$Temperature < 1, 0, 1)
summary(data[[19]])

# Little Togiak Creek Lower
data[[20]]$AKOATS_ID <- "861"
plot(data[[20]]$sampleDate, data[[20]]$Temperature)
data[[20]]$UseData <- ifelse(data[[20]]$Temperature < 1, 0, 1)
summary(data[[20]])

# Nerka Little Togiak River
data[[21]]$AKOATS_ID <- "850"
plot(data[[21]]$sampleDate, data[[21]]$Temperature)
data[[21]]$UseData <- 1
summary(data[[21]])

# Nerka Lynx Creek Lower
data[[22]]$AKOATS_ID <- "843"
plot(data[[22]]$sampleDate, data[[22]]$Temperature)
data[[22]]$UseData <- ifelse(data[[22]]$Temperature < 1, 0, 1)
summary(data[[22]])

# Beverley Moose Creek
data[[23]]$AKOATS_ID <- "863"
plot(data[[23]]$sampleDate, data[[23]]$Temperature)
data[[23]]$UseData <- ifelse(data[[23]]$Temperature < 1, 0, 1)
summary(data[[23]])

# Nerka N4 Creek
data[[24]]$AKOATS_ID <- "842"
plot(data[[24]]$sampleDate, data[[24]]$Temperature)
data[[24]]$UseData <- ifelse(data[[24]]$Temperature < 1, 0, 1)
summary(data[[24]])

# Nerka Bear Creek
data[[25]]$AKOATS_ID <- "840"
plot(data[[25]]$sampleDate, data[[25]]$Temperature)
data[[25]]$UseData <- ifelse(data[[25]]$Temperature < 1, 0, 1)
summary(data[[25]])

# Beverley Peace (Fourth) River
data[[26]]$AKOATS_ID <- "869"
plot(data[[26]]$sampleDate, data[[26]]$Temperature)
data[[26]]$UseData <- ifelse(data[[26]]$Temperature < 1, 0, 1)
summary(data[[26]])

# Nerka Pick Creek
data[[27]]$AKOATS_ID <- "848"
plot(data[[27]]$sampleDate, data[[27]]$Temperature)
data[[27]]$UseData <- ifelse(data[[27]]$Temperature < 1 | data[[27]]$Temperature > 18, 0, 1)
summary(data[[27]])

# Nerka Pike Creek
data[[28]]$AKOATS_ID <- "836"
plot(data[[28]]$sampleDate, data[[28]]$Temperature)
data[[28]]$UseData <- ifelse(data[[28]]$Temperature < 1, 0, 1)
summary(data[[28]])

# Nerka Rainbow Creek
data[[29]]$AKOATS_ID <- "865"
plot(data[[29]]$sampleDate, data[[29]]$Temperature)
data[[29]]$UseData <- ifelse(data[[29]]$Temperature < 1, 0, 1)
summary(data[[29]])

# Nerka Sam Creek
data[[30]]$AKOATS_ID <- "857"
plot(data[[30]]$sampleDate, data[[30]]$Temperature)
data[[30]]$UseData <- ifelse(data[[30]]$Temperature < 1 |
                               (data[[30]]$sampleDate > "2011-01-01" & data[[30]]$sampleDate < "2012-01-01"
                                & data[[30]]$Temperature > 13) |
                               (data[[30]]$sampleDate > "2013-01-01" & data[[30]]$sampleDate < "2014-01-01"
                                & data[[30]]$Temperature > 15), 0, 1)
summary(data[[30]])

# Nerka Seventh Creek
data[[31]]$AKOATS_ID <- "854"
plot(data[[31]]$sampleDate, data[[31]]$Temperature)
data[[31]]$UseData <- ifelse(data[[31]]$Temperature < 1 | data[[31]]$Temperature > 15, 0, 1)
summary(data[[31]])

# Beverley Silverhorn Creek
data[[32]]$AKOATS_ID <- "866"
plot(data[[32]]$sampleDate, data[[32]]$Temperature)
data[[32]]$UseData <- ifelse(data[[32]]$Temperature < 1, 0, 1)
summary(data[[32]])

# Nerka Sixth Creek
data[[33]]$AKOATS_ID <- "852"
plot(data[[33]]$sampleDate, data[[33]]$Temperature)
data[[33]]$UseData <- ifelse(data[[33]]$Temperature < 1, 0, 1)
summary(data[[33]])

# Nerka Stovall Creek
data[[34]]$AKOATS_ID <- "837"
plot(data[[34]]$sampleDate, data[[34]]$Temperature)
data[[34]]$UseData <- ifelse(data[[34]]$Temperature < 1, 0, 1)
summary(data[[34]])

# Beverley Uno Creek
data[[35]]$AKOATS_ID <- "867"
plot(data[[35]]$sampleDate, data[[35]]$Temperature)
data[[35]]$UseData <- ifelse(data[[35]]$Temperature < 1 | data[[35]]$Temperature > 12, 0, 1)
summary(data[[35]])

# Aleknagik Wood River
data[[36]]$AKOATS_ID <- "823"
# Fix data-time errors
data[[36]]$row <- seq.int(nrow(data[[36]]))
for (i in 1702:1725) data[[36]]$sampleDate[data[[36]]$row == i] <- "2009-09-01"
for (i in 1726:1749) data[[36]]$sampleDate[data[[36]]$row == i] <- "2009-09-02"
for (i in 1750:1766) data[[36]]$sampleDate[data[[36]]$row == i] <- "2009-09-03"
for (i in 1702:1766) data[[36]]$sampleTime[data[[36]]$row == i] <- data[[36]]$sampleTime[data[[36]]$row == (i - 24)]
data[[36]]$row <- NULL
plot(data[[36]]$sampleDate, data[[36]]$Temperature)
data[[36]]$UseData <- ifelse(data[[36]]$Temperature > 15, 0, 1)
summary(data[[36]])

# Agulowak River
data[[37]]$AKOATS_ID <- "832"
plot(data[[37]]$sampleDate, data[[37]]$Temperature)
data[[37]]$UseData <- ifelse(data[[37]]$Temperature > 20, 0, 1)
summary(data[[37]])

# Agulukpak River
data[[38]]$AKOATS_ID <- "851"
plot(data[[38]]$sampleDate, data[[38]]$Temperature)
data[[38]]$UseData <- 1
summary(data[[38]])

# Aleknagik Big Whitefish Creek
# Fix sampleDate parsing error (requires dmy())
data[[39]] <-
  read_csv(files[[39]]) %>%
  select("AKOATS_ID" = 1, "sampleDate" = 5, "sampleTime" = 6, "Temperature" = 7) %>%
  mutate("sampleDate" = dmy(sampleDate))
data[[39]]$AKOATS_ID <- "822"
plot(data[[39]]$sampleDate, data[[39]]$Temperature)
data[[39]]$UseData <- 1
summary(data[[39]])

# Aleknagik Eagle Creek
data[[40]]$AKOATS_ID <- "828"
plot(data[[40]]$sampleDate, data[[40]]$Temperature)
data[[40]]$UseData <- ifelse(data[[40]]$Temperature < 1 | data[[40]]$Temperature > 16, 0, 1)
summary(data[[40]])

# Aleknagik Hansen Creek
data[[41]]$AKOATS_ID <- "829"
plot(data[[41]]$sampleDate, data[[41]]$Temperature)
data[[41]]$UseData <- ifelse(data[[41]]$Temperature < 1 | data[[41]]$Temperature > 18, 0, 1)
summary(data[[41]])

# Aleknagik Ice Creek
data[[42]]$AKOATS_ID <- "831"
plot(data[[42]]$sampleDate, data[[42]]$Temperature)
data[[42]]$UseData <- ifelse(data[[42]]$Temperature < 1 | data[[42]]$Temperature > 20, 0, 1)
summary(data[[42]])

# Aleknagik Little Whitefish Creek??? big vs little
data[[43]]$AKOATS_ID <- NA
plot(data[[43]]$sampleDate, data[[43]]$Temperature)
data[[43]]$UseData <- ifelse(data[[43]]$Temperature < 1 | data[[43]]$Temperature > 20, 0, 1)
summary(data[[43]])

# Aleknagik Midnight Creek
data[[44]]$AKOATS_ID <- "826"
plot(data[[44]]$sampleDate, data[[44]]$Temperature)
data[[44]]$UseData <- ifelse(data[[44]]$Temperature < 1 | data[[44]]$Temperature > 11, 0, 1)
summary(data[[44]])

# Aleknagik Mission Creek
data[[45]]$AKOATS_ID <- "825"
plot(data[[45]]$sampleDate, data[[45]]$Temperature)
data[[45]]$UseData <- ifelse(data[[45]]$Temperature < 1 | data[[45]]$Temperature > 9, 0, 1)
summary(data[[45]])

# Aleknagik Pfifer Creek
data[[46]]$AKOATS_ID <- "820"
plot(data[[46]]$sampleDate, data[[46]]$Temperature)
data[[46]]$UseData <- ifelse(data[[46]]$Temperature > 17, 0, 1)
summary(data[[46]])

# Aleknagik Silver Salmon Creek
data[[47]]$AKOATS_ID <- "821"
plot(data[[47]]$sampleDate, data[[47]]$Temperature)
data[[47]]$UseData <- ifelse(data[[47]]$Temperature > 22, 0, 1)
summary(data[[47]])

# Aleknagik Squaw Creek???
data[[48]]$AKOATS_ID <- NA
plot(data[[48]]$sampleDate, data[[48]]$Temperature)
data[[48]]$UseData <- ifelse(data[[48]]$Temperature > 22, 0, 1)
summary(data[[48]])

# Aleknagik Sunshine Creek
data[[49]]$AKOATS_ID <- "838"
plot(data[[49]]$sampleDate, data[[49]]$Temperature)
data[[49]]$UseData <- ifelse(data[[49]]$Temperature > 14, 0, 1)
summary(data[[49]])

# Aleknagik Yako Creek
data[[50]]$AKOATS_ID <- "824"
plot(data[[50]]$sampleDate, data[[50]]$Temperature)
data[[50]]$UseData <- ifelse(data[[50]]$Temperature < 1 | data[[50]]$Temperature > 13, 0, 1)
summary(data[[50]])

# Aleknagik Youth Creek
data[[51]]$AKOATS_ID <- "835"
plot(data[[51]]$sampleDate, data[[51]]$Temperature)
data[[51]]$UseData <- 1
summary(data[[51]])


# Write data to .csv files

names <- str_remove_all(names(data), " ")
ids <- unlist(lapply(data, function(x) x$AKOATS_ID[1]))
starts <- unlist(lapply(data, function(x) min(year(x$sampleDate))))
ends <- unlist(lapply(data, function(x) max(year(x$sampleDate))))

filenames <- paste0("../../../files/Stream_Temperature/UW/formatted/",
                    paste(names, ids, starts, ends, sep = "_"), ".csv")

out <- mapply(write_csv, data, filenames)
