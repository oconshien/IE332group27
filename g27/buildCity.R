buildCity <- function(input){
  geoRadius <- 15000/20
    cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt(i^2+j^2)
        if(dist<=geoRadius){
          cityGrid[i+geoRadius,j+geoRadius] <- input[i, j]
        }
      }
    }
    
  return(cityGrid)
}