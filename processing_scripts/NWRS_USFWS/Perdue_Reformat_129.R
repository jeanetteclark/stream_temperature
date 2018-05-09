################
#Issue #129: Stream Temperature: Water Resource Branch NWRS/USFWS
#Formatting Meg Perdue's data from FWS
#November 2017-January 2018
#Sophia Tao
################

install.packages('tidyverse')
library(tidyr)
library(dataone)
library(arcticdatautils)
library(EML)
library(XML)  
library(digest)

# read in files
AKOATSID_1848 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1848.csv')
AKOATSID_1849 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1849.csv')
AKOATSID_1850 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1850.csv')
AKOATSID_1851 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1851.csv')
AKOATSID_1852 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1852.csv')
AKOATSID_1854 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1854.csv')
AKOATSID_1855 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1855.csv')
AKOATSID_1856 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1856.csv')
AKOATSID_1857 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1857.csv')
AKOATSID_1858 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1858.csv')
AKOATSID_1859 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1859.csv')
AKOATSID_1860 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1860.csv')
AKOATSID_1861 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1861.csv')
AKOATSID_1862 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1862.csv')
AKOATSID_1863 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1863.csv')
AKOATSID_1864 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1864.csv')
AKOATSID_1865 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1865.csv')
AKOATSID_1866 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1866.csv')
AKOATSID_1867 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1867.csv')
AKOATSID_1868 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1868.csv')
AKOATSID_1869 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1869.csv')
AKOATSID_1870 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1870.csv')
AKOATSID_1871 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1871.csv')
AKOATSID_1877 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1877.csv')
AKOATSID_1878 <- read.csv('/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1878.csv')
ID1872 <- read.csv('/home/stao/my-sasap/129/Reformatted/ID1872.csv')
ID1873 <- read.csv('/home/stao/my-sasap/129/Reformatted/ID1873.csv')
ID1874 <- read.csv('/home/stao/my-sasap/129/Reformatted/ID1874.csv')
ID1875 <- read.csv('/home/stao/my-sasap/129/Reformatted/ID1875.csv')
ID1876 <- read.csv('/home/stao/my-sasap/129/Reformatted/ID1876.csv')
ID1617 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1617.csv')
ID1618 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1618.csv')
ID1619 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1619.csv')
ID1620 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1620.csv')
ID1621 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1621.csv')
ID1622 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1622.csv')
ID1623 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1623.csv')
ID1624 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1624.csv')
ID1879 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1879.csv')
ID1880 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1880.csv')
ID1928 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1928.csv')
ID1929 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1929.csv')
ID1930 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1930.csv')
ID1932 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_1932.csv')
ID663 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_663.csv')
ID664 <- read.csv('/home/stao/my-sasap/129/Kodiak/AKOATSID_664.csv')

# add in AKOATS_ID column

AKOATSID_1848$AKOATS_ID <- '1848'
AKOATSID_1849$AKOATS_ID <- '1849'
AKOATSID_1850$AKOATS_ID <- '1850'
AKOATSID_1851$AKOATS_ID <- '1851'
AKOATSID_1852$AKOATS_ID <- '1852'
AKOATSID_1854$AKOATS_ID <- '1854'
AKOATSID_1855$AKOATS_ID <- '1855'
AKOATSID_1856$AKOATS_ID <- '1856'
AKOATSID_1857$AKOATS_ID <- '1857'
AKOATSID_1858$AKOATS_ID <- '1858'
AKOATSID_1859$AKOATS_ID <- '1859'
AKOATSID_1860$AKOATS_ID <- '1860'
AKOATSID_1861$AKOATS_ID <- '1861'
AKOATSID_1862$AKOATS_ID <- '1862'
AKOATSID_1863$AKOATS_ID <- '1863'
AKOATSID_1864$AKOATS_ID <- '1864'
AKOATSID_1865$AKOATS_ID <- '1865'
AKOATSID_1866$AKOATS_ID <- '1866'
AKOATSID_1867$AKOATS_ID <- '1867'
AKOATSID_1868$AKOATS_ID <- '1868'
AKOATSID_1869$AKOATS_ID <- '1869'
AKOATSID_1870$AKOATS_ID <- '1870'
AKOATSID_1871$AKOATS_ID <- '1871'
AKOATSID_1877$AKOATS_ID <- '1877'
AKOATSID_1878$AKOATS_ID <- '1878'
ID1872$AKOATS_ID <- '1872'
ID1873$AKOATS_ID <- '1873'
ID1874$AKOATS_ID <- '1874'
ID1875$AKOATS_ID <- '1875'
ID1876$AKOATS_ID <- '1876'
ID1617$AKOATS_ID <- '1617'
ID1618$AKOATS_ID <- '1618'
ID1619$AKOATS_ID <- '1619'
ID1620$AKOATS_ID <- '1620'
ID1621$AKOATS_ID <- '1621'
ID1622$AKOATS_ID <- '1622'
ID1623$AKOATS_ID <- '1623'
ID1624$AKOATS_ID <- '1624'
ID1879$AKOATS_ID <- '1879'
ID1880$AKOATS_ID <- '1880'
ID1928$AKOATS_ID <- '1928'
ID1929$AKOATS_ID <- '1929'
ID1930$AKOATS_ID <- '1930'
ID1932$AKOATS_ID <- '1932'
ID663$AKOATS_ID <- '663'
ID664$AKOATS_ID <- '664'

