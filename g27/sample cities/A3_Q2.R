require(ReinforcementLearning)
gridLearn <- function(matN){
  states <- matrix(nrow = matN, ncol = matN)
  n <- 0
  for(i in 1:matN){
    for(j in 1:matN){
      n <- n+1;
      states[i,j] <- paste("s",n, sep = "")
    }
  }
  actions <- c("up", "down", "left", "right", "north east", "north west", "south east", "south west")
  env <- gridworldEnvironment(states,actions)
  state <- 1
  while(current_state != matN^2){
    if(current_state)
  }
}
env<-function(state, action) 
 {
  ##ADD IN DIAGONAL(e.g. NORTH WEST) DIRECTIONS
     next_state <- state
     rowN <- which(state == states, arr.ind = TRUE)[1]
     colN <- which(state == states, arr.ind = TRUE)[2]
     if (action == "down") 
         next_state <- states[rowN+1,colN]
     if (action == "up") 
         next_state <- states[rowN-1,colN]
     if (action == "right") 
         next_state <- states[rowN,colN+1]
     if (action == "left") 
         next_state <- states[rowN,colN-1]
     if (any(sapply(states[1,],function(x){state == state(x)})) && action == "up") 
         reward <- -1
     if (any(sapply(states[dim(states)[1],],function(x){state == state(x)})) && action == "down") 
       reward <- -1
     if (any(sapply(states[,1],function(x){state == state(x)})) && action == "left") 
       reward <- -1
     if (any(sapply(states[,dim(states[2])],function(x){state == state(x)})) && action == "right") 
       reward <- -1
     if (next_state == states[matN,matN] && state != states[matN,matN] {
         reward <- 10
     }
     else {
         reward <- -1
     }
     out <- list(NextState = next_state, Reward = reward)
     return(out)
}