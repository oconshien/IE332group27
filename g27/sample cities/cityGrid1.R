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

#Top left residential
for(x in 1:500){
  for(y in 1001:1500){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Top right residential
for(x in 1001:1500){
  for(y in 1001:1500){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Bottom left residential
for(x in 1:500){
  for(y in 1:500){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Bottom right residential
for(x in 1001:1500){
  for(y in 1:500){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Center industrial
for(x in 501:1000){
  for(y in 501:1000){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-2
    }
  }
}

image(cityGrid, col = c("black","green","blue", "yellow"))

