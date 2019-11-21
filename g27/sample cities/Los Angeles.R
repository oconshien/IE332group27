#LA City
cityGrid<-matrix(1,nrow=1500,ncol=1500)
cityGrid[1,1]<--1
#Top Rural Park Circle
for(i in 650:850){
  for(j in 1300:1500){
    dist <- sqrt((i-750)^2+(j-1250)^2)
    if(dist<=500){
      cityGrid[i,j] <- 0
    }
  }
}
#Right Rural Parks
for(x in 1250:1500){
  for(y in 1300:1500){
    cityGrid[x,y]<-0
  }
}


#Center Industrial
for(x in 500:1000){
  for(y in 500:1000){
      cityGrid[x,y]<-2
  }
}

#Right Industrial
for(x in 750:950){
  for(y in 100:250){
      cityGrid[x,y]<-2
  }
}
#Smaller left industrial
for(x in 350:1050){
  for(y in 750:1100){
    cityGrid[x,y]<-2
  }
}
#Right Bottom Industrial
  for(x in 950:1500){
    for(y in 50:150){
        cityGrid[x,y]<-2
    }
}


image(cityGrid, col = c("black","green","blue", "yellow"))
