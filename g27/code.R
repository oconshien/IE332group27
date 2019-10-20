## kernal from Kaggle
# https://www.kaggle.com/mistermichael/oxygen-s-overrated-an-eda-of-krakow-air-quality

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

#Geographic information contained in this csv file
sensor_locations <- read_csv("air-quality-data-from-extensive-network-of-sensors/sensor_locations.csv")
#Monthly data contained in these csv files. 
january <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/january-2017.csv"))
february <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/february-2017.csv"))
march <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))
april <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/april-2017.csv"))
may <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/may-2017.csv"))
june <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/june-2017.csv"))
july <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/july-2017.csv"))
august <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/august-2017.csv"))
september <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/september-2017.csv"))
october <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/october-2017.csv"))
november <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/november-2017.csv"))
december <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/december-2017.csv"))

kable( january %>%
         select(`UTC time`, `3_temperature`, `3_humidity`, `3_pressure`) %>%
         head(n=6 ) )

Sys.setenv(TZ='Poland') #we're looking at data from Poland, to avoid erors we'll use this command. If this is not given a timezone error will appear.
january$`UTC time` <- as_datetime(january$`UTC time`)
february$`UTC time` <- as_datetime(february$`UTC time`) 
march$`UTC time` <- as_datetime(march$`UTC time`)
april$`UTC time` <- as_datetime(april$`UTC time`)
may$`UTC time` <- as_datetime(may$`UTC time`)
june$`UTC time` <- as_datetime(june$`UTC time`)
july$`UTC time` <- as_datetime(july$`UTC time`)
august$`UTC time` <- as_datetime(august$`UTC time`)
september$`UTC time` <- as_datetime(september$`UTC time`)
october$`UTC time` <- as_datetime(october$`UTC time`)
november$`UTC time` <- as_datetime(november$`UTC time`)
december$`UTC time` <- as_datetime(december$`UTC time`)

kable(head(is.na(january),n=10))
sum(is.na(january))

# we want to get rid of the NA vaues in columns where NA does not make up the entirety of it.
#running the function with time in it messes with it when I specify to return the result as an integer. I'm not adept with functions, so I'm not quite sure how to fix this. Removing the time column presents a workaround.
jan.test<-january %>% select(-`UTC time`)
# create a function to replace NA values with the median
medrep <- function(i){
  i[is.na(i)] <- median(i, na.rm=TRUE) 
  as.numeric(i)
}
#we can use the apply command to run the function on the dataframe. 
#We're going to return it as a data table like the previous ones.
jan.med<- data.frame(apply(jan.test,2,medrep))
#return date to the dataframe
jan.med<-jan.med %>% mutate(Date=january$`UTC time`)
kable(head(jan.med))

colnames(jan.med)[colSums(is.na(jan.med)) > 0]
jan.med %>%
  ggplot()+
  aes(y=`X142_pm25`, x=`Date`)+
  geom_line()+
  xlab(NULL)+ylab("Sensor 142 PM2.5 Level")+
  theme_tufte()+
  ggtitle("PM2.5 Level Through January w/ Median Imputation Method")

library(caret)
# remove columns where column is totally NA 
jan.knn<-jan.test %>% select_if(~sum(!is.na(.)) > 600) 
# we can assume more than 600 NA values means the whole column is NA, or at the very least is not very useful to our analysis!
jan.knn<-jan.knn %>%
  mutate_all(as.numeric) #ensures all columns are in this format.
# impute by using the preProcess function.
january.predict<-preProcess(jan.knn,
                            method = c("knnImpute", #NOTE that we can also specify "medianImpute" here, which accomplishes the same thing as the function we defined above!!! 
                                       "center", 
                                       "scale"), #center and scale normalize our data. We need to remember this for later.
                            k=5) #specifies the number of nearest neighbors to use.
require(RANN)
#once we have specified a preprocess function, we can use the predict command. We COULD use it on our original dataframe, but I'm going to use it here on the jan.knn dataframe where we have already removed completely NA columns. 
january.knn<-predict(january.predict,jan.knn)
#add the date back in
january.knn<-january.knn %>%
  mutate(Date=january$`UTC time`)
kable(head(january.knn))
january.knn %>%
  ggplot()+
  aes(y=(`142_pm25`*58.9551)+91.13363,x=`Date`)+
  geom_line()+
  xlab(NULL)+
  ylab("Sensor 142 PM2.5 Level")+
  theme_tufte()+
  ggtitle("PM2.5 Level Through January w/ KNN Imputation Method")

sensor_locations <- rename(sensor_locations,sensor=id)
sensor_locations$sensor<- as.factor(sensor_locations$sensor)
leaflet(data=sensor_locations) %>% addProviderTiles("Esri.WorldImagery") %>% 
  addProviderTiles("Esri.WorldStreetMap",options = providerTileOptions(opacity = 0.366))  %>% #note that here I stacked two provider tiles in order to make the map more "complete" since the other option I wanted to use did not zoom in as far as I would have liked. 
  addMarkers(~longitude, ~latitude, label = sensor_locations$sensor)

#####
##  RMySQL
require(RMySQL) # may need to install!
mydb <- dbConnect(MySQL(), user='g1109699', password='MySQL27',
                  dbname='g1109699', host='mydb.itap.purdue.edu')
# important otherwise can leave connection open and ITaP gets MAD as it drains on the MySQL server!
on.exit(dbDisconnect(mydb))
sensortest_df <- data.frame(S_ID=sample(100000:999999,30),
                            N_ID=rep(3, 30),
                            lat=runif(30, min=40.41, max=40.47),
                            lon=runif(30, max=-86.89, min=-86.98),
                            alt=runif(30, min=190.00, max=200.00),
                            type=sample(c('fixed', 'mobile'), 30, replace=TRUE))

dbWriteTable(mydb, "Sensor", sensortest_df, append=TRUE, header=TRUE,row.names=FALSE)