# add in UseData column and fill with '1' 
AKOATSID_1848$UseData <- '1'
AKOATSID_1849$UseData <- '1'
AKOATSID_1850$UseData <- '1'
AKOATSID_1851$UseData <- '1'
AKOATSID_1852$UseData <- '1'
AKOATSID_1854$UseData <- '1'
AKOATSID_1855$UseData <- '1'
AKOATSID_1856$UseData <- '1'
AKOATSID_1857$UseData <- '1'
AKOATSID_1858$UseData <- '1'
AKOATSID_1859$UseData <- '1'
AKOATSID_1860$UseData <- '1'
AKOATSID_1861$UseData <- '1'
AKOATSID_1862$UseData <- '1'
AKOATSID_1863$UseData <- '1'
AKOATSID_1864$UseData <- '1'
AKOATSID_1865$UseData <- '1'
AKOATSID_1866$UseData <- '1'
AKOATSID_1867$UseData <- '1'
AKOATSID_1868$UseData <- '1'
AKOATSID_1869$UseData <- '1'
AKOATSID_1870$UseData <- '1'
AKOATSID_1871$UseData <- '1'
AKOATSID_1877$UseData <- '1'
AKOATSID_1878$UseData <- '1'
ID1872$UseData <- '1'
ID1873$UseData <- '1'
ID1874$UseData <- '1'
ID1875$UseData <- '1'
ID1876$UseData <- '1'
ID1617$UseData <- '1'
ID1618$UseData <- '1'
ID1619$UseData <- '1'
ID1620$UseData <- '1'
ID1621$UseData <- '1'
ID1622$UseData <- '1'
ID1623$UseData <- '1'
ID1624$UseData <- '1'
ID1879$UseData <- '1'
ID1880$UseData <- '1'
ID1928$UseData <- '1'
ID1929$UseData <- '1'
ID1930$UseData <- '1'
ID1932$UseData <- '1'
ID663$UseData <- '1'
ID664$UseData <- '1'

#########
# rename columns
#########

