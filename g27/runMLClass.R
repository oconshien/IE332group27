budget <- 100000
cityGrid <- buildCity(1)
MappedNetwork<- SA(budget, cityGrid, just_values = F)
locationSen <- MappedNetwork$best
value <- cityGrid[as.integer(locationSen[1,1]), as.integer(locationSen[1,2])]
#Generated Pm Values

date <- as.POSIXlt("2019-05-06 20:51:50 CET")
points <- c("pm010"=0, "pm025"=0, "pm100"=0)
i = 0
while ( i < 100){
point <- sortPM(Sys.time(), 2)
points <- rbind(points, point)
i <- i + 1
}
test <- data.frame("pm010"=100, "pm025"=100, "pm100"=100)

#Run MlClassifier Once then will be able to predict for any pm values
example <- MlClassifier()
try <- data_label(points, example)
