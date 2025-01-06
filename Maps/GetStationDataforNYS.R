## Objective: obtain NOAA stations in central and western NY reporting during 2006-2008

library(dplyr)


# Code adapted from http://blue.for.msu.edu/lab-notes/NOAA_0.1-1/NOAA-ws-data.pdf

# This text file shows that lat and lon are in decimal degrees, and elev is in meters
fileh <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/isd-history.txt"
download.file(fileh, here::here("Maps", "isd-history.txt"), quiet = TRUE)

# This gives the station identifications:
file <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/isd-history.csv"

repeat {
try(download.file(file, here::here("Maps", "isd-history.csv"), quiet = TRUE))
if (file.info(here::here("Maps", "isd-history.csv"))$size > 0) {break}
}


# Read in and process the station data:
st <- read.csv(here::here("Maps", "isd-history.csv"))
# names(st)
names(st)[c(3, 9)] <- c("NAME", "ELEV")
# Want US stations:
st <- st[st$CTRY == "US", ]
# NY stations:
st <- st[st$STATE == "NY", ]


# Because the actual weather station data files are only available per station and year, we can discard the “MMDD” part of the dates (i.e., if a station only collected data for one day in a calendar year, it will have a data file associated with that year)
st$BEGIN <- as.numeric(substr(st$BEGIN, 1, 4))
st$END <- as.numeric(substr(st$END, 1, 4))

# We need stations for 2006-2008
st <- 
  st %>% 
  dplyr::filter(BEGIN < 2006, END >= 2008) %>%
  dplyr::select(WBAN, NAME, LAT, LON)


class(st)
save(st, file = "NYStations.RData")


