
budget <- 300000
cityGrid <- buildCity(1)
city_grid_radius <- 750
MappedNetwork<- SA(budget, cityGrid, just_values = F)
locationSen <- MappedNetwork$best
value <- cityGrid[as.integer(locationSen[1,1]), as.integer(locationSen[1,2])]
#Generated Pm Values

date <- as.POSIXlt("2019-05-06 20:51:50 CET")
points <- NULL
point <- NULL

i = 1
while (i <= dim(locationSen)[1]){
  point <- sortPM(Sys.time(), cityGrid[trunc(locationSen[i,1]/20) + city_grid_radius, trunc(locationSen[i,2]/20) + city_grid_radius])
  points <- rbind(points, point)
  i <- i + 1
}
test <- data.frame("pm010"=100, "pm025"=100, "pm100"=100)
#data_tester <- cbind(locationSen, points)
#Run MlClassifier Once then will be able to predict for any pm values
example <- MlClassifier()
try <- data_label(points, example)
z <- priority_destinations(locationSen, try)

