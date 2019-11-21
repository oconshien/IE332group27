geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
      cityGrid[i+geoRadius,j+geoRadius] <- 0
    }
  }

#West Lafayette Residential
for(x in 650:850){
  for(y in 600:1000){
      cityGrid[x,y] <- 1
    }
}

#Lafayette Residential
for(x in 850:1300){
  for(y in 100:800){
    cityGrid[x,y] <- 1
  }
}

#Lafayette Industrial
for(x in 1300:1500){
  for(y in 250:650){
    cityGrid[x,y] <- 2
  }
}

for(x in 800:900){
  for(y in 450:600){
    cityGrid[x,y] <- 2
  }
}

#image(cityGrid, col = c("green","blue", "yellow"))
