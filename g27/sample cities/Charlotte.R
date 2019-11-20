geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    cityGrid[i+geoRadius,j+geoRadius] <- 1
  }
}

#Charlotte City Center
for(x in 650:850){
  for(y in 600:800){
    dist <- sqrt((x - 750) ^ 2 + (y - 700) ^ 2)
    if(dist <= 100)
      cityGrid[x,y] <- 2
  }
}

#image(cityGrid, col = c("blue", "yellow"))
