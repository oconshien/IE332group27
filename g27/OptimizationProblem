#-----------------------------------------------------------------------------------------------------------------------
# FUNCTIONS



# Calculate the objective value of a valid candidate solution.
calculate_objVal <- function(centerVec, numSensors, M) { 
for(n in seq(1,length(centerVec), by = 2)){
  xPt <- centerVec[n]
  yPt <-centerVec[n+1]
  M <- mapPoint(c(xPt,yPt),M)
}
  return(-sum(M))
}

mapPoint <- function(center, M){
  g = expand.grid(1:nrow(M),1:ncol(M))
  g$d2 = sqrt((g$Var1-center[1])^2+ (g$Var2-center[2])^2)
  g$inside = g$d2 <= 50
  which(g$inside)
  xVec = g$Var1[which(g$inside)]
  yVec = g$Var2[which(g$inside)]
  for(j in 1:length(xVec)){
    M[xVec[j],yVec[j]] <- 1
  }
  M 
}

# Create a valid candidate solution within the neighborhood of x by randomly swaping tasks between two different cores.
neighbor <- function(x) {
  # x is current solution
  
  for(n in 1:sample(1:length(x),1)){  #Swapping function. Swaps two indexes next to each other a random number of times.
    random <- replicate(2,sample(1:length(x),1))
    hold <- x[random[1]]
    x[random[1]] <- x[random[2]]
    x[random[2]] <- hold
  }
  return(x) #New Solution
}

#Simulated Annealing. DO NOT EDIT THIS FUNCTION.
#Initial solution(IS),  Temperature, maximum iteration #, cooling schedule
SA <- function(core_number, task_data, temperature=3000, maxit=10, cooling=0.95, just_values=TRUE) {
  # core_number: number of cores available
  # task_data: data.frame of task processing time
  # temperature: initial temperature
  # maxit: maximum number of iterations to execute for
  # cooling: rate of cooling
  # just_values: only return a list of best objective value at each iteration
  
  s_sol <- create_initial(sensorNum,geoDataLength) # generate a valid initial solution
  M <- matrix(rep(0,geoDataLength^2),geoDataLength, geoDataLength)
  s_obj <- calculate_objVal(s_sol,numSensors, M)     # evaluate initial solution
  best  <- s_sol                                              # track the best solution found so far
  best_obj <- s_obj                                           # track the best objective value found so far
  
  # to keep best objective values through the algorithm
  obj_vals <- best_obj
  cnt <- 0
  
  # run Simulated Annealing
  for(i in 1:maxit) {
    neigh <- neighbor(c_sol)                                      # generate a neighbor solution
    neigh_obj <- calculate_objVal(neigh,core_number, task_data)   # calculate the objective value of the new solution
    if ( neigh_obj <= best_obj ) {                                # keep neigh if it is the new global best solution
      c_sol <- neigh
      c_obj <- neigh_obj
      best <- neigh
      best_obj <- neigh_obj
    } else if ( runif(1) <= exp(-(neigh_obj-c_obj)/temperature) ) {    # otherwise, probabilistically accept 
      c_sol <- neigh
      c_obj <- neigh_obj
      cnt <- cnt +1
    }
    temperature <- temperature * cooling                          # update cooling
    obj_vals <- c(obj_vals, best_obj)                             # maintain list of best found so far
  }
  
  ifelse(just_values, return(obj_vals), return(list(best=best, best_obj=best_obj, values=obj_vals)))
}

#-----------------------------------------------------------------------------------------------------------------------
# MAIN CODE


cores <- 4
trials <- 5
tasks <- read.csv('Q3.csv', header=TRUE, sep = ';')

results <- matrix(replicate(trials, SA(cores, tasks)), nrow = 1001, ncol= trials) #Trial formulation.

# MISSING CODE. Complete the lines, no additional lines of code!
trial_best_objs <- tail(results,1)
best_trial <- which(trial_best_objs == min(trial_best_objs))
trial_best_objs <- trial_best_objs[,c(best_trial,which(1:5 != best_trial))]
results <- results[,c(best_trial,which(1:5 != best_trial))]
overall_best <- best_trial
median_obj <- median(trial_best_objs)
max_obj <- max(trial_best_objs)

#Create plot of trials.
plot(1:1001, results[,2], type = "b", col = "grey", ylim = c(min(results),max(results)), xlab = "Iteration Number", ylab = "Objective Value", lty = "dashed", cex =0.8)
points(1:1001, results[,3], type = "b", col = "grey", lty = "dashed", cex = 0.8)
points(1:1001, results[,4], type = "b", col = "grey", lty = "dashed", cex = 0.8)
points(1:1001, results[,5], type = "b", col = "grey", lty = "dashed", cex = 0.8)
points(1:1001, results[,1], type = "l", col = "red", lwd = 2)
title(paste("median=", median_obj," min=", results[length(results[,1]),1], " max=", max_obj))
legend("topright", legend = c("Best Result", "Other Results"), cex = 0.7, fill = c("red", "grey"))