# rename "Date" to "sampleDate"
colnames(AKOATSID_1848)[colnames(AKOATSID_1848)=="Date"] <- "sampleDate"
colnames(AKOATSID_1849)[colnames(AKOATSID_1849)=="Date"] <- "sampleDate"
colnames(AKOATSID_1850)[colnames(AKOATSID_1850)=="Date"] <- "sampleDate"
colnames(AKOATSID_1851)[colnames(AKOATSID_1851)=="Date"] <- "sampleDate"
colnames(AKOATSID_1852)[colnames(AKOATSID_1852)=="Date"] <- "sampleDate"
colnames(AKOATSID_1854)[colnames(AKOATSID_1854)=="Date"] <- "sampleDate"
colnames(AKOATSID_1855)[colnames(AKOATSID_1855)=="Date"] <- "sampleDate"
colnames(AKOATSID_1856)[colnames(AKOATSID_1856)=="Date"] <- "sampleDate"
colnames(AKOATSID_1857)[colnames(AKOATSID_1857)=="Date"] <- "sampleDate"
colnames(AKOATSID_1858)[colnames(AKOATSID_1858)=="Date"] <- "sampleDate"
colnames(AKOATSID_1859)[colnames(AKOATSID_1859)=="Date"] <- "sampleDate"
colnames(AKOATSID_1860)[colnames(AKOATSID_1860)=="Date"] <- "sampleDate"
colnames(AKOATSID_1861)[colnames(AKOATSID_1861)=="Date"] <- "sampleDate"
colnames(AKOATSID_1862)[colnames(AKOATSID_1862)=="Date"] <- "sampleDate"
colnames(AKOATSID_1863)[colnames(AKOATSID_1863)=="Date"] <- "sampleDate"
colnames(AKOATSID_1864)[colnames(AKOATSID_1864)=="Date"] <- "sampleDate"
colnames(AKOATSID_1865)[colnames(AKOATSID_1865)=="Date"] <- "sampleDate"
colnames(AKOATSID_1866)[colnames(AKOATSID_1866)=="Date"] <- "sampleDate"
colnames(AKOATSID_1867)[colnames(AKOATSID_1867)=="Date"] <- "sampleDate"
colnames(AKOATSID_1868)[colnames(AKOATSID_1868)=="Date"] <- "sampleDate"
colnames(AKOATSID_1869)[colnames(AKOATSID_1869)=="Date"] <- "sampleDate"
colnames(AKOATSID_1870)[colnames(AKOATSID_1870)=="Date"] <- "sampleDate"
colnames(AKOATSID_1871)[colnames(AKOATSID_1871)=="Date"] <- "sampleDate"
colnames(AKOATSID_1877)[colnames(AKOATSID_1877)=="Date"] <- "sampleDate"
colnames(AKOATSID_1878)[colnames(AKOATSID_1878)=="Date"] <- "sampleDate"
colnames(ID1872)[colnames(ID1872)=="Date"] <- "sampleDate"
colnames(ID1873)[colnames(ID1873)=="Date"] <- "sampleDate"
colnames(ID1874)[colnames(ID1874)=="Date"] <- "sampleDate"
colnames(ID1875)[colnames(ID1875)=="Date"] <- "sampleDate"
colnames(ID1876)[colnames(ID1876)=="Date"] <- "sampleDate"
colnames(ID1617)[colnames(ID1617)=="Date"] <- "sampleDate"
colnames(ID1618)[colnames(ID1618)=="Date"] <- "sampleDate"
colnames(ID1619)[colnames(ID1619)=="Date"] <- "sampleDate"
colnames(ID1620)[colnames(ID1620)=="Date"] <- "sampleDate"
colnames(ID1621)[colnames(ID1621)=="Date"] <- "sampleDate"
colnames(ID1622)[colnames(ID1622)=="Date"] <- "sampleDate"
colnames(ID1623)[colnames(ID1623)=="Date"] <- "sampleDate"
colnames(ID1624)[colnames(ID1624)=="Date"] <- "sampleDate"
colnames(ID1879)[colnames(ID1879)=="Date"] <- "sampleDate"
colnames(ID1880)[colnames(ID1880)=="Date"] <- "sampleDate"
colnames(ID1928)[colnames(ID1928)=="Date"] <- "sampleDate"
colnames(ID1929)[colnames(ID1929)=="Date"] <- "sampleDate"
colnames(ID1930)[colnames(ID1930)=="Date"] <- "sampleDate"
colnames(ID1932)[colnames(ID1932)=="Date"] <- "sampleDate"
colnames(ID663)[colnames(ID663)=="Date"] <- "sampleDate"
colnames(ID664)[colnames(ID664)=="Date"] <- "sampleDate"

# rename "Time" to "sampleTime"

