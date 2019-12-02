calc_obj <- function(centers, city_grid, r = 50, geo_radius = 15000){
  #centers: data_frame, the locations of the sensors in the network.
  #city_grid: matrix, the zoning values of the inputted city.
  #r: real, the detection radius of the sensors.
  #geo_radius: int(divisible by 20), the radius to be covered as designated by the client.
  
  #Intialization of obj values.
  area <- pi * (r ^ 2) * length(centers[, 1])
  space_reduct <- 0
  edge_reduct <- 0
  region_factor <- 0
  mobile_factor <- 0
  
  #Reduce obj value based on overlapping sensors.
  for (i in 1:(length(centers[, 1]))){
    j <- i + 1
    while(j <= length(centers[, 1])){
      dist <- sqrt((centers[i, 1] - centers[j, 1]) ^ 2 + (centers[i, 2] - centers[j, 2]) ^ 2)
      if(dist < (r * 2)){
        space_reduct <- space_reduct + 2 * r ^ 2 * acos(dist / (2 * r)) - dist / 2 * sqrt(r ^ 2 - (dist / 2) ^ 2)
      }
      j <- j + 1
    } 
  }
  
  #Reduce obj value based on sensors close to edge of geographic radius.
  for (i in 1:(length(centers[, 1]))){
    distance <- sqrt((centers[i, 1]) ^ 2 + (centers[i, 2]) ^ 2)
    if(distance > geo_radius - r){
      d1 <- (geo_radius ^ 2 - r ^ 2 + distance ^ 2) / (2 * distance)
      d2 <- distance - d1
      edge_reduct <- edge_reduct + pi * r ^ 2 - geo_radius ^ 2 * acos(d1 / geo_radius) + d1 * sqrt(geo_radius ^ 2 - d1 ^ 2) - r ^ 2 * acos(d2 / r) + d2 * sqrt(r ^ 2 - d2 ^ 2)
    }
  }
  
  #Normalize the reduction numbers.
  edge_reduct <- edge_reduct / area
  space_reduct <- space_reduct / area
  #reduct_avg <- (edge_reduct + space_reduct)
  
  #City indexing.
  city_grid_radius <- geo_radius / 20
  
  #Account for region sensors are in and mobile placement for obj value.
  for (i in 1:(length(centers[, 1]))){
    #Fixed sensors better in urban/industrial.
    if(city_grid[trunc(centers[i, 1] / 20) + city_grid_radius, trunc(centers[i, 2] / 20) + city_grid_radius] == 2 & centers[i, 3] == 0)
      region_factor <- region_factor + 1 / length(centers[,1])
    #Mobile sensors better in residential.
    if(city_grid[trunc(centers[i, 1] / 20) + city_grid_radius, trunc(centers[i, 2] / 20) + city_grid_radius] == 1 & centers[i, 3] == 1)
      region_factor <- region_factor + 1 / length(centers[,1]) 
    #Mobile sensors better towards the center.
    if(centers[i, 3] == 1){
      mobile_factor <- mobile_factor + (-sqrt(centers[i, 1] ^ 2 + centers[i, 2] ^ 2) + geo_radius) * 1 / (geo_radius * length(centers[, 3]))
    }
  }
  print(space_reduct)
  print(edge_reduct)
  print(region_factor)
  print(mobile_factor)
  print("next")
  
  obj_value <- -space_reduct - edge_reduct + region_factor + mobile_factor
  
  return(obj_value)
  #obj_value: int, a value representing the relative value of the current network.
}