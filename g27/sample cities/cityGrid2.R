geoRadius <- 15000/20
cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    dist <- sqrt(i^2+j^2)
    if(dist<=geoRadius){
      cityGrid[i+geoRadius,j+geoRadius] <- 0
    }
  }
}

#Central Industrial Zone
for(i in 501:1000){
  for(j in 501:1000){
    dist <- sqrt((i-750)^2+(j-750)^2)
    if(dist<=250 & cityGrid[i,j] == 0){
      cityGrid[i,j] <- 2
    }
  }
}

#Central Exterior Residential Zone
for(i in 251:1250){
  for(j in 251:1250){
    dist <- sqrt((i-750)^2+(j-750)^2)
    if(dist<=500 & cityGrid[i,j] == 0){
      cityGrid[i,j] <- 1
    }
  }
}

#Random 'Suburb' Residential Zones
for(x in 201:250){
  for(y in 1001:1200){
    if(cityGrid[x,y] == 0){
      cityGrid[x,y]<-1
    }
  }
}

for(x in 701:900){
  for(y in 101:200){
    if(cityGrid[x,y] == 0){
      cityGrid[x,y]<-1
    }
  }
}

for(x in 101:450){
  for(y in 1201:1450){
    if(cityGrid[x,y] == 0){
      cityGrid[x,y]<-1
    }
  }
}

for(x in 1001:1350){
  for(y in 1101:1300){
    if(cityGrid[x,y] == 0){
      cityGrid[x,y]<-1
    }
  }
}

for(x in 201:550){
  for(y in 201:500){
    if(cityGrid[x,y] == 0){
      cityGrid[x,y]<-1
    }
  }
}

image(cityGrid, col = c("black","green","blue", "yellow"))

