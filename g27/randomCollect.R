random_collect <- function(x){
  #x: randomized number from regression to be "collected" by sensor.
  require(truncnorm)
  
  #Chances of erroneous reading by sensor is 1%.
  if (!sample(c(0,1), 1, prob = c(0.99,0.01))) #Normal reading result.
    return(rtruncnorm(1, a = 0, mean = x, sd = 1)) #how to handle sd, can we calc it from the data?
  
  else{ #Erroneous reading result.
    #Randomizes if the erroneous reading is unusually high or low.
    if(sample(c(0,1), 1))
      return(rtruncnorm(1, a = x * 1.95, mean = x, sd = 1))
    else
      return(rtruncnorm(1, a = 0, b = x * 0.05, mean = x, sd = 1))
  }
}