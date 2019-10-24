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
next3rep = function(df.noname, df.med){
  col=4
  while(col <= length(df.med)-2) {
    df.next3 = df.med[col:(col+2)]
    names(df.next3) = c("pm010", "pm025", "pm100")
    df.noname = rbind(df.noname, df.next3)
    col = col+3
  }
  return(df.noname)
}
mar.noname = next3rep(mar.noname, mar.med)  # fill rest of march
mar.noname = na.omit(mar.noname)  # eventually omit NA

mean.pm010 = mean(mar.noname$pm010)
mean.pm025 = mean(mar.noname$pm025)
mean.pm100 = mean(mar.noname$pm100)
# p.label <- as.factor(ifelse(unique.pa$overall_rating >= mean.rating, 1, 0))
# final.data <- cbind(unique.pa[,!names(unique.pa) %in%c("overall_rating","player_api_id")],p.label)