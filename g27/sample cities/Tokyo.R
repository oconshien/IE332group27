#Tokyo
cityGrid<-matrix(1,nrow=1500,ncol=1500)
cityGrid[1,1]<--1

#Right Bottom Park Area
for(x in 750:1500){
  for(y in 0:600){
    cityGrid[x,y]<-0
  }
}

#Middle Downtown Area Industrial
for(x in 600:900){
  for(y in 500:850){
    cityGrid[x,y]<-2
  }
}

#Heavy Industrial Corridor
for(x in 750:800){
  for(y in 0:600){
    cityGrid[x,y]<-2
  }
}

#Middle Park Area Rural Park
for(x in 500:600){
  for(y in 750:900){
    cityGrid[x,y]<-0
  }
}

#Left Middle Heavy Urban and Industrial Area
for(x in 50:100){
  for(y in 850:950){
    cityGrid[x,y]<-2
  }
}

#Left Top Heavy Urban and Industrial Area
for(x in 150:225){
  for(y in 1300:1400){
    cityGrid[x,y]<-2
  }
}

#Bottom Industrial Park
for(x in 600:850){
  for(y in 0:200){
    cityGrid[x,y]<-2
  }
}


#Left Middle Heavy Urban Area
for(x in 1000:1200){
  for(y in 1230:1350){
    cityGrid[x,y]<-2
  }
}

#Top Right River Park Area
for(x in 1350:1500){
  for(y in 1400:1500){
    cityGrid[x,y]<-2
  }
}
#Park Near Downtown Area
for(x in 400:450){
  for(y in 400:450){
    cityGrid[x,y]<-2
  }
}
image(cityGrid, col = c("black","green","blue", "yellow"))



