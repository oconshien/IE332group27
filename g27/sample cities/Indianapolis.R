geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    cityGrid[i+geoRadius,j+geoRadius] <- 1
  }
}

#Indianapolis City Center
for(x in 750:900){
  for(y in 700:950){
      cityGrid[x,y] <- 2
  }
}

#Rural Bottom Right
for(x in 0:900){
  for(y in 850:1500){
    cityGrid[x,y] <- 2
  }
}

#image(cityGrid, col = c("blue", "yellow"))
