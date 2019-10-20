#-----------------------------------------------------------------------------------------------------------------------
# FUNCTIONS

create_random <- function(sensors, geoRadius=15000){
  #sensors: vector of length two that indicates number of fixed sensors [1], and number of mobile sensors [2]
  #geoRadius: radius of area to be tracked, as indicated by client
  sensor_sol <- matrix(data = rep(0,2 * sum(sensors)), nrow = sum(sensors), ncol = 2)
  i = 0
  #sensor_sol is a matrix of the centers of radius of the sensors, and the type of sensors (0=fixed,1=mobile)
  while (i < sum(sensors)){
    i = i + 1
    sensor_sol[i,1] <- runif(1,-geoRadius,geoRadius)
    sensor_sol[i,2] <- runif(1,-geoRadius,geoRadius)
    if (sqrt(sensor_sol[i,1]^2+sensor_sol[i,2]^2) > geoRadius)
      i = i-1
  }# This while loop creates a random uniform distribution of 2 columns x and y
  ## The rows correspond with the number of sensors
  ## The x,y coordinate creates the location of the center of radius of the sensors range
  sensor_type <- c(rep(0,sensors[1]),rep(1,sensors[2]))
  for (n in (sum(sensors)/2):sample((sum(sensors)/2):sum(sensors),1)){
    random <- replicate(2,sample(1:sum(sensors),1))
    hold <- sensor_type[random[1]]
    sensor_type[random[1]] <- sensor_type[random[2]]
    sensor_type[random[2]] <- hold
  }## The sensor type is rearranged and created correspond with the (x,y) coordinate that names the sensor's location
  sensor_sol <- cbind(sensor_sol,sensor_type)#This binds it all together to make a matrix that is (number of sensors)X3
}

# Calculate the objective value of a valid candidate solution.
mapPoints <- function(centers, r=50, geoRadius = 15000){
  #Function takes in centers of various 
  area <- pi*(r^2)*length(centers[,1])
  spaceReduct <- 0
  for (i in 1:(length(centers[,1]))){
    j=i+1
    while(j<=length(centers[,1])){
      if(sqrt((centers[i,1]-centers[j,1])^2+(centers[i,2]-centers[j,2])^2) < (r*2)){
        d <- sqrt((centers[i,1]-centers[j,1])^2+(centers[i,2]-centers[j,2])^2)
        spaceReduct <- spaceReduct + 2*r^2*acos(d/(2*r))-d/2*sqrt(r^2-(d/2)^2)
        #print(spaceReduct)
      }
      j = j+1
    } 
  }
  edgeReduct <- 0
  for (i in 1:(length(centers[,1]))){
    distance <- sqrt((centers[i,1])^2+(centers[i,2])^2)
    if(distance>geoRadius-r){
      d1 <- (geoRadius^2-r^2 + distance^2)/(2*distance)
      d2 <- distance - d1
      edgeReduct <- edgeReduct + pi * r^2 - geoRadius^2*acos(d1/geoRadius) + d1 * sqrt(geoRadius^2-d1^2) - r^2 * acos(d2/r) + d2 * sqrt(r^2-d2^2)
      #print(edgeReduct)
    }
  }
  return(area - spaceReduct - edgeReduct)
}

#Simulated Annealing. DO NOT EDIT THIS FUNCTION.
#Initial solution(IS),  Temperature, maximum iteration #, cooling schedule
SA <- function(numSensors, geoRadius=15000, r=50, temperature=3000, maxit=100, cooling=0.95, just_values=TRUE) {
  # core_number: number of cores available
  # task_data: data.frame of task processing time
  # temperature: initial temperature
  # maxit: maximum number of iterations to execute for
  # cooling: rate of cooling
  # just_values: only return a list of best objective value at each iteration
  
  s_sol <- create_random(numSensors,geoRadius) # generate a valid initial solution
  s_obj <- mapPoints(s_sol,r, geoRadius)     # evaluate initial solution
  best  <- s_sol                                             # track the best solution found so far
  best_obj <- s_obj                                           # track the best objective value found so far
  
  # to keep best objective values through the algorithm
  obj_vals <- best_obj
  cnt <- 0
  
  # run Simulated Annealing
  for(i in 1:maxit) {
    neigh <- create_random(numSensors,geoRadius)              # generate a neighbor solution
    neigh_obj <- mapPoints(neigh, r, geoRadius)   # calculate the objective value of the new solution
    if ( neigh_obj >= best_obj ) {                                # keep neigh if it is the new global best solution
      s_sol <- neigh
      s_obj <- neigh_obj
      best <- neigh
      best_obj <- neigh_obj
    } else if ( runif(1) <= exp((neigh_obj-s_obj)/temperature) ) {    # otherwise, probabilistically accept 
      s_sol <- neigh
      s_obj <- neigh_obj
      cnt <- cnt +1
    }
    temperature <- temperature * cooling                          # update cooling
    obj_vals <- c(obj_vals, best_obj)                             # maintain list of best found so far
  }
  library(berryFunctions)
  plot(best[,1],best[,2], xlim = c(-geoRadius,geoRadius), ylim = c(-geoRadius,geoRadius), pch = 20, xlab = "X", ylab = "Y")
  points(best[,1][which(best[,3]==1)],best[,2][which(best[,3]==1)], col = "green",pch = 20)
  legend("topleft", legend = c("Fixed", "Mobile"), col = c("Black","Green"), pch = c(20,20), cex = 0.5)
  title("Default Sensor Locations")
  circle(0,0,geoRadius)
  ifelse(just_values, return(obj_vals), return(list(best=best, best_obj=best_obj, values=obj_vals)))
}
