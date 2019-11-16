##Packages required
require(dplyr) #data wrangling
require(lubridate) #date/time
require(knitr) #quite fond of the kable function for making tables.
require(ggplot2) #plotting
require(ggthemes) #plotting
require(gridExtra) #extra space for plots
require(data.table) #data manipulation 
require(RColorBrewer) #plotting
require(stringr) #more data wrangling
require(ggridges) #plotting density ridges
require(readr)  #input/output
require(tibble) #as_tibble, easy to use
require(plyr)
require(caret)  #create data partition
require(e1071)  #naiveBayes
require(truncnorm)
require(lpSolve)

##--USER INPUTS--##
 #What are they??

##--City Options--##
buildCity <- function(num){
  if(num == 1){
    geoRadius <- 15000/20
    cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt(i^2+j^2)
        if(dist<=geoRadius){
          cityGrid[i+geoRadius,j+geoRadius] <- 0
        }
      }
    }
    
    #Top left residential
    for(x in 1:500){
      for(y in 1001:1500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Top right residential
    for(x in 1001:1500){
      for(y in 1001:1500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom left residential
    for(x in 1:500){
      for(y in 1:500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom right residential
    for(x in 1001:1500){
      for(y in 1:500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Center industrial
    for(x in 501:1000){
      for(y in 501:1000){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-2
        }
      }
    }
  }else if(num==2){
    geoRadius <- 15000/20
    cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt(i^2+j^2)
        if(dist<=geoRadius){
          cityGrid[i+geoRadius,j+geoRadius] <- 0
        }
      }
    }
    
    #Central Industrial Zone
    for(i in 501:1000){
      for(j in 501:1000){
        dist <- sqrt((i-750)^2+(j-750)^2)
        if(dist<=250 & cityGrid[i,j] == 0){
          cityGrid[i,j] <- 2
        }
      }
    }
    
    #Central Exterior Residential Zone
    for(i in 251:1250){
      for(j in 251:1250){
        dist <- sqrt((i-750)^2+(j-750)^2)
        if(dist<=500 & cityGrid[i,j] == 0){
          cityGrid[i,j] <- 1
        }
      }
    }
    
    #Random 'Suburb' Residential Zones
    for(x in 201:250){
      for(y in 1001:1200){
        if(cityGrid[x,y] == 0){
          cityGrid[x,y]<-1
        }
      }
    }
    
    for(x in 701:900){
      for(y in 101:200){
        if(cityGrid[x,y] == 0){
          cityGrid[x,y]<-1
        }
      }
    }
    
    for(x in 101:450){
      for(y in 1201:1450){
        if(cityGrid[x,y] == 0){
          cityGrid[x,y]<-1
        }
      }
    }
    
    for(x in 1001:1350){
      for(y in 1101:1300){
        if(cityGrid[x,y] == 0){
          cityGrid[x,y]<-1
        }
      }
    }
    
    for(x in 201:550){
      for(y in 201:500){
        if(cityGrid[x,y] == 0){
          cityGrid[x,y]<-1
        }
      }
    }
    
  }else if(num==3){
    geoRadius <- 15000/20
    cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt(i^2+j^2)
        if(dist<=geoRadius){
          cityGrid[i+geoRadius,j+geoRadius] <- 0
        }
      }
    }
    
    #Top left residential
    for(x in 250:550){
      for(y in 900:1500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Top right residential
    for(x in 825:1250){
      for(y in 900:1500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom left residential
    for(x in 100:400){
      for(y in 1:500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom right residential
    for(x in 1:1500){
      for(y in 1:500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Center industrial
    for(x in 300:1200){
      for(y in 550:900){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-2
        }
      }
    }
    
  }else{
    geoRadius <- 15000/20
    cityGrid <- matrix(rep(-1,(2*geoRadius)^2), 2*geoRadius, 2*geoRadius)
    for(i in -geoRadius:geoRadius){
      for(j in -geoRadius:geoRadius){
        dist <- sqrt(i^2+j^2)
        if(dist<=geoRadius){
          cityGrid[i+geoRadius,j+geoRadius] <- 0
        }
      }
    }
    
    #Top left residential
    for(x in 150:500){
      for(y in 900:1300){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Top right residential
    for(x in 950:1300){
      for(y in 470:1300){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom left residential
    for(x in 150:500){
      for(y in 100:900){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Bottom right residential
    for(x in 950:1300){
      for(y in 100:470){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-1
        }
      }
    }
    
    #Center industrial
    for(x in 550:900){
      for(y in 1:1500){
        if(cityGrid[x,y] != -1){
          cityGrid[x,y]<-2
        }
      }
    }
  }
  #image(cityGrid, col = c("black","green","blue", "yellow")) 
  return(cityGrid)
}


##--Generate Initial Sensor Placements--##

#Random placement generator
create_random <- function(sensors, geoRadius=15000){
  #sensors: vector of length two that indicates number of fixed sensors [1], and number of mobile sensors [2]
  #geoRadius: radius of area to be tracked, as indicated by client
  sensor_sol <- matrix(data = rep(0,2 * sum(sensors)), nrow = sum(sensors), ncol = 2)
  i = 0
  #sensor_sol is a matrix of the centers of radius of the sensors, and the type of sensors (1=fixed,0=mobile)
  while (i < sum(sensors)){
    i = i + 1
    sensor_sol[i,1] <- trunc(runif(1,-geoRadius,geoRadius))
    sensor_sol[i,2] <- trunc(runif(1,-geoRadius,geoRadius))
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

#Allocation of sensors given client budget
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

# Calculate the objective value of a valid candidate solution
mapPoints <- function(centers, cityGrid, r=50, geoRadius = 15000){
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

#Simulated Annealing
SA <- function(budget, cityGrid, geoRadius=15000, r=50, temperature=3000, maxit=500, cooling=0.95, just_values=TRUE) {
  # core_number: number of cores available
  # task_data: data.frame of task processing time
  # temperature: initial temperature
  # maxit: maximum number of iterations to execute for
  # cooling: rate of cooling
  # just_values: only return a list of best objective value at each iteration
  numSensors <- budget_constraint(budget)
  s_sol <- create_random(numSensors,geoRadius) # generate a valid initial solution
  s_obj <- mapPoints(s_sol,cityGrid, r, geoRadius)     # evaluate initial solution
  best  <- s_sol                                             # track the best solution found so far
  best_obj <- s_obj                                           # track the best objective value found so far
  
  # to keep best objective values through the algorithm
  obj_vals <- best_obj
  cnt <- 0
  
  # run Simulated Annealing
  for(i in 1:maxit) {
    neigh <- create_random(numSensors,geoRadius)              # generate a neighbor solution
    neigh_obj <- mapPoints(neigh, cityGrid, r, geoRadius)   # calculate the objective value of the new solution
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
  return(best)
}


##--PM data classifier--##
MlClassifier <- function(){
  #Load in all Kaggle Data for machine learning
  january = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/january-2017.csv"))
  february = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/february-2017.csv"))
  march = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))
  april = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/april-2017.csv"))
  may = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/may-2017.csv"))
  june = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/june-2017.csv"))
  july = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/july-2017.csv"))
  august = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/august-2017.csv"))
  september = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/september-2017.csv"))
  october = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/october-2017.csv"))
  november = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/november-2017.csv"))
  december = as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/december-2017.csv"))
  
  Sys.setenv(TZ='Poland') #we're looking at data from Poland, to avoid erors we'll use this command. If this is not given a timezone error will appear.
  
  #Convert time to a time that we can manipulate
  january$`UTC time` = as_datetime(january$`UTC time`)
  february$`UTC time` = as_datetime(february$`UTC time`)
  march$`UTC time` = as_datetime(march$`UTC time`)
  april$`UTC time` = as_datetime(april$`UTC time`)
  may$`UTC time` = as_datetime(may$`UTC time`)
  june$`UTC time` = as_datetime(june$`UTC time`)
  july$`UTC time` = as_datetime(july$`UTC time`)
  august$`UTC time` = as_datetime(august$`UTC time`)
  september$`UTC time` = as_datetime(september$`UTC time`)
  october$`UTC time` = as_datetime(october$`UTC time`)
  november$`UTC time` = as_datetime(november$`UTC time`)
  december$`UTC time` = as_datetime(december$`UTC time`)
  
  jan.test = january %>% select(contains("pm"))
  feb.test = february %>% select(contains("pm"))
  mar.test = march %>% select(contains("pm"))
  apr.test = april %>% select(contains("pm"))
  may.test = may %>% select(contains("pm"))
  jun.test = june %>% select(contains("pm"))
  jul.test = july %>% select(contains("pm"))
  aug.test = august %>% select(contains("pm"))
  sep.test = september %>% select(contains("pm"))
  oct.test = october %>% select(contains("pm"))
  nov.test = november %>% select(contains("pm"))
  dec.test = december %>% select(contains("pm"))
  # create a function to replace NA values with the median
  # medrep = function(i){
  #   i[is.na(i)] = median(i, na.rm=TRUE) 
  #   as.numeric(i)
  # }
  # jan.med = data.frame(apply(jan.test,2,medrep))
  # feb.med = data.frame(apply(feb.test,2,medrep))
  # mar.med = data.frame(apply(mar.test,2,medrep))
  # apr.med = data.frame(apply(apr.test,2,medrep))
  # may.med = data.frame(apply(may.test,2,medrep))
  # jun.med = data.frame(apply(jun.test,2,medrep))
  # jul.med = data.frame(apply(jul.test,2,medrep))
  # aug.med = data.frame(apply(aug.test,2,medrep))
  # sep.med = data.frame(apply(sep.test,2,medrep))
  # oct.med = data.frame(apply(oct.test,2,medrep))
  # nov.med = data.frame(apply(nov.test,2,medrep))
  # dec.med = data.frame(apply(dec.test,2,medrep))
  
  yr.noname = data.frame(   # to store 3 cols of all sensor data from all months
    pm010 = jan.test$`3_pm1`,
    pm025 = jan.test$`3_pm25`,
    pm100 = jan.test$`3_pm10`
  )
  
  #function created to fill a data frame with all particulate data from Kaggle
  #df.noname = Data frame of all pm values with no dates 
  #df.test= data from the respective month to load into dataframe
  #col= the col that is desired to load into the matrix, default value is set to 1
  next3rep = function(df.noname, df.test, col = 1){
    while(col <= length(df.test)-2) {
      df.next3 = df.test[col:(col+2)]
      names(df.next3) = c("pm010", "pm025", "pm100")
      df.noname = rbind(df.noname, df.next3)
      col = col+3
    }
    return(df.noname)
  }
  yr.noname = next3rep(yr.noname, jan.test, col = 4)  # fill rest of jan
  yr.noname = next3rep(yr.noname, feb.test)  # fill with feb
  yr.noname = next3rep(yr.noname, mar.test)  # fill with mar
  yr.noname = next3rep(yr.noname, apr.test)  # fill with apr
  yr.noname = next3rep(yr.noname, may.test)  # fill with may
  yr.noname = next3rep(yr.noname, jun.test)  # fill with jun
  yr.noname = next3rep(yr.noname, jul.test)  # fill with jul
  yr.noname = next3rep(yr.noname, aug.test)  # fill with aug
  yr.noname = next3rep(yr.noname, sep.test)  # fill with sep
  yr.noname = next3rep(yr.noname, oct.test)  # fill with oct
  yr.noname = next3rep(yr.noname, nov.test)  # fill with nov
  yr.noname = next3rep(yr.noname, dec.test)  # fill with dec
  yr.noname[yr.noname < 0] = NA   # mark negative values NA
  yr.noname = na.omit(yr.noname)  # eventually omit NA
  
  # we need to remove outliers using interquartile range
  outliers1 = boxplot.stats(yr.noname[ ,1],coef = 3)$out
  outliers2 = boxplot.stats(yr.noname[ ,2],coef = 3)$out
  outliers3 = boxplot.stats(yr.noname[ ,3],coef = 3)$out
  yr.nout = yr.noname[-which(yr.noname[ ,1] %in% outliers1), ]
  yr.nout = yr.noname[-which(yr.noname[ ,2] %in% outliers2), ]
  yr.nout = yr.noname[-which(yr.noname[ ,3] %in% outliers3), ]
  rownames(yr.nout) = NULL
  
  # statistics
  yr.avg_pm010 = mean(yr.nout$pm010)
  yr.avg_pm025 = mean(yr.nout$pm025)
  yr.avg_pm100 = mean(yr.nout$pm100)
  
  # preparing factors for training based on means after outliers removed, per pm level
  yr.nout$pm010.label = as.factor(ifelse(yr.nout$pm010 >= yr.avg_pm010, 1, 0))
  yr.nout$pm025.label = as.factor(ifelse(yr.nout$pm025 >= yr.avg_pm025, 1, 0))
  yr.nout$pm100.label = as.factor(ifelse(yr.nout$pm100 >= yr.avg_pm100, 1, 0))
  yr.nout$rating = as.numeric(as.character(yr.nout[,4])) + as.numeric(as.character(yr.nout[,5])) + as.numeric(as.character(yr.nout[,6]))  # row-sum of pm factors
  yr.nout$rating = factor(yr.nout$rating) # back to factor with Levels: {0, 1, 2, 3} in order of 'best' to 'worst'
  
  #Do the classify procedure as labeled in A2
  trainIndex = createDataPartition(yr.nout$rating, p=0.75)$Resample1
  train = yr.nout[trainIndex, ]
  test = yr.nout[-trainIndex, ]
  yr.nB = naiveBayes(rating ~ pm010 + pm025 + pm100, data=train) # uses *.label cols
  yr.trainPred = predict(yr.nB, newdata = train)
  yr.trainTable = table(train$rating, yr.trainPred)
  yr.testPred = predict(yr.nB, newdata = test[1:3])
  yr.testTable = table(test$rating, yr.testPred)
  confusionMatrix(yr.testPred, test$rating)$overall['Accuracy']
  return(yr.nB)
}
#After running the confusion matrix our predicter has 87.37% accuracy!
#We can now just input generated pm values and get labels automatically


#Function made to take in new data points that are able to classify simulated data
#pm_data = generated partiulate matter dataframe
#nB= inputed naive Bayes classifier generated from the Kaggle data using machine learning
data_label <- function(pm_data, nB){
  testdata = predict(nB, newdata = pm_data)
  combined= cbind(pm_data, testdata)
  return(combined)
}


##--Simulation--##

#Call function
sortPM <- function(input_time, region){
  month <- lubridate::month(input_time, label = TRUE, abbr = FALSE)
  monthnum <- lubridate::month(input_time)
  input_time <- round(input_time, "hour")
  yearnum <- lubridate::year(input_time)
  day <- sample(c(1:30), 1)
  hour <- sample(c(0:23), 1)
  input_time <- as.POSIXct(paste0(yearnum,"-",monthnum,"-",day," ",hour,":00:00 CET"))
  time_since <- as.numeric(input_time) - as.numeric(as.POSIXct("2019-1-1 0:00"))  + as.numeric(as.POSIXct("2017-1-1 0:00"))
  pm_df <- data.frame(PM = rep(0,3), row.names = c(1,2.5,10))
  
  if (region == 0){
    sensor_num <- sample(c(169, 225), 1)  
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since)
  }
  if (region == 1){
    sensor_num <- sample(c(204, 194, 210), 1)  
    
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since)
  }
  
  if (region == 2){
    sensor_num <- sample(c(185, 182, 219), 1)
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since)
  }
  pm_df <- transpose(pm_df)
  colnames(pm_df) <- c("pm010", "pm025", "pm100")
  return(pm_df)
}

#Generate random data point 
smooth_reg_month_maker<-function(sensor,pms=1,month="january", time_since){
  #Geographic information contained in this csv file
  sensor_locations <- read.csv("air-quality-data-from-extensive-network-of-sensors/sensor_locations.csv")
  #Monthly data contained in these csv files. 
  gett_data<-paste("air-quality-data-from-extensive-network-of-sensors/",month,"-2017.csv",sep="")
  month_data <- as_tibble(fread(gett_data))
  
  Sys.setenv(TZ='Poland') #we're looking at data from Poland, to avoid erors we'll use this command. If this is not given a timezone error will appear.
  month_data$`UTC time` <- as_datetime(month_data$`UTC time`)
  
  MONTH <- month_data
  
  #Code to create the Fit Test
  kable(head(is.na(MONTH),n=10))
  MONTH.test<-MONTH %>% select(-`UTC time`)
  medrep <- function(i){
    i[is.na(i)] <- median(i, na.rm=TRUE) 
    as.numeric(i)
  }
  MONTH.med<- data.frame(apply(MONTH.test,2,medrep))
  MONTH.med<-MONTH.med %>% mutate(Date=MONTH$`UTC time`)
  
  Date <- MONTH.med$Date
  Sensor_and_pm<-paste("X",sensor,"_pm",pms,sep="")
  
  S_PM <- MONTH.med[[Sensor_and_pm]]
  fit<-smooth.spline(Date,S_PM,df=32)
  index <- match(time_since, fit$x)
  
  return(random_collect(fit$y[index])) 
}

#Random number generator
random_collect <- function(x){
  #x: randomized number from regression to be "collected" by sensor.
  
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


##--Mobile Sensor Movement--##

#Generate destinations of sensors
priority_destinations <- function(sensors, pm_data){
  destination_sensors <- sample(which(pm_data[,4] == 3), trunc(length(which(pm_data[,4]==3))))
  destinations_x <- sensors[destination_sensors, 1]
  destinations_y <- sensors[destination_sensors,2]
  destinations <- data.frame("x_dest" = destinations_x,"y_dest" = destinations_y)
  return(destinations)
}

#Find sensor nearest to destination
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

#Moves sensor to new location
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