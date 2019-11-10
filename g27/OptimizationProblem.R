#-----------------------------------------------------------------------------------------------------------------------
# FUNCTIONS

create_random <- function(sensors, geoRadius=15000){
  #sensors: vector of length two that indicates number of fixed sensors [1], and number of mobile sensors [2]
  #geoRadius: radius of area to be tracked, as indicated by client
  sensor_sol <- matrix(data = rep(0,2 * sum(sensors)), nrow = sum(sensors), ncol = 2)
  i = 0
  #sensor_sol is a matrix of the centers of radius of the sensors, and the type of sensors (1=fixed,0=mobile)
  while (i < sum(sensors)){
    i = i + 1
    sensor_sol[i,1] <- runif(1,-geoRadius,geoRadius)
    sensor_sol[i,2] <- runif(1,-geoRadius,geoRadius)
    if (sqrt(sensor_sol[i,1]^2+sensor_sol[i,2]^2) > geoRadius)
      i = i-1
  }# This while loop creates a random uniform distribution of 2 columns x and y
  ## The rows correspond with the number of sensors
  ## The x,y coordinate creates the location of the center of radius of the sensors range
  sensor_type <- c(rep(0,sensors[2]),rep(1,sensors[1]))
  for (n in 1:sum(sensors)){
    random <- replicate(2,sample(1:sum(sensors),1))
    hold <- sensor_type[random[1]]
    sensor_type[random[1]] <- sensor_type[random[2]]
    sensor_type[random[2]] <- hold
  }## The sensor type is rearranged and created correspond with the (x,y) coordinate that names the sensor's location
  sensor_sol <- cbind(sensor_sol,sensor_type)#This binds it all together to make a matrix that is (number of sensors)X3
}

budget_constraint<-function(budget,repair_cost = 0,opt_repair = 0,risk = 0.01,alpha = 0.05){
  #Warning Messages
  # make sure not null
  if ( any(c(is.null(budget),is.null(repair_cost),is.null(opt_repair),is.null(risk),is.null(alpha))))
    stop("ERROR: At least one input is null.")
  
  # make sure no NAs
  if ( all(c(any(is.na(budget)),any(is.na(repair_cost)),any(is.na(opt_repair),any(is.na(risk)),any(is.na(alpha))))))
    stop("ERROR: At least one NA value found.")
  
  # make sure all are numeric
  if ( !all(c(is.numeric(budget),is.numeric(repair_cost),is.numeric(opt_repair),is.numeric(risk),is.numeric(alpha))) )
    stop("ERROR: Not all inputs are numeric.")
  
  #make sure budget is bigger than 0
  if(budget < 4000)
    stop("ERROR: Budget is not bigger than $4,000")
  
  #make sure opt_repair is binary
  if(opt_repair != 1 && opt_repair != 0)
    stop("ERROR: opt_repairt is not binary.")
  
  #make sure alpha and risk are a probability
  if(risk > 1 || alpha > 1)
    stop("ERROR: risk and alpha are not a probability")
  
  #This program uses the lpsolve function
  #objective function
  #maximize value{x1:mobile sensors, x2:fixed sensors}
  #max z = 7x1 + x2
  f.obj<-c(7,1)
  #subject to:
  #Budget
  #3500x1 + 500x2 <= budget-repair_cost*opt_repair
  #Preliminary Risk
  EV1= 4*risk
  EV2 = risk
  #Constrainst are inputed as matrices
  f.con<-matrix(c(3500,500,EV1,EV2),nrow=2,byrow=TRUE)
  f.rhs<-c(budget-repair_cost*opt_repair,10000)
  f.dir<-c("<=","<=")
  #the lpsolve function takes the linear program and finds the optimal solution 
  #based on the constraints
  solution = lp("max", f.obj, f.con, f.dir, f.rhs,int.vec=1:2)$solution
  
  #After the first run, the risk will be taken into account and the number of mobile and fixed sensors will be
  #adjusted based on the alpha. Solution[1] = mobile, solution[2] = fixed
  fails = dbinom(as.integer((solution[1]+solution[2])*alpha), size = solution[1], prob = 4*risk)
  
  #At low budgets and really high budgets, the risk factor cannot be taken into consideration.
  if(fails >= 0.5){
    solution
    stop
  }
  else{
    while(fails > alpha){
      solution[1] = solution[1] - 1
      solution[2] = solution[2] + 1
      fails = dbinom(as.integer((solution[1]+solution[2])*alpha), size = solution[1], prob = 4*risk)
    }
  }
  return(solution)
}

# Calculate the objective value of a valid candidate solution.
mapPoints <- function(centers, r=50, geoRadius = 15000){
  #Function takes in centers of various 
  area <- pi*(r^2)*length(centers[,1])
  spaceReduct <- 0
  distFactor <- 0
  for (i in 1:(length(centers[,1]))){
    j=i+1
    while(j<=length(centers[,1])){
      dist <- sqrt((centers[i,1]-centers[j,1])^2+(centers[i,2]-centers[j,2])^2)
      if( dist < (r*2)){
        spaceReduct <- spaceReduct + 2*r^2*acos(dist/(2*r))-dist/2*sqrt(r^2-(dist/2)^2)
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
    }
  }
  edgeReduct <- edgeReduct / area
  spaceReduct <- spaceReduct / area
  reduct_avg <- (edgeReduct + spaceReduct) / 2
  region_factor <- 0
  city_grid_radius <- geoRadius/20
  for (i in 1:(length(centers[,1]))){
    if(cityGrid[trunc(centers[i,1]/20) + city_grid_radius, trunc(centers[i,2]/20) + city_grid_radius] == 2 & centers[i,3] == 0)
      region_factor <- region_factor + reduct_avg/2
    if(cityGrid[trunc(centers[i,1]/20) + city_grid_radius, trunc(centers[i,2]/20) + city_grid_radius] == 1 & centers[i,3] == 1)
      region_factor <- region_factor + reduct_avg/2 
  }
  return(1 - spaceReduct - edgeReduct + region_factor)
}

#Initial solution(IS),  Temperature, maximum iteration #, cooling schedule
SA <- function(budget, geoRadius=15000, r=50, temperature=3000, maxit=500, cooling=0.95, just_values=TRUE) {
  # core_number: number of cores available
  # task_data: data.frame of task processing time
  # temperature: initial temperature
  # maxit: maximum number of iterations to execute for
  # cooling: rate of cooling
  # just_values: only return a list of best objective value at each iteration
  require(lpSolve)
  set.seed(12)
  numSensors <- budget_constraint(budget)
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
