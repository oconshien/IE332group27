geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    cityGrid[i+geoRadius,j+geoRadius] <- 0
  }
}

#Lexington Residential
for(x in 750:1100){
  for(y in 550:800){
    cityGrid[x,y] <- 1
  }
}

for(x in 450:1300){
  for(y in 100:350){
    cityGrid[x,y] <- 1
  }
}

for(x in 550:750){
   for(y in 1000:1200){
   cityGrid[x,y] <- 1
  }
}

#Lexington Industrial
for(x in 450:750){
  for(y in 350:750){
    cityGrid[x,y] <- 2
  }
}
for(x in 650:850){
  for(y in 650:850){
    cityGrid[x,y] <- 2
  }
}

image(cityGrid, col = c("green","blue", "yellow"))