colnames(AKOATSID_1848)[colnames(AKOATSID_1848)=="Time"] <- "sampleTime"
colnames(AKOATSID_1849)[colnames(AKOATSID_1849)=="Time"] <- "sampleTime"
colnames(AKOATSID_1850)[colnames(AKOATSID_1850)=="Time"] <- "sampleTime"
colnames(AKOATSID_1851)[colnames(AKOATSID_1851)=="Time"] <- "sampleTime"
colnames(AKOATSID_1852)[colnames(AKOATSID_1852)=="Time"] <- "sampleTime"
colnames(AKOATSID_1854)[colnames(AKOATSID_1854)=="Time"] <- "sampleTime"
colnames(AKOATSID_1855)[colnames(AKOATSID_1855)=="Time"] <- "sampleTime"
colnames(AKOATSID_1856)[colnames(AKOATSID_1856)=="Time"] <- "sampleTime"
colnames(AKOATSID_1857)[colnames(AKOATSID_1857)=="Time"] <- "sampleTime"
colnames(AKOATSID_1858)[colnames(AKOATSID_1858)=="Time"] <- "sampleTime"
colnames(AKOATSID_1859)[colnames(AKOATSID_1859)=="Time"] <- "sampleTime"
colnames(AKOATSID_1860)[colnames(AKOATSID_1860)=="Time"] <- "sampleTime"
colnames(AKOATSID_1861)[colnames(AKOATSID_1861)=="Time"] <- "sampleTime"
colnames(AKOATSID_1862)[colnames(AKOATSID_1862)=="Time"] <- "sampleTime"
colnames(AKOATSID_1863)[colnames(AKOATSID_1863)=="Time"] <- "sampleTime"
colnames(AKOATSID_1864)[colnames(AKOATSID_1864)=="Time"] <- "sampleTime"
colnames(AKOATSID_1865)[colnames(AKOATSID_1865)=="Time"] <- "sampleTime"
colnames(AKOATSID_1866)[colnames(AKOATSID_1866)=="Time"] <- "sampleTime"
colnames(AKOATSID_1867)[colnames(AKOATSID_1867)=="Time"] <- "sampleTime"
colnames(AKOATSID_1868)[colnames(AKOATSID_1868)=="Time"] <- "sampleTime"
colnames(AKOATSID_1869)[colnames(AKOATSID_1869)=="Time"] <- "sampleTime"
colnames(AKOATSID_1870)[colnames(AKOATSID_1870)=="Time"] <- "sampleTime"
colnames(AKOATSID_1871)[colnames(AKOATSID_1871)=="Time"] <- "sampleTime"
colnames(AKOATSID_1877)[colnames(AKOATSID_1877)=="Time"] <- "sampleTime"
colnames(AKOATSID_1878)[colnames(AKOATSID_1878)=="Time"] <- "sampleTime"
colnames(ID1872)[colnames(ID1872)=="Time"] <- "sampleTime"
colnames(ID1873)[colnames(ID1873)=="Time"] <- "sampleTime"
colnames(ID1874)[colnames(ID1874)=="Time"] <- "sampleTime"
colnames(ID1875)[colnames(ID1875)=="Time"] <- "sampleTime"
colnames(ID1876)[colnames(ID1876)=="Time"] <- "sampleTime"
colnames(ID1617)[colnames(ID1617)=="Time"] <- "sampleTime"
colnames(ID1618)[colnames(ID1618)=="Time"] <- "sampleTime"
colnames(ID1619)[colnames(ID1619)=="Time"] <- "sampleTime"
colnames(ID1620)[colnames(ID1620)=="Time"] <- "sampleTime"
colnames(ID1621)[colnames(ID1621)=="Time"] <- "sampleTime"
colnames(ID1622)[colnames(ID1622)=="Time"] <- "sampleTime"
colnames(ID1623)[colnames(ID1623)=="Time"] <- "sampleTime"
colnames(ID1624)[colnames(ID1624)=="Time"] <- "sampleTime"
colnames(ID1879)[colnames(ID1879)=="Time"] <- "sampleTime"
colnames(ID1880)[colnames(ID1880)=="Time"] <- "sampleTime"
colnames(ID1928)[colnames(ID1928)=="Time"] <- "sampleTime"
colnames(ID1929)[colnames(ID1929)=="Time"] <- "sampleTime"
colnames(ID1930)[colnames(ID1930)=="Time"] <- "sampleTime"
colnames(ID1932)[colnames(ID1932)=="Time"] <- "sampleTime"
colnames(ID663)[colnames(ID663)=="Time"] <- "sampleTime"
colnames(ID664)[colnames(ID664)=="Time"] <- "sampleTime"

# rename "Water Temperature [°C]" to "Temperature"
colnames(AKOATSID_1848)[colnames(AKOATSID_1848)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1849)[colnames(AKOATSID_1849)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1850)[colnames(AKOATSID_1850)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1851)[colnames(AKOATSID_1851)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1852)[colnames(AKOATSID_1852)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1854)[colnames(AKOATSID_1854)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1855)[colnames(AKOATSID_1855)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1856)[colnames(AKOATSID_1856)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1857)[colnames(AKOATSID_1857)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1858)[colnames(AKOATSID_1858)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1859)[colnames(AKOATSID_1859)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1860)[colnames(AKOATSID_1860)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1861)[colnames(AKOATSID_1861)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1862)[colnames(AKOATSID_1862)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1863)[colnames(AKOATSID_1863)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1864)[colnames(AKOATSID_1864)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1865)[colnames(AKOATSID_1865)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1866)[colnames(AKOATSID_1866)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1867)[colnames(AKOATSID_1867)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1868)[colnames(AKOATSID_1868)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1869)[colnames(AKOATSID_1869)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1870)[colnames(AKOATSID_1870)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1871)[colnames(AKOATSID_1871)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1877)[colnames(AKOATSID_1877)=="Water.Temperature...C."] <- "Temperature"
colnames(AKOATSID_1878)[colnames(AKOATSID_1878)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1872)[colnames(ID1872)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1873)[colnames(ID1873)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1874)[colnames(ID1874)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1875)[colnames(ID1875)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1876)[colnames(ID1876)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1617)[colnames(ID1617)=="Water.Temperature...C..at.5.meters"] <- "Temperature"
colnames(ID1618)[colnames(ID1618)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1619)[colnames(ID1619)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1620)[colnames(ID1620)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1621)[colnames(ID1621)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1622)[colnames(ID1622)=="Water.Temperature...C..at.5.meters"] <- "Temperature"
colnames(ID1623)[colnames(ID1623)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1624)[colnames(ID1624)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1879)[colnames(ID1879)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1880)[colnames(ID1880)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1928)[colnames(ID1928)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1929)[colnames(ID1929)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1930)[colnames(ID1930)=="Water.Temperature...C."] <- "Temperature"
colnames(ID1932)[colnames(ID1932)=="Water.Temperature...C."] <- "Temperature"
colnames(ID663)[colnames(ID663)=="Water.Temperature...C..at.5.meters"] <- "Temperature"
colnames(ID664)[colnames(ID664)=="Water.Temperature...C..at.5.meters"] <- "Temperature"


