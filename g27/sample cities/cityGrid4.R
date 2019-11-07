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
for(x in 150:500){
  for(y in 900:1300){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Top right residential
for(x in 950:1300){
  for(y in 470:1300){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Bottom left residential
for(x in 150:500){
  for(y in 100:900){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Bottom right residential
for(x in 950:1300){
  for(y in 100:470){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-1
    }
  }
}

#Center industrial
for(x in 550:900){
  for(y in 1:1500){
    if(cityGrid[x,y] != -1){
      cityGrid[x,y]<-2
    }
  }
}

image(cityGrid, col = c("black","green","blue", "yellow"))
