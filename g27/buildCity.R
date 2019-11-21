buildCity <- function(city){
  geoRadius <- 15000/20
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt((i - 750) ^ 2 + (j - 750) ^ 2)
        if(dist>geoRadius){
          city[i,j] <- -1
        }
      }
    }
    
  return(cityGrid)
}