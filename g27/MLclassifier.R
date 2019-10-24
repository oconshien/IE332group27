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

march = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))

Sys.setenv(TZ='Poland') #we're looking at data from Poland, to avoid erors we'll use this command. If this is not given a timezone error will appear.
march$`UTC time` = as_datetime(march$`UTC time`)
mar.test = march %>% select(contains("pm"))
# create a function to replace NA values with the median
medrep = function(i){
  i[is.na(i)] = median(i, na.rm=TRUE) 
  as.numeric(i)
}
mar.med = data.frame(apply(mar.test,2,medrep))

mar.noname = data.frame(
  pm010 = mar.med$X3_pm1,
  pm025 = mar.med$X3_pm25,
  pm100 = mar.med$X3_pm10
)

#eventually omit NA
nona.df = na.omit(raw.df)