budget <- 100000
cityGrid <- buildCity(1)
MappedNetwork<- SA(budget, cityGrid, just_values = F)
locationSen <- MappedNetwork$best
value <- cityGrid[as.integer(locationSen[1,1]), as.integer(locationSen[1,2])]
#Generated Pm Values
point <- sortPM(Sys.time(), 1)
test <- data.frame("pm010"=100, "pm025"=100, "pm100"=100)
example <- MlClassifier(point)
