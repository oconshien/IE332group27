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

january = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/january-2017.csv"))
february = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/february-2017.csv"))
march = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))
april = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/april-2017.csv"))
may = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/may-2017.csv"))
june = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/june-2017.csv"))
july = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/july-2017.csv"))
august = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/august-2017.csv"))
september = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/september-2017.csv"))
october = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/october-2017.csv"))
november = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/november-2017.csv"))
december = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/december-2017.csv"))

Sys.setenv(TZ='Poland') #we're looking at data from Poland, to avoid erors we'll use this command. If this is not given a timezone error will appear.

january$`UTC time` = as_datetime(january$`UTC time`)
february$`UTC time` = as_datetime(february$`UTC time`)
march$`UTC time` = as_datetime(march$`UTC time`)
april$`UTC time` = as_datetime(april$`UTC time`)
may$`UTC time` = as_datetime(may$`UTC time`)
june$`UTC time` = as_datetime(june$`UTC time`)
july$`UTC time` = as_datetime(july$`UTC time`)
august$`UTC time` = as_datetime(august$`UTC time`)
september$`UTC time` = as_datetime(september$`UTC time`)
october$`UTC time` = as_datetime(october$`UTC time`)
november$`UTC time` = as_datetime(november$`UTC time`)
december$`UTC time` = as_datetime(december$`UTC time`)

jan.test = january %>% select(contains("pm"))
feb.test = february %>% select(contains("pm"))
mar.test = march %>% select(contains("pm"))
apr.test = april %>% select(contains("pm"))
may.test = may %>% select(contains("pm"))
jun.test = june %>% select(contains("pm"))
jul.test = july %>% select(contains("pm"))
aug.test = august %>% select(contains("pm"))
sep.test = september %>% select(contains("pm"))
oct.test = october %>% select(contains("pm"))
nov.test = november %>% select(contains("pm"))
dec.test = december %>% select(contains("pm"))
# create a function to replace NA values with the median
medrep = function(i){
  i[is.na(i)] = median(i, na.rm=TRUE) 
  as.numeric(i)
}
jan.med = data.frame(apply(jan.test,2,medrep))
feb.med = data.frame(apply(feb.test,2,medrep))
mar.med = data.frame(apply(mar.test,2,medrep))
apr.med = data.frame(apply(apr.test,2,medrep))
may.med = data.frame(apply(may.test,2,medrep))
jun.med = data.frame(apply(jun.test,2,medrep))
jul.med = data.frame(apply(jul.test,2,medrep))
aug.med = data.frame(apply(aug.test,2,medrep))
sep.med = data.frame(apply(sep.test,2,medrep))
oct.med = data.frame(apply(oct.test,2,medrep))
nov.med = data.frame(apply(nov.test,2,medrep))
dec.med = data.frame(apply(dec.test,2,medrep))

yr.noname = data.frame(   # to store 3 cols of all sensor data from all months
  pm010 = jan.med$X3_pm1,
  pm025 = jan.med$X3_pm25,
  pm100 = jan.med$X3_pm10
)

next3rep = function(df.noname, df.med, col = 1){
  while(col <= length(df.med)-2) {
    df.next3 = df.med[col:(col+2)]
    names(df.next3) = c("pm010", "pm025", "pm100")
    df.noname = rbind(df.noname, df.next3)
    col = col+3
  }
  return(df.noname)
}
yr.noname = next3rep(yr.noname, jan.med, col = 4)  # fill rest of jan
yr.noname = next3rep(yr.noname, feb.med)  # fill with feb
yr.noname = next3rep(yr.noname, mar.med)  # fill with mar
yr.noname = next3rep(yr.noname, apr.med)  # fill with apr
yr.noname = next3rep(yr.noname, may.med)  # fill with may
yr.noname = next3rep(yr.noname, jun.med)  # fill with jun
yr.noname = next3rep(yr.noname, jul.med)  # fill with jul
yr.noname = next3rep(yr.noname, aug.med)  # fill with aug
yr.noname = next3rep(yr.noname, sep.med)  # fill with sep
yr.noname = next3rep(yr.noname, oct.med)  # fill with oct
yr.noname = next3rep(yr.noname, nov.med)  # fill with nov
yr.noname = next3rep(yr.noname, dec.med)  # fill with dec
yr.noname = na.omit(yr.noname)  # eventually omit NA

outliers1 <- boxplot.stats(yr.noname[,1],coef = 3)$out
outliers2 <- boxplot.stats(yr.noname[,2],coef = 3)$out
outliers3 <- boxplot.stats(yr.noname[,3],coef = 3)$out
yr.nout <- yr.noname[-which(yr.noname[,1] %in% outliers1),]
yr.nout <- yr.noname[-which(yr.noname[,2] %in% outliers2),]
yr.nout <- yr.noname[-which(yr.noname[,3] %in% outliers3),]


# we need to take out interquartile
# boxplots.stats

mar.avg_pm010 = mean(mar.noname$pm010)
mar.avg_pm025 = mean(mar.noname$pm025)
mar.avg_pm100 = mean(mar.noname$pm100)
apr.avg_pm010 = mean(apr.noname$pm010)
apr.avg_pm025 = mean(apr.noname$pm025)
apr.avg_pm100 = mean(apr.noname$pm100)
may.avg_pm010 = mean(may.noname$pm010)
may.avg_pm025 = mean(may.noname$pm025)
may.avg_pm100 = mean(may.noname$pm100)
yr.avg_pm010 = mean(yr.noname$pm010)
yr.avg_pm025 = mean(yr.noname$pm025)
yr.avg_pm100 = mean(yr.noname$pm100)
pm010.label = as.factor(ifelse(yr.noname$pm010 >= yr.avg_pm010, 1, 0))  # we need to take out interquartile
pm025.label = as.factor(ifelse(yr.noname$pm025 >= yr.avg_pm025, 1, 0))
pm100.label = as.factor(ifelse(yr.noname$pm100 >= yr.avg_pm100, 1, 0))
# final.data <- cbind(unique.pa[,!names(unique.pa) %in%c("overall_rating","player_api_id")],p.label)