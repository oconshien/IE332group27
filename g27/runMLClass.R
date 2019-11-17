#initialization
budget <- 300000
cityGrid <- buildCity(3)
geoRadius <- 15000
city_grid_radius <- geoRadius / 20
MappedNetwork<- SA(budget, cityGrid, geoRadius = 15000, just_values = F)
example <- MlClassifier()
#Generated Pm Values
locationSen <- MappedNetwork$best
locationSen <- cbind(locationSen, "moving"= rep(0, length(locationSen[,1])))
timefromSQL <- 1
datefromSQL <- as.POSIXlt("2019-09-06 20:51:50 CET")
montht <- format(datefromSQL,"%B")
points <- NULL
point <- NULL
dataframeForStates <- NULL
bigData <- NULL
datecnt <- 1
OGmap <- locationSen 
storm_time <- sample(c(0,1), 1, prob = c(0.99, 0.01))

while(datecnt <= 24*timefromSQL){
  points <- NULL
  point <- NULL
  dataframeForStats <- NULL
  i = 1
  print(datecnt)
  while (i <= dim(locationSen)[1]){
    #print(i)
    point <- sortPM(datefromSQL, cityGrid[trunc(locationSen[i,1]/20) + city_grid_radius, trunc(locationSen[i,2]/20) + city_grid_radius], storm_time)
    points <- rbind(points, point)
    i <- i + 1
  }
  #data_tester <- cbind(locationSen, points)
  #Run MlClassifier Once then will be able to predict for any pm values
  try <- data_label(points, example[montht])
  z <- priority_destinations(locationSen, try, 0)
  dataframeForStats <- data.frame(try, "x"=locationSen[,1], "y"=locationSen[,2])
  bigData <- rbind(bigData, dataframeForStats)
  updates <- nearest_sensor_finder(z, locationSen, 0, try)
  locationSen <- updates
  datefromSQL <- datefromSQL + 60*60
  storm_time <- sample(c(0,1), 1, prob = c(0.99, 0.01))
  datecnt <- datecnt + 1
}
