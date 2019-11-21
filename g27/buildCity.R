buildCity <- function(city){
  geoRadius <- 15000 / 20
    for(i in 1:(2 * geoRadius)){
      for(j in 1:(2 * geoRadius)){
        dist <- sqrt((i - 750) ^ 2 + (j - 750) ^ 2)
        if(dist > geoRadius){
          city[i, j] <- -1
        }
      }
    }
    
  return(as.matrix(city))
}