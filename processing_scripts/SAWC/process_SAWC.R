# Process SAWC stream temperature data

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
# Download from SAWC website at
# http://www.seakecology.org/freshwater/stream-temperatures/

urls <- c("http://www.seakecology.org/wp-content/uploads/2016/07/black_river_a_2016-07-09.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/black_river_b_2016-07-09.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/ford_arm_a_2015-06-17.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/ford_arm_b_2015-06-17.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/ford_arm_c_2016_07_08.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/ford_arm_d_2016_07_08.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/goulding_a_2016_07_10.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/goulding_b_2016_07_10.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/leos_a_2016_07_07.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/leos_b_2016_07_07.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/nakwasina_a_2016_07_06.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/nakwasina_b_2016_07_06.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/necker_a_2016_07_03.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/necker_b_2016_07_03.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/no_name_a_2016-06-19.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/no_name_b_2016-06-19.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/salmon_lake_creek_a_2016_02_18.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/salmon_lake_creek_b_2016_02_18.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/salmon_lake_creek_c_2016_02_18.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/salmon_lake_creek_d_2016_02_18.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/starrigavan_a_2016_06_06.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/waterfall_a_2016_07_08.csv",
          "http://www.seakecology.org/wp-content/uploads/2016/07/waterfall_b_2016_07_08.csv")
data <- lapply(urls, read_csv)

# Remove Salmon Lake Creek sites because of poor data
data[[20]] <- NULL
data[[19]] <- NULL

# Make common changes across data files
data <- lapply(data, function(x) select(x, "AKOATS_ID" = 1, "date_time" = 2, "Temperature" = 3) %>% mutate("row" = seq.int(nrow(x))))

