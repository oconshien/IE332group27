#Mexico City
cityGrid<-matrix(1,nrow=1500,ncol=1500)
cityGrid[1,1]<--1

#Left Rural Park
for(x in 0:300){
  for(y in 650:1100){
    cityGrid[x,y]<-0
  }
}
#Right Rural Park
for(x in 1300:1500){
  for(y in 1250:1400){
    cityGrid[x,y]<-0
  }
}

#Left Top Industrial
for(x in 150:500){
  for(y in 1150:1500){
    cityGrid[x,y]<-2
  }
}
#Right Corner Industrial
for(x in 1300:1500){
  for(y in 0:450){
    cityGrid[x,y]<-2
  }
}

image(cityGrid, col = c("black","green","blue", "yellow"))