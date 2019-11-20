random_collect <- function(x, storm_time){
  #x: randomized number from regression to be "collected" by sensor.
  require(truncnorm)
  error_rate <- 0.01
  std_dev <- sqrt(abs(x))
  if(storm_time){
    error_rate <- 0.1
    std_dev <- 2 * sqrt(abs(x))
  }
  
  #Chances of erroneous reading by sensor is 1%.
  if (!sample(c(0,1), 1, prob = c(1-error_rate,error_rate))) #Normal reading result.
    return(rtruncnorm(1, a = 0, mean = x, sd = std_dev)) #how to handle sd, can we calc it from the data?
  else{ #Erroneous reading result.
    #Randomizes if the erroneous reading is unusually high or low.
    if(sample(c(0,1), 1))
      return(rtruncnorm(1, a = x * 1.95, mean = x, sd = std_dev))
    else
      return(rtruncnorm(1, a = 0, b = x * 0.05, mean = x, sd = std_dev))
  }
}