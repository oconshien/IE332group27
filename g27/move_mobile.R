#nearest_sensor <- function(destination, sensors, quality, pm_data){
#  mobile_sensors <- sensors[which(sensors[,3]==1),]
#  num_sensors <- dim(mobile_sensors)[1]
#  for(j in 1:length(destination[,1])){
#    dist_vec <- rep(0,num_sensors)
#    for(i in 1:num_sensors){
#      dist_vec[i] <- sqrt((mobile_sensors[i,1]-destination[j,1])^2+(mobile_sensors[i,2]-destination[j,2])^2)
#    }
    #add in piroirty factor for closest drone
    #good vs bad air quality choice
#    keep_loop <- 1
#    k <- 2
#    while(keep_loop){
#      keep_loop <- 1
#      nearest_sensor <- which(dist_vec == dist_vec[rev(order(dist_vec))][k])
      
#      if(pm_data[nearest_sensor, 4] == quality){
#        keep_loop <- 2
#        k <- k+1
#      }else{
#        print(k)
#        near_sensor <- which(mobile_sensors[nearest_sensor,1] == sensors[,1] & mobile_sensors[nearest_sensor,2] == sensors[,2])
#        moved_sensor <- mobile_sensor(dist_vec[nearest_sensor],as.integer(destination[j,]), sensors[near_sensor,])
#      }
        
#      if(keep_loop <- 1){
#        sensors[near_sensor,1] <- moved_sensor[1] + sensors[near_sensor,1]
#        sensors[near_sensor,2] <- moved_sensor[2] + sensors[near_sensor,2]
#      }
#    }
#      keep_loop <- keep_loop - 1
#    }
#  return(sensors)
#}

move_sensor <- function(distance, destination, near_sensor){
  x <- c(destination[1], near_sensor[1])
  y <- c(destination[2], near_sensor[2])
  x <- unlist(x)
  y <- unlist(y)
  dist_line <- lm(y ~ x)
  if(sqrt((x[1]-x[2])^2+(y[1]-y[2])^2)>=1000){
    dest <- 1000
    x_dest <- sqrt(dest^2/(dist_line$coeff[[2]]^2+1))
    y_dest <- dist_line$coeff[[2]] * x_dest
    still_moving <- 1
  }else{
   x_dest <- destination[1]
   y_dest <- destination[2]
   still_moving <- 0
  }
    
  if(sqrt(x_dest^2+y_dest^2) > 15000){
    x_dest <- destination[1]
    y_dest <- destination[2]
  }

  return(c(x_dest,y_dest, still_moving))
}

priority_destinations <- function(sensors, pm_data){
  destination_sensors <- sample(which(pm_data[,4] == 3), trunc(length(which(pm_data[,4]==3))))
  destinations_x <- sensors[destination_sensors, 1]
  destinations_y <- sensors[destination_sensors,2]
  destinations <- data.frame("x_dest" = destinations_x,"y_dest" = destinations_y)
  return(destinations)
}

nearest_sensor_finder <-function(destination, sensors, quality_desired, pm_class){
  #destination: final destination for sensor to move to
  #sensors: data frame of all sensors in the network
  #quality_desired: the type of air quality the client desires to know more about ("good" or "bad")(client-defined)
  #pm_data: the classification of the particulate matter collected by each sensor 
  mobile_sensors <- sensors[which(sensors[,3]==1),]
  num_mobiles <- length(mobile_sensors[,1])
  dist_vec <- vector(length = num_mobiles)
  for(i in 1:num_mobiles){
    dist_vec[i] <- sqrt((destination[1] - mobile_sensors[i,1]) ^ 2 + (destination[2] - mobile_sensors[i,2]) ^ 2)
  }
  dist_vec <- unlist(dist_vec)
  dist_vec[which(dist_vec == 0)] <- 15001
  loop_iterate <- 1
  nth_term <- 1
  while(loop_iterate){
    loop_iterate <- 1
    near_mobile_index <- which(dist_vec == dist_vec[order(dist_vec)][nth_term])
    near_mobile <- mobile_sensors[near_mobile_index,]
    near_index <- which(sensors[,1] == near_mobile[1] & sensors[,2] == near_mobile[2])
    if(near_mobile[4] == 1){
      loop_iterate <- 2
      k <- k + 1
    }
    if(pm_data[near_index, 4] == quality_desired){
      loop_iterate <- 2
      k <- k + 1
    }
    if(loop_iterate == 1){
      print(dist_vec)
      movement <- move_sensor(dist_vec[near_mobile_index], destination, sensors[near_index,])
      movement <- unlist(movement)
      if(movement[3]){
        sensors[near_index,4] <- 1
      }
      sensors[near_index,1] <- movement[1] + sensors[near_index,1]
      sensors[near_index,2] <- movement[2] + sensors[near_index, 2]
      if(!movement[3]){
        sensors[near_index,4] == 0
      }
    }
    loop_iterate <- loop_iterate - 1
  }
  return(sensors)
}