########
# index observations that have NA's for any of the columns 
########

# replace '---' with NA 
AKOATSID_1848$Temperature <- gsub("---", NA, AKOATSID_1848$Temperature)
AKOATSID_1849$Temperature <- gsub("---", NA, AKOATSID_1849$Temperature)
AKOATSID_1850$Temperature <- gsub("---", NA, AKOATSID_1850$Temperature)
AKOATSID_1851$Temperature <- gsub("---", NA, AKOATSID_1851$Temperature)
AKOATSID_1852$Temperature <- gsub("---", NA, AKOATSID_1852$Temperature)
AKOATSID_1854$Temperature <- gsub("---", NA, AKOATSID_1854$Temperature)
AKOATSID_1855$Temperature <- gsub("---", NA, AKOATSID_1855$Temperature)
AKOATSID_1856$Temperature <- gsub("---", NA, AKOATSID_1856$Temperature)
AKOATSID_1857$Temperature <- gsub("---", NA, AKOATSID_1857$Temperature)
AKOATSID_1858$Temperature <- gsub("---", NA, AKOATSID_1858$Temperature)
AKOATSID_1859$Temperature <- gsub("---", NA, AKOATSID_1859$Temperature)
AKOATSID_1860$Temperature <- gsub("---", NA, AKOATSID_1860$Temperature)
AKOATSID_1861$Temperature <- gsub("---", NA, AKOATSID_1861$Temperature)
AKOATSID_1862$Temperature <- gsub("---", NA, AKOATSID_1862$Temperature)
AKOATSID_1863$Temperature <- gsub("---", NA, AKOATSID_1863$Temperature)
AKOATSID_1864$Temperature <- gsub("---", NA, AKOATSID_1864$Temperature)
AKOATSID_1865$Temperature <- gsub("---", NA, AKOATSID_1865$Temperature)
AKOATSID_1866$Temperature <- gsub("---", NA, AKOATSID_1866$Temperature)
AKOATSID_1867$Temperature <- gsub("---", NA, AKOATSID_1867$Temperature)
AKOATSID_1868$Temperature <- gsub("---", NA, AKOATSID_1868$Temperature)
AKOATSID_1869$Temperature <- gsub("---", NA, AKOATSID_1869$Temperature)
AKOATSID_1870$Temperature <- gsub("---", NA, AKOATSID_1870$Temperature)
AKOATSID_1871$Temperature <- gsub("---", NA, AKOATSID_1871$Temperature)
AKOATSID_1877$Temperature <- gsub("---", NA, AKOATSID_1877$Temperature)
AKOATSID_1878$Temperature <- gsub("---", NA, AKOATSID_1878$Temperature)
ID1872$Temperature <- gsub("---", NA, ID1872$Temperature)
ID1873$Temperature <- gsub("---", NA, ID1873$Temperature)
ID1874$Temperature <- gsub("---", NA, ID1874$Temperature)
ID1875$Temperature <- gsub("---", NA, ID1875$Temperature)
ID1876$Temperature <- gsub("---", NA, ID1876$Temperature)
ID1617$Temperature <- gsub("---", NA, ID1617$Temperature)
ID1618$Temperature <- gsub("---", NA, ID1618$Temperature)
ID1619$Temperature <- gsub("---", NA, ID1619$Temperature)
ID1620$Temperature <- gsub("---", NA, ID1620$Temperature)
ID1621$Temperature <- gsub("---", NA, ID1621$Temperature)
ID1622$Temperature <- gsub("---", NA, ID1622$Temperature)
ID1623$Temperature <- gsub("---", NA, ID1623$Temperature)
ID1624$Temperature <- gsub("---", NA, ID1624$Temperature)
ID1928$Temperature <- gsub("---", NA, ID1928$Temperature)
ID1929$Temperature <- gsub("---", NA, ID1929$Temperature)
ID1930$Temperature <- gsub("---", NA, ID1930$Temperature)
ID1932$Temperature <- gsub("---", NA, ID1932$Temperature)
ID1879$Temperature <- gsub("---", NA, ID1879$Temperature)
ID1880$Temperature <- gsub("---", NA, ID1880$Temperature)
ID663$Temperature <- gsub("---", NA, ID663$Temperature)
ID664$Temperature <- gsub("---", NA, ID664$Temperature)


