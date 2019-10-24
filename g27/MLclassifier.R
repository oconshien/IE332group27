require(readr) #input/output
require(dplyr) #data wrangling
require(lubridate) #date/time
require(knitr) #quite fond of the kable function for making tables.
require(ggplot2) #plotting
require(ggthemes) #plotting
require(gridExtra) #extra space for plots
require(leaflet) #mapping
require(leaflet.extras) #mapping
require(data.table) #data manipulation 
require(RColorBrewer) #plotting
require(stringr) #more data wrangling
require(ggridges) #plotting density ridges
require(tibble) #as_tibble, easy to use

march <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))
