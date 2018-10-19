# Process stream temperature data from UAA ACCS
# http://accs.uaa.alaska.edu/aquatic-ecology/akoats/
# Data submitted by Dan Bogan


library(readr)
library(tidyr)
library(dplyr)
library(hms)
library(skimr)


# Standardize format and merge files at site level


# Create generic function to import and format data

names <- c("AKOATS_ID", "sampleDate", "sampleTime", "Temperature")
process <- function(x, id) {
    read_csv(x, skip = 2, col_names = names) %>%
        select(1:4) %>%
        mutate("AKOATS_ID" = id)
}


# AKBB-020

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^AKBB-020", full.names = TRUE)
data <- lapply(files, process, id = "1660")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/AKBB-020_1660_2015_2017.csv")


# AKBB-028

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^AKBB-028", full.names = TRUE)
data <- lapply(files, process, id = "1661")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 1
data[[4]]$Duplicate_Sensor <- 0
data[[1]]$Location_Description <- ""
data[[2]]$Location_Description <- ""
data[[3]]$Location_Description <- "upstream from beaver impoundment"
data[[4]]$Location_Description <- ""
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/AKBB-028_1661_2015_2017.csv")


# AKBB-029

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^AKBB-029", full.names = TRUE)
data <- lapply(files, process, id = "1662")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/AKBB-029_1662_2015_2017.csv")


# AKBB-040

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^AKBB-040", full.names = TRUE)
data <- lapply(files, process, id = "1663")
data[[1]]$Location_Description <- "left bank"
data[[2]]$Location_Description <- "right bank"
data[[3]]$Location_Description <- "left bank"
data[[4]]$Location_Description <- "right bank"
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/AKBB-040_1663_2015_2017.csv")


# Bonanza Creek

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^Bonanza Creek", full.names = TRUE)
data <- lapply(files, process, id = "1664")
data[[1]]$Duplicate_Sensor <- 0 # likely measurement errors for temperature
data[[2]]$Duplicate_Sensor <- 0
data[[3]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/BonanzaCreek_1664_2015_2017.csv")


# iltnr19

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^iltnr19", full.names = TRUE)
data <- lapply(files, process, id = "764")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]] <- bind_rows(data[[3]], data[[8]])
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 0
data[[5]]$Duplicate_Sensor <- 1
data[[6]]$Duplicate_Sensor <- 0
data[[7]]$Duplicate_Sensor <- 1
data[[8]] <- NULL
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/iltnr19_764_2013_2017.csv")


# muekm23

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^muekm23", full.names = TRUE)
data <- lapply(files, process, id = "763")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 0
data[[5]]$Duplicate_Sensor <- 1
data[[6]]$Duplicate_Sensor <- 0
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/muekm23_763_2013_2017.csv")


# mussm15

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^mussm15", full.names = TRUE)
data <- lapply(files, process, id = "760")
# Variables were not separated in June 2013 file
data_2013 <- read_csv(files[[1]], skip = 2, col_names = "col") %>%
    separate("col", c("AKOATS_ID", "sampleDate", "sampleTime", "Temperature"), sep = "\\s+", convert = TRUE)
data_2013$AKOATS_ID <- as.character("760")
data_2013$sampleTime <- as.hms(data_2013$sampleTime)
data[[1]] <- data_2013
rm(data_2013)
data[[1]]$Duplicate_Sensor <- 0
data[[2]] <- bind_rows(data[[2]], data[[6]])
data[[2]]$Duplicate_Sensor <- 0
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 0
data[[5]]$Duplicate_Sensor <- 1
data[[6]] <- NULL
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/mussm15_760_2013_2017.csv")


# mutsk02

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^mutsk02", full.names = TRUE)
data <- lapply(files, process, id = "762")
# Variables were not separated in June 2013 file
data_2013 <- read_csv(files[[1]], skip = 2, col_names = "col") %>%
    separate("col", c("AKOATS_ID", "sampleDate", "sampleTime", "Temperature"), sep = "\\s+", convert = TRUE)
data_2013$AKOATS_ID <- as.character("762")
data_2013$sampleTime <- as.hms(data_2013$sampleTime)
data[[1]] <- data_2013
rm(data_2013)
data[[1]]$Location_Description <- ""
data[[2]]$Location_Description <- ""
data[[3]]$Location_Description <- "left bank"
data[[4]]$Location_Description <- "right bank"
data[[5]]$Location_Description <- "left bank"
data[[6]]$Location_Description <- "right bank"
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/mutsk02_762_2013_2017.csv")


# mutsk09

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^mutsk09", full.names = TRUE)
data <- lapply(files, process, id = "761")
# Variables were not separated in June 2013 file
data_2013 <- read_csv(files[[1]], skip = 2, col_names = "col") %>%
    separate("col", c("AKOATS_ID", "sampleDate", "sampleTime", "Temperature"), sep = "\\s+", convert = TRUE)
data_2013$AKOATS_ID <- as.character("761")
data_2013$sampleTime <- as.hms(data_2013$sampleTime)
data[[1]] <- data_2013
rm(data_2013)
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 0
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 0
data[[5]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/mutsk09_761_2013_2017.csv")


# South Fork Koktuli River

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^South Fork Koktuli River", full.names = TRUE)
data <- lapply(files, process, id = "1665")
data[[1]]$Location_Description <- "left bank"
data[[2]]$Location_Description <- "right bank"
data[[3]]$Location_Description <- "left bank"
data[[4]]$Location_Description <- "right bank"
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/SouthForkKoktuliRiver_1665_2015_2017.csv")


# Stuyahok River

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^Stuyahok River", full.names = TRUE)
data <- lapply(files, process, id = "1666")
data[[1]]$Location_Description <- "right bank"
data[[2]]$Location_Description <- "left bank"
data[[3]]$Location_Description <- "right bank"
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/StuyahokRiver_1666_2015_2017.csv")


# Tazimina River

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^Tazimina", full.names = TRUE)
data <- lapply(files, process, id = "1667")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/TaziminaRiver_1667_2015_2017.csv")


# Victoria Creek

files <- list.files("/home/dstrong/files/Stream_Temperature/UAA_ACCS/original", pattern = "^Victoria Creek", full.names = TRUE)
data <- lapply(files, process, id = "1668")
data[[1]]$Duplicate_Sensor <- 0
data[[2]]$Duplicate_Sensor <- 1
data[[3]]$Duplicate_Sensor <- 0
data[[4]]$Duplicate_Sensor <- 1
lapply(data, skim)
data <- bind_rows(data)
data$UseData <- 1 # no missing data, but correct for extreme values
data$UseData[data$Temperature < -1 | data$Temperature > 30] <- 0
write_csv(data, "/home/dstrong/files/Stream_Temperature/UAA_ACCS/formatted/VictoriaCreek_1668_2015_2017.csv")