##################
# reformat Dates
###################

AKOATSID_1848$sampleDate <- strptime(as.character(AKOATSID_1848$sampleDate), "%m/%d/%y")
AKOATSID_1848$sampleDate <- format(AKOATSID_1848$sampleDate, "%Y-%m-%d")
AKOATSID_1849$sampleDate <- strptime(as.character(AKOATSID_1849$sampleDate), "%m/%d/%y")
AKOATSID_1849$sampleDate <- format(AKOATSID_1849$sampleDate, "%Y-%m-%d")
AKOATSID_1850$sampleDate <- strptime(as.character(AKOATSID_1850$sampleDate), "%m/%d/%y")
AKOATSID_1850$sampleDate <- format(AKOATSID_1850$sampleDate, "%Y-%m-%d")
AKOATSID_1851$sampleDate <- strptime(as.character(AKOATSID_1851$sampleDate), "%m/%d/%y")
AKOATSID_1851$sampleDate <- format(AKOATSID_1851$sampleDate, "%Y-%m-%d")
AKOATSID_1852$sampleDate <- strptime(as.character(AKOATSID_1852$sampleDate), "%m/%d/%y")
AKOATSID_1852$sampleDate <- format(AKOATSID_1852$sampleDate, "%Y-%m-%d")
AKOATSID_1854$sampleDate <- strptime(as.character(AKOATSID_1854$sampleDate), "%m/%d/%y")
AKOATSID_1854$sampleDate <- format(AKOATSID_1854$sampleDate, "%Y-%m-%d")
AKOATSID_1855$sampleDate <- strptime(as.character(AKOATSID_1855$sampleDate), "%m/%d/%y")
AKOATSID_1855$sampleDate <- format(AKOATSID_1855$sampleDate, "%Y-%m-%d")
AKOATSID_1856$sampleDate <- strptime(as.character(AKOATSID_1856$sampleDate), "%m/%d/%y")
AKOATSID_1856$sampleDate <- format(AKOATSID_1856$sampleDate, "%Y-%m-%d")
AKOATSID_1857$sampleDate <- strptime(as.character(AKOATSID_1857$sampleDate), "%m/%d/%y")
AKOATSID_1857$sampleDate <- format(AKOATSID_1857$sampleDate, "%Y-%m-%d")
AKOATSID_1858$sampleDate <- strptime(as.character(AKOATSID_1858$sampleDate), "%m/%d/%y")
AKOATSID_1858$sampleDate <- format(AKOATSID_1858$sampleDate, "%Y-%m-%d")
AKOATSID_1859$sampleDate <- strptime(as.character(AKOATSID_1859$sampleDate), "%m/%d/%y")
AKOATSID_1859$sampleDate <- format(AKOATSID_1859$sampleDate, "%Y-%m-%d")
AKOATSID_1860$sampleDate <- strptime(as.character(AKOATSID_1860$sampleDate), "%m/%d/%y")
AKOATSID_1860$sampleDate <- format(AKOATSID_1860$sampleDate, "%Y-%m-%d")
AKOATSID_1861$sampleDate <- strptime(as.character(AKOATSID_1861$sampleDate), "%m/%d/%y")
AKOATSID_1861$sampleDate <- format(AKOATSID_1861$sampleDate, "%Y-%m-%d")
AKOATSID_1862$sampleDate <- strptime(as.character(AKOATSID_1862$sampleDate), "%m/%d/%y")
AKOATSID_1862$sampleDate <- format(AKOATSID_1862$sampleDate, "%Y-%m-%d")
AKOATSID_1863$sampleDate <- strptime(as.character(AKOATSID_1863$sampleDate), "%m/%d/%y")
AKOATSID_1863$sampleDate <- format(AKOATSID_1863$sampleDate, "%Y-%m-%d")
AKOATSID_1864$sampleDate <- strptime(as.character(AKOATSID_1864$sampleDate), "%m/%d/%y")
AKOATSID_1864$sampleDate <- format(AKOATSID_1864$sampleDate, "%Y-%m-%d")
AKOATSID_1865$sampleDate <- strptime(as.character(AKOATSID_1865$sampleDate), "%m/%d/%y")
AKOATSID_1865$sampleDate <- format(AKOATSID_1865$sampleDate, "%Y-%m-%d")
AKOATSID_1866$sampleDate <- strptime(as.character(AKOATSID_1866$sampleDate), "%m/%d/%y")
AKOATSID_1866$sampleDate <- format(AKOATSID_1866$sampleDate, "%Y-%m-%d")
AKOATSID_1867$sampleDate <- strptime(as.character(AKOATSID_1867$sampleDate), "%m/%d/%y")
AKOATSID_1867$sampleDate <- format(AKOATSID_1867$sampleDate, "%Y-%m-%d")
AKOATSID_1868$sampleDate <- strptime(as.character(AKOATSID_1868$sampleDate), "%m/%d/%y")
AKOATSID_1868$sampleDate <- format(AKOATSID_1868$sampleDate, "%Y-%m-%d")
AKOATSID_1869$sampleDate <- strptime(as.character(AKOATSID_1869$sampleDate), "%m/%d/%y")
AKOATSID_1869$sampleDate <- format(AKOATSID_1869$sampleDate, "%Y-%m-%d")
AKOATSID_1870$sampleDate <- strptime(as.character(AKOATSID_1870$sampleDate), "%m/%d/%y")
AKOATSID_1870$sampleDate <- format(AKOATSID_1870$sampleDate, "%Y-%m-%d")
AKOATSID_1871$sampleDate <- strptime(as.character(AKOATSID_1871$sampleDate), "%m/%d/%y")
AKOATSID_1871$sampleDate <- format(AKOATSID_1871$sampleDate, "%Y-%m-%d")
AKOATSID_1877$sampleDate <- strptime(as.character(AKOATSID_1877$sampleDate), "%m/%d/%y")
AKOATSID_1877$sampleDate <- format(AKOATSID_1877$sampleDate, "%Y-%m-%d")
AKOATSID_1878$sampleDate <- strptime(as.character(AKOATSID_1878$sampleDate), "%m/%d/%y")
AKOATSID_1878$sampleDate <- format(AKOATSID_1878$sampleDate, "%Y-%m-%d")
ID1872$sampleDate <- strptime(as.character(ID1872$sampleDate), "%m/%d/%y")
ID1872$sampleDate <- format(ID1872$sampleDate, "%Y-%m-%d")
ID1873$sampleDate <- strptime(as.character(ID1873$sampleDate), "%m/%d/%y")
ID1873$sampleDate <- format(ID1873$sampleDate, "%Y-%m-%d")
ID1874$sampleDate <- strptime(as.character(ID1874$sampleDate), "%m/%d/%y")
ID1874$sampleDate <- format(ID1874$sampleDate, "%Y-%m-%d")
ID1875$sampleDate <- strptime(as.character(ID1875$sampleDate), "%m/%d/%y")
ID1875$sampleDate <- format(ID1875$sampleDate, "%Y-%m-%d")
ID1876$sampleDate <- strptime(as.character(ID1876$sampleDate), "%m/%d/%y")
ID1876$sampleDate <- format(ID1876$sampleDate, "%Y-%m-%d")
ID1617$sampleDate <- strptime(as.character(ID1617$sampleDate), "%m/%d/%y")
ID1617$sampleDate <- format(ID1617$sampleDate, "%Y-%m-%d")
ID1618$sampleDate <- strptime(as.character(ID1618$sampleDate), "%m/%d/%y")
ID1618$sampleDate <- format(ID1618$sampleDate, "%Y-%m-%d")
ID1619$sampleDate <- strptime(as.character(ID1619$sampleDate), "%m/%d/%y")
ID1619$sampleDate <- format(ID1619$sampleDate, "%Y-%m-%d")
ID1620$sampleDate <- strptime(as.character(ID1620$sampleDate), "%m/%d/%y")
ID1620$sampleDate <- format(ID1620$sampleDate, "%Y-%m-%d")
ID1621$sampleDate <- strptime(as.character(ID1621$sampleDate), "%m/%d/%y")
ID1621$sampleDate <- format(ID1621$sampleDate, "%Y-%m-%d")
ID1622$sampleDate <- strptime(as.character(ID1622$sampleDate), "%m/%d/%y")
ID1622$sampleDate <- format(ID1622$sampleDate, "%Y-%m-%d")
ID1623$sampleDate <- strptime(as.character(ID1623$sampleDate), "%m/%d/%y")
ID1623$sampleDate <- format(ID1623$sampleDate, "%Y-%m-%d")
ID1624$sampleDate <- strptime(as.character(ID1624$sampleDate), "%m/%d/%y")
ID1624$sampleDate <- format(ID1624$sampleDate, "%Y-%m-%d")
ID1879$sampleDate <- strptime(as.character(ID1879$sampleDate), "%m/%d/%y")
ID1879$sampleDate <- format(ID1879$sampleDate, "%Y-%m-%d")
ID1880$sampleDate <- strptime(as.character(ID1880$sampleDate), "%m/%d/%y")
ID1880$sampleDate <- format(ID1880$sampleDate, "%Y-%m-%d")
ID1928$sampleDate <- strptime(as.character(ID1928$sampleDate), "%m/%d/%y")
ID1928$sampleDate <- format(ID1928$sampleDate, "%Y-%m-%d")
ID1929$sampleDate <- strptime(as.character(ID1929$sampleDate), "%m/%d/%y")
ID1929$sampleDate <- format(ID1929$sampleDate, "%Y-%m-%d")
ID1930$sampleDate <- strptime(as.character(ID1930$sampleDate), "%m/%d/%y")
ID1930$sampleDate <- format(ID1930$sampleDate, "%Y-%m-%d")
ID1932$sampleDate <- strptime(as.character(ID1932$sampleDate), "%m/%d/%y")
ID1932$sampleDate <- format(ID1932$sampleDate, "%Y-%m-%d")
ID663$sampleDate <- strptime(as.character(ID663$sampleDate), "%m/%d/%y")
ID663$sampleDate <- format(ID663$sampleDate, "%Y-%m-%d")
ID664$sampleDate <- strptime(as.character(ID664$sampleDate), "%m/%d/%y")
ID664$sampleDate <- format(ID664$sampleDate, "%Y-%m-%d")