# Black River A
# Note that sensor was replaced 08/2014
data[[1]]$AKOATS_ID <- "1640"
data[[1]]$Location <- "Submerged log on downstream left"
data[[1]]$Duplicate_Sensor <- 0
data[[1]] <- data[[1]][-c(1:25, 9341:9349, 17022:17028, 26317:nrow(data[[1]])), ]
data[[1]] <- separate(data[[1]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[1]]$sampleDate <- mdy(data[[1]]$sampleDate)
times <- data.frame(str_split_fixed(data[[1]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[1]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[1]]$Temperature <- as.numeric(data[[1]]$Temperature)
plot(data[[1]]$sampleDate, data[[1]]$Temperature)
data[[1]]$UseData <- ifelse(data[[1]]$Temperature < 14, 1, 0)
summary(data[[1]])

# Black River B
data[[2]]$AKOATS_ID <- "1640"
data[[2]]$Location <- "Streamside alder tree"
data[[2]]$Duplicate_Sensor <- 1
data[[2]] <- data[[2]][-c(1:24, 7711:7717, 17006:nrow(data[[2]])), ]
data[[2]] <- separate(data[[2]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[2]]$sampleDate <- mdy(data[[2]]$sampleDate)
times <- data.frame(str_split_fixed(data[[2]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[2]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[2]]$Temperature <- as.numeric(data[[2]]$Temperature)
plot(data[[2]]$sampleDate, data[[2]]$Temperature)
data[[2]]$UseData <- ifelse(data[[2]]$Temperature < 14, 1, 0)
summary(data[[2]])

# Combine Black River data
data[[1]] <- bind_rows(data[[1]], data[[2]])
data[[2]] <- NULL

# Ford Arm Creek A
data[[2]]$AKOATS_ID <- "1638"
data[[2]]$Location <- "Boulder in center of stream"
data[[2]]$Duplicate_Sensor <- 0
data[[2]] <- data[[2]][-c(1:23, 7672:nrow(data[[2]])), ]
data[[2]] <- separate(data[[2]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[2]]$sampleDate <- mdy(data[[2]]$sampleDate)
times <- data.frame(str_split_fixed(data[[2]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[2]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[2]]$Temperature <- as.numeric(data[[2]]$Temperature)
plot(data[[2]]$sampleDate, data[[2]]$Temperature)
data[[2]]$UseData <- ifelse(data[[2]]$Temperature >= 18 | data[[2]]$row %in% c(3015, 3040, 3349, 3350, 3351, 3374, 3375, 3424), 0, 1)
summary(data[[2]])

# Ford Arm Creek B
data[[3]]$AKOATS_ID <- "1638"
data[[3]]$Location <- "Streamside log on downstream left"
data[[3]]$Duplicate_Sensor <- 1
data[[3]] <- data[[3]][-c(1:23, 7687:nrow(data[[3]])), ]
data[[3]] <- separate(data[[3]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[3]]$sampleDate <- mdy(data[[3]]$sampleDate)
times <- data.frame(str_split_fixed(data[[3]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[3]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[3]]$Temperature <- as.numeric(data[[3]]$Temperature)
plot(data[[3]]$sampleDate, data[[3]]$Temperature)
data[[3]]$UseData <- ifelse(data[[3]]$Temperature >= 18, 0, 1)
summary(data[[3]])

# Ford Arm Creek C
data[[4]]$AKOATS_ID <- "1638"
data[[4]]$Location <- "Cross-channel log"
data[[4]]$Duplicate_Sensor <- 0
data[[4]] <- data[[4]][-c(1:23, 9313:nrow(data[[4]])), ]
data[[4]] <- separate(data[[4]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[4]]$sampleDate <- mdy(data[[4]]$sampleDate)
times <- data.frame(str_split_fixed(data[[4]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[4]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[4]]$Temperature <- as.numeric(data[[4]]$Temperature)
plot(data[[4]]$sampleDate, data[[4]]$Temperature)
data[[4]]$UseData <- 1
summary(data[[4]])

# Ford Arm Creek D
data[[5]]$AKOATS_ID <- "1638"
data[[5]]$Location <- "Cross-channel log near rootwad on downstream right"
data[[5]]$Duplicate_Sensor <- 1
data[[5]] <- data[[5]][-c(1:23, 9313:nrow(data[[5]])), ]
data[[5]] <- separate(data[[5]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[5]]$sampleDate <- mdy(data[[5]]$sampleDate)
times <- data.frame(str_split_fixed(data[[5]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[5]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[5]]$Temperature <- as.numeric(data[[5]]$Temperature)
plot(data[[5]]$sampleDate, data[[5]]$Temperature)
data[[5]]$UseData <- 1
summary(data[[5]])

# Combine Ford Arm Creek data
data[[2]] <- bind_rows(data[[2]], data[[3]], data[[4]], data[[5]])
data[[5]] <- NULL
data[[4]] <- NULL
data[[3]] <- NULL

# Goulding River A
data[[3]]$AKOATS_ID <- "1639"
data[[3]]$Location <- "Partially submerged log on downstream right"
data[[3]]$Duplicate_Sensor <- 0
data[[3]] <- data[[3]][-c(1:24, 9316:nrow(data[[3]])), ]
data[[3]] <- separate(data[[3]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[3]]$sampleDate <- mdy(data[[3]]$sampleDate)
times <- data.frame(str_split_fixed(data[[3]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[3]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[3]]$Temperature <- as.numeric(data[[3]]$Temperature)
plot(data[[3]]$sampleDate, data[[3]]$Temperature)
data[[3]]$UseData <- 1
summary(data[[3]])

# Goulding River B
data[[4]]$AKOATS_ID <- "1639"
data[[4]]$Location <- "Streamside alder tree upstream"
data[[4]]$Duplicate_Sensor <- 1
data[[4]] <- data[[4]][-c(1:27, 9319:nrow(data[[4]])), ]
data[[4]] <- separate(data[[4]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[4]]$sampleDate <- mdy(data[[4]]$sampleDate)
times <- data.frame(str_split_fixed(data[[4]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[4]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[4]]$Temperature <- as.numeric(data[[4]]$Temperature)
plot(data[[4]]$sampleDate, data[[4]]$Temperature)
data[[4]]$UseData <- 1
summary(data[[4]])

# Combine Goulding River data
data[[3]] <- bind_rows(data[[3]], data[[4]])
data[[4]] <- NULL

# Leo's Creek A
data[[4]]$AKOATS_ID <- "1641"
data[[4]]$Location <- "Streamside spruce tree on downstream left"
data[[4]]$Duplicate_Sensor <- 0
data[[4]] <- data[[4]][-c(1:25, 7759:7765, 16955:nrow(data[[4]])), ]
data[[4]] <- separate(data[[4]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[4]]$sampleDate <- mdy(data[[4]]$sampleDate)
times <- data.frame(str_split_fixed(data[[4]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[4]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[4]]$Temperature <- as.numeric(data[[4]]$Temperature)
plot(data[[4]]$sampleDate, data[[4]]$Temperature)
data[[4]]$UseData <- 1
summary(data[[4]])

# Leo's Creek B
# Note that sensor was removed in 2016 because it was dry
data[[5]]$AKOATS_ID <- "1641"
data[[5]]$Location <- "Downstream"
data[[5]]$Duplicate_Sensor <- 1
data[[5]] <- data[[5]][-c(1:26, 7759:7765, 16967:nrow(data[[5]])), ]
data[[5]] <- separate(data[[5]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[5]]$sampleDate <- mdy(data[[5]]$sampleDate)
times <- data.frame(str_split_fixed(data[[5]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[5]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[5]]$Temperature <- as.numeric(data[[5]]$Temperature)
plot(data[[5]]$sampleDate, data[[5]]$Temperature)
data[[5]]$UseData <- ifelse(data[[5]]$Temperature > 23, 0, 1)
summary(data[[5]])

# Combine Leo's Creek data
data[[4]] <- bind_rows(data[[4]], data[[5]])
data[[5]] <- NULL

# Nakwasina River A
# Note that sensor was replaced 08/2014
data[[5]]$AKOATS_ID <- "1642"
data[[5]]$Location <- "Submerged log at junction of seasonal braid"
data[[5]]$Duplicate_Sensor <- 0
data[[5]] <- data[[5]][-c(1:26, 10801:10805, 27125:27137, 37627:37633, 43586:nrow(data[[5]])), ]
data[[5]] <- separate(data[[5]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[5]]$sampleDate <- mdy(data[[5]]$sampleDate)
times <- data.frame(str_split_fixed(data[[5]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[5]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[5]]$Temperature <- as.numeric(data[[5]]$Temperature)
plot(data[[5]]$sampleDate, data[[5]]$Temperature)
data[[5]]$UseData <- ifelse(data[[5]]$Temperature > 15, 0, 1)
summary(data[[5]])

# Nakwasina River B
data[[6]]$AKOATS_ID <- "1642"
data[[6]]$Location <- "Other submerged log at junction of seasonal braid"
data[[6]]$Duplicate_Sensor <- 1
data[[6]] <- data[[6]][-c(1:30, 10519:10525, 16478:nrow(data[[6]])), ]
data[[6]] <- separate(data[[6]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[6]]$sampleDate <- mdy(data[[6]]$sampleDate)
times <- data.frame(str_split_fixed(data[[6]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[6]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[6]]$Temperature <- as.numeric(data[[6]]$Temperature)
plot(data[[6]]$sampleDate, data[[6]]$Temperature)
data[[6]]$UseData <- 1
summary(data[[6]])

# Combine Nakwasina River data
data[[5]] <- bind_rows(data[[5]], data[[6]])
data[[6]] <- NULL

# Benzeman Creek Outlet Stream A
data[[6]]$AKOATS_ID <- "1647"
data[[6]]$Location <- "Log in small logjam parallel to stream"
data[[6]]$Duplicate_Sensor <- 0
data[[6]] <- data[[6]][-c(1:44, 12546:nrow(data[[6]])), ]
data[[6]] <- separate(data[[6]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[6]]$sampleDate <- mdy(data[[6]]$sampleDate)
times <- data.frame(str_split_fixed(data[[6]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[6]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[6]]$Temperature <- as.numeric(data[[6]]$Temperature)
plot(data[[6]]$sampleDate, data[[6]]$Temperature)
data[[6]]$UseData <- 1
summary(data[[6]])

# Benzeman Creek Outlet Stream B
data[[7]]$AKOATS_ID <- "1647"
data[[7]]$Location <- "Other log in small logjam parallel to stream"
data[[7]]$Duplicate_Sensor <- 1
data[[7]] <- data[[7]][-c(1:45, 12546:nrow(data[[7]])), ]
data[[7]] <- separate(data[[7]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[7]]$sampleDate <- mdy(data[[7]]$sampleDate)
times <- data.frame(str_split_fixed(data[[7]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[7]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[7]]$Temperature <- as.numeric(data[[7]]$Temperature)
plot(data[[7]]$sampleDate, data[[7]]$Temperature)
data[[7]]$UseData <- 1
summary(data[[7]])

# Combine Benzeman Creek Outlet Stream data
data[[6]] <- bind_rows(data[[6]], data[[7]])
data[[7]] <- NULL

# No Name Creek A
data[[7]]$AKOATS_ID <- "1644"
data[[7]]$Location <- "Large pool on downstream left"
data[[7]]$Duplicate_Sensor <- 0
data[[7]] <- data[[7]][-c(1:24, 4248:nrow(data[[7]])), ]
data[[7]] <- separate(data[[7]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[7]]$sampleDate <- mdy(data[[7]]$sampleDate)
times <- data.frame(str_split_fixed(data[[7]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[7]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[7]]$Temperature <- as.numeric(data[[7]]$Temperature)
plot(data[[7]]$sampleDate, data[[7]]$Temperature)
data[[7]]$UseData <- 1
summary(data[[7]])

# No Name Creek B
data[[8]]$AKOATS_ID <- "1644"
data[[8]]$Location <- "Same large pool on downstream left"
data[[8]]$Duplicate_Sensor <- 1
data[[8]] <- data[[8]][-c(1:23, 6196:6202, 10426:nrow(data[[8]])), ]
data[[8]] <- separate(data[[8]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[8]]$sampleDate <- mdy(data[[8]]$sampleDate)
times <- data.frame(str_split_fixed(data[[8]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[8]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[8]]$Temperature <- as.numeric(data[[8]]$Temperature)
plot(data[[8]]$sampleDate, data[[8]]$Temperature)
data[[8]]$UseData <- ifelse(data[[8]]$row < 868, 0, 1)
summary(data[[8]])

# Combine No Name Creek data
data[[7]] <- bind_rows(data[[7]], data[[8]])
data[[8]] <- NULL

# Salmon Lake Creek A
# Note that site was moved in 2016 because of suspected tidal influence
data[[8]]$AKOATS_ID <- "1646"
data[[8]]$Location <- "Downstream"
data[[8]]$Duplicate_Sensor <- 0
data[[8]] <- data[[8]][-c(1:24, 6669:nrow(data[[8]])), ]
data[[8]] <- separate(data[[8]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[8]]$sampleDate <- mdy(data[[8]]$sampleDate)
times <- data.frame(str_split_fixed(data[[8]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[8]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[8]]$Temperature <- as.numeric(data[[8]]$Temperature)
plot(data[[8]]$sampleDate, data[[8]]$Temperature)
data[[8]]$UseData <- 0
summary(data[[8]])

# Salmon Lake Creek B
data[[9]]$AKOATS_ID <- "1646"
data[[9]]$Location <- "Same downstream"
data[[9]]$Duplicate_Sensor <- 1
data[[9]] <- data[[9]][-c(1:24, 6669:nrow(data[[9]])), ]
data[[9]] <- separate(data[[9]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[9]]$sampleDate <- mdy(data[[9]]$sampleDate)
times <- data.frame(str_split_fixed(data[[9]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[9]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[9]]$Temperature <- as.numeric(data[[9]]$Temperature)
plot(data[[9]]$sampleDate, data[[9]]$Temperature)
data[[9]]$UseData <- 0
summary(data[[9]])

# Combine Salmon Lake Creek data
data[[8]] <- bind_rows(data[[8]], data[[9]])
data[[9]] <- NULL

# Starrigavan Creek A
data[[9]]$AKOATS_ID <- "1643"
data[[9]]$Location <- "Roots of spruce tree overhanging creek"
data[[9]] <- data[[9]][-c(1:23, 7153:7160, 11096:11102, 16405:nrow(data[[9]])), ]
data[[9]] <- separate(data[[9]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[9]]$sampleDate <- mdy(data[[9]]$sampleDate)
times <- data.frame(str_split_fixed(data[[9]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[9]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[9]]$Temperature <- as.numeric(data[[9]]$Temperature)
plot(data[[9]]$sampleDate, data[[9]]$Temperature)
data[[9]]$UseData <- 1
summary(data[[9]])

# Waterfall Cove Creek A
data[[10]]$AKOATS_ID <- "1637"
data[[10]]$Location <- "Spruce tree overhanging creek on downstream left"
data[[10]]$Duplicate_Sensor <- 0
data[[10]] <- data[[10]][-c(1:23, 7668:7674, 16963:nrow(data[[10]])), ]
data[[10]] <- separate(data[[10]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[10]]$sampleDate <- mdy(data[[10]]$sampleDate)
times <- data.frame(str_split_fixed(data[[10]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[10]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[10]]$Temperature <- as.numeric(data[[10]]$Temperature)
plot(data[[10]]$sampleDate, data[[10]]$Temperature)
data[[10]]$UseData <- ifelse(data[[10]]$Temperature > 12, 0, 1)
summary(data[[10]])

# Waterfall Cove Creek B
data[[11]]$AKOATS_ID <- "1637"
data[[11]]$Location <- "Log partially spanning channel on downstream right"
data[[11]]$Duplicate_Sensor <- 1
data[[11]] <- data[[11]][-c(1:23, 7669:7675, 16964:nrow(data[[11]])), ]
data[[11]] <- separate(data[[11]], "date_time", c("sampleDate", "sampleTime"), sep = " ")
data[[11]]$sampleDate <- mdy(data[[11]]$sampleDate)
times <- data.frame(str_split_fixed(data[[11]]$sampleTime, ":", 2))
times$X1 <- str_pad(times$X1, width = 2, side = "left", pad = "0")
data[[11]]$sampleTime <- paste0(times$X1, ":", times$X2, ":00")
data[[11]]$Temperature <- as.numeric(data[[11]]$Temperature)
plot(data[[11]]$sampleDate, data[[11]]$Temperature)
data[[11]]$UseData <- ifelse(data[[11]]$Temperature > 12, 0, 1)
summary(data[[11]])

# Combine Waterfall Cove Creek data
data[[10]] <- bind_rows(data[[10]], data[[11]])
data[[11]] <- NULL

# Remove row variable from all data sets
for (i in seq_along(data)) data[[i]]$row <- NULL

# Write to .csv files
filenames <- c("../../../files/Stream_Temperature/SAWC/formatted/BlackRiver_1640_2013_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/FordArmCreek_1638_2014_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/GouldingRiver_1639_2015_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/LeosCreek_1641_2014_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/NakwasinaRiver_1642_2011_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/BenzemanCreekOutletStream_1647_2015_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/NoNameCreek_1644_2015_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/SalmonLakeCreek_1646_2015_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/StarrigavanRiver_1643_2014_2016.csv",
               "../../../files/Stream_Temperature/SAWC/formatted/WaterfallCoveCreek_1637_2014_2016.csv")
out <- mapply(write_csv, data, filenames)
