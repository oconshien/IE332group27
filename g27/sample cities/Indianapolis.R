geoRadius <- 15000/20
cityGrid <- matrix(nrow = geoRadius * 2, ncol = geoRadius * 2)
for(i in -geoRadius:geoRadius){
  for(j in -geoRadius:geoRadius){
    cityGrid[i+geoRadius,j+geoRadius] <- 1
  }
}

#Indianapolis City Center
for(x in 750:900){
  for(y in 600:820){
      cityGrid[x,y] <- 2
  }
}

#Rural Bottom Left
for(x in 0:540){
  for(y in 0:480){
    cityGrid[x,y] <- 0
  }
}

#Rural Top Left
for(x in 0:300){
  for(y in 1250:1500){
    cityGrid[x,y] <- 0
  }
}

#Rural Top Right
for(x in 1300:1500){
  for(y in 1250:1500){
    cityGrid[x,y] <- 0
  }
}

#Rural Bottom Right
for(x in 1340:1500){
  for(y in 0:260){
    cityGrid[x,y] <- 0
  }
}

#image(cityGrid, col = c("blue", "yellow"))