############
# write csv
############

write.csv(AKOATSID_1848,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1848.csv', row.names = F)
write.csv(AKOATSID_1849,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1849.csv', row.names = F)
write.csv(AKOATSID_1850,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1850.csv', row.names = F)
write.csv(AKOATSID_1851,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1851.csv', row.names = F)
write.csv(AKOATSID_1852,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1852.csv', row.names = F)
write.csv(AKOATSID_1854,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1854.csv', row.names = F)
write.csv(AKOATSID_1855,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1855.csv', row.names = F)
write.csv(AKOATSID_1856,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1856.csv', row.names = F)
write.csv(AKOATSID_1857,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1857.csv', row.names = F)
write.csv(AKOATSID_1858,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1858.csv', row.names = F)
write.csv(AKOATSID_1859,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1859.csv', row.names = F)
write.csv(AKOATSID_1860,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1860.csv', row.names = F)
write.csv(AKOATSID_1861,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1861.csv', row.names = F)
write.csv(AKOATSID_1862,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1862.csv', row.names = F)
write.csv(AKOATSID_1863,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1863.csv', row.names = F)
write.csv(AKOATSID_1864,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1864.csv', row.names = F)
write.csv(AKOATSID_1865,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1865.csv', row.names = F)
write.csv(AKOATSID_1866,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1866.csv', row.names = F)
write.csv(AKOATSID_1867,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1867.csv', row.names = F)
write.csv(AKOATSID_1868,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1868.csv', row.names = F)
write.csv(AKOATSID_1869,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1869.csv', row.names = F)
write.csv(AKOATSID_1870,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1870.csv', row.names = F)
write.csv(AKOATSID_1871,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1871.csv', row.names = F)
write.csv(AKOATSID_1877,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1877.csv', row.names = F)
write.csv(AKOATSID_1878,'/home/stao/my-sasap/129/toBe_Reformatted/AKOATSID_1878.csv', row.names = F)
write.csv(ID1872,'/home/stao/my-sasap/129/Reformatted/ID1872.csv', row.names = F)
write.csv(ID1873,'/home/stao/my-sasap/129/Reformatted/ID1873.csv', row.names = F)
write.csv(ID1874,'/home/stao/my-sasap/129/Reformatted/ID1874.csv', row.names = F)
write.csv(ID1875,'/home/stao/my-sasap/129/Reformatted/ID1875.csv', row.names = F)
write.csv(ID1876,'/home/stao/my-sasap/129/Reformatted/ID1876.csv', row.names = F)
write.csv(ID1879,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1879.csv', row.names = F)
write.csv(ID1880,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1880.csv', row.names = F)
write.csv(ID1617,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1617.csv', row.names = F)
write.csv(ID1618,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1618.csv', row.names = F)
write.csv(ID1619,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1619.csv', row.names = F)
write.csv(ID1620,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1620.csv', row.names = F)
write.csv(ID1621,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1621.csv', row.names = F)
write.csv(ID1622,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1622.csv', row.names = F)
write.csv(ID1623,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1623.csv', row.names = F)
write.csv(ID1624,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1624.csv', row.names = F)
write.csv(ID1928,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1928.csv', row.names = F)
write.csv(ID1929,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1929.csv', row.names = F)
write.csv(ID1930,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1930.csv', row.names = F)
write.csv(ID1932,'/home/stao/my-sasap/129/Kodiak/AKOATSID_1932.csv', row.names = F)
write.csv(ID663,'/home/stao/my-sasap/129/Kodiak/AKOATSID_663.csv', row.names = F)
write.csv(ID664,'/home/stao/my-sasap/129/Kodiak/AKOATSID_664.csv', row.names = F)

