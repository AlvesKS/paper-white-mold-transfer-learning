The files in this folder obtain the list of weather stations in the US, and subsets that to those in New York State.
Then, we find the subset of stations reporting during 2006-2008, which are the years in which the snap bean fields were surveyed.
We plot the locations of those weather stations fields and the snap bean fields, as a visual representation of the proxmimity of reporting stations to the fields. 


GetStationDatafor NYS.R
-  downloads the weather station from NOAA ans subsets to those in NYS reporting in 2006-2008.
- saves the resulting dataframe to `NYStations.RData`

MapsNY.Rmd
- the first code chunks explore ways of prooducing maps of the central and western NY counties
- the last chunk finalizes the production of a map showing the snap bean field locations and the reporting weather stations during 2006-2008.