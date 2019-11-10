nearest_sensor <- function(destination, sensors, quality){
  mobile_sensors <- sensors[which(sensors[,3]==1),]
  num_sensors <- dim(mobile_sensors)[1]
  for(j in 1:length(destination[,1])){
    dist_vec <- rep(0,num_sensors)
    for(i in 1:num_sensors){
      dist_vec[i] <- sqrt((mobile_sensors[i,1]-destination[j,1])^2+(mobile_sensors[i,2]-destination[j,2])^2)
    }
    #add in piroirty factor for closest drone
    #good vs bad air quality choice
    nearest_sensor <- which(dist_vec == min(dist_vec[dist_vec!=min(dist_vec)]))
    near_sensor <- which(mobile_sensors[nearest_sensor,1] == sensors[,1] & mobile_sensors[nearest_sensor,2] == sensors[,2])
    moved_sensor <- mobile_sensor(dist_vec[nearest_sensor],destination[j,], sensors[near_sensor,])
    sensors[near_sensor,1] <- moved_sensor[1] + sensors[near_sensor,1]
    sensors[near_sensor,2] <- moved_sensor[2] + sensors[near_sensor,2]
  }
  return(sensors)
}

mobile_sensor <- function(distance, destination, near_sensor){
  x <- c(destination[1], near_sensor[1])
  y <- c(destination[2], near_sensor[2])
  dist_line <- lm(y ~ x)
  
  if (distance > 1000){
    dest <- 1000
    x_dest <- sqrt(dest^2/(dist_line$coeff[[2]]^2+1))
    y_dest <- dist_line$coeff[[2]] * x_dest
  } else{
    dest <- distance
    x_dest <- destination[1]
    y_dest <- destination[2]
    #set equal to destination
  }

  return(c(x_dest,y_dest))
}

priority_destinations <- function(sensors, pm_data){
  destination_sensors <- sample(which(pm_data[,4] == 3), trunc(0.1 * length(pm_data[,4]==3)))
  destinations_x <- sensors[destination_sensors, 1]
  destinations_y <- sensors[destination_sensors,2]
  destinations <- data.frame("x_dest" = destinations_x,"y_dest" = destinations_y)
  return(destinations)
}


#add 'destination' finder function (take destinations from sensors)