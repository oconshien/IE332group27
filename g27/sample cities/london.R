geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    cityGrid[i+geoRadius,j+geoRadius] <- 0
  }
}

#London Residential
for(x in 250:1300){
  for(y in 200:1300){
    cityGrid[x,y] <- 1
  }
}

for(x in 0:100){
  for(y in 25:900){
    cityGrid[x,y] <- 1
  }
}

for(x in 1400:1500){
  for(y in 100:1450){
    cityGrid[x,y] <- 1
  }
}

#London Industrial
for(x in 550:950){
  for(y in 550:950){
    cityGrid[x,y] <- 2
  }
}
for(x in 30:250){
  for(y in 1350:1500){
    cityGrid[x,y] <- 2
  }
}

image(cityGrid, col = c("green","blue", "yellow"))