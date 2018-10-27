# Template script to find, filter, and read stream temperature data from Alaska

# install.packages(c("dataone", "dplyr", "stringr", "readr"))
library(dataone)
library(dplyr)
library(stringr)
library(readr)

# Set Member Node to KNB
cn <- CNode("PROD")
knb <- getMNode(cn, "urn:node:KNB")


# Find data -----------------------------------------------------------------------------

# Create vector of data package PIDs
pkgs <- c("doi:10.5063/F1028PR9",
          "doi:10.5063/F10P0X83",
          "doi:10.5063/F1W0944C",
          "urn:uuid:6a67fcbc-6a2e-4282-b739-486ec9bb02d0",
          "urn:uuid:e8e9f3f5-9b97-4359-be8f-d712d8c4f6fd",
          "urn:uuid:f69e1996-e46f-4c67-9963-5c0c3bc8671a",
          "urn:uuid:a98c0f5d-a5e6-49ae-8aa2-132875d35476",
          "urn:uuid:cb0d6944-db7f-438e-8a82-ec4c39972c1b",
          "urn:uuid:b63d3d3f-f745-425f-a69f-998154895f40")

# Find all data objects
results <- lapply(pkgs, function(pkg) query(knb,
                                            solrQuery = list(q = paste0("isDocumentedBy:", '\"', pkg, '\"', "+AND+formatId:text/csv"),
                                                             fl = "fileName, dataUrl",
                                                             rows = "1000"),
                                            as = "data.frame"))
results <- bind_rows(results)

# Separate data from site-level metadata
data <- filter(results, !str_detect(fileName, "^SiteLevel*"))
sites <- filter(results, str_detect(fileName, "^SiteLevel*"))
# Exclude spot temperature dataset
data <- filter(data, !str_detect(fileName, "^SpotTemp*"))


# Filter data ---------------------------------------------------------------------------

# Filter by AKOATS ID
koktuli <- filter(data, str_detect(fileName, "760|761|762|763|1665"))
# Filter by waterbody name
koktuli <- filter(data, str_detect(fileName, "Koktuli"))
# Filter by coordinates
site_metadata <- lapply(sites$dataUrl, read_csv)
site_metadata <- bind_rows(site_metadata)
box <- filter(site_metadata, Latitude > 69.014 & Latitude < 71.581 & Longitude > -162.532 & Longitude < -143.657)
ids <- paste(box$AKOATS_ID, collapse = "|")
nslope <- filter(data, str_detect(fileName, ids))


# Read data -----------------------------------------------------------------------------

# Read directly
data <- lapply(koktuli$dataUrl, read_csv)
data <- bind_rows(data)

# Download to local file and read
dir <- "./stream_temp_data/" # specify folder path
dest <- paste0(dir, koktuli$fileName) # use existing filenames
mapply(download.file, url = koktuli$dataUrl, destfile = dest)
files <- list.files(dir, full.names = TRUE)
data <- lapply(files, read_csv)
