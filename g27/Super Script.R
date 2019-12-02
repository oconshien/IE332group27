##--LOAD PACKAGES--##
require(dplyr) #data wrangling
require(lubridate) #date/time
require(knitr) #quite fond of the kable function for making tables(TEST)
require(ggplot2) #plotting(TEST)
require(ggthemes) #plotting(TEST)
require(gridExtra) #extra space for plots(TEST)
require(data.table) #data manipulation
require(RColorBrewer) #plotting(TEST)
require(stringr) #more data wrangling (TEST)
require(ggridges) #plotting density ridges (TEST)
require(readr)  #input/output(TEST)
require(tibble) #as_tibble, easy to use
require(plyr)   ###TEST, same as dplyr???
require(caret)  #create data partition
require(e1071)  #naiveBayes
require(truncnorm)   
require(lpSolve)                          
require(RMySQL) 
require(berryFunctions)

###--HOW TO RUN CODE--###
#1) Run 'Super Script.R' in the console
#2) Assign the 'start' function to 'results' (i.e. results <- start())
    #'start' function inputs described inside function below
#3) Run SQL statements found on lines 124-141 to send information to database

##--START CODE--##

start <- function(email, quote_num, city){
  #email: string, email from the inputted quote.
  #quote_num: int, the nth quote from the associated email (e.g. second quote for user = 2).
  #city: string, the city being networked (should match name of the inputted city csv).
  
  #Intialize and load in database.
  my_DB <- dbConnect(MySQL(), user='g1109699', password='MySQL27', dbname='g1109699', host='mydb.itap.purdue.edu')
  on.exit(dbDisconnect(my_DB))
  email_call <- paste0("SELECT Q_ID FROM Quote WHERE email =","'",email,"'",";")
  email_query <- dbSendQuery(my_DB, email_call)
  quotes <- dbFetch(email_query)
  Q_ID <- quotes[quote_num, 1]
  dbClearResult(dbListResults(my_DB)[[1]])
  
  #Generate inputs from quote.
  quote_call <- paste0("SELECT * FROM Quote WHERE Q_ID =",Q_ID, ";") 
  input_query <- dbSendQuery(my_DB, quote_call)
  inputs <- dbFetch(input_query)

  #Budget from the quote.
  budget <- inputs[1, "budget"]
  
  #Geographic radius from the quote.
  geo_radius <- inputs[1, "geoRadius"]
  
  #Simulation start date from the quote (with formatting).
  date_from_SQL <- inputs[1, "date"]
  date_from_SQL <- as.POSIXlt(date_from_SQL)
  input_month <- format(date_from_SQL,"%B")
  
  #Length of simulation from the quote.
  time_from_SQL <- inputs[1, "numDays"]
  
  #Air quality focus from the quote (with mapping).
  air_pref <- inputs[1, "airPref"]
  if(air_pref == "good"){
    air_pref <- 0
  }else{
    air_pref <- 3
  }
  
  #City coordinates from the quote (finds latitude and longitude automatically from inputted city).
  city_lat <- inputs[1, "citylat"]
  city_long <- inputs[1, "citylon"]
  dbClearResult(dbListResults(my_DB)[[1]])

  #Load in city CSV (with formatting).
  city_CSV <- as.matrix(read.csv(paste0("sample cities/",city, ".csv"), header=F))
  city_grid <- build_city(city_CSV)
  city_grid_radius <- geo_radius / 20
  geo_difference <- (15000 - geo_radius) / 20

  #Intialize variables for the loop.
  pm_data <- NULL
  new_pm_data <- NULL
  hour_cnt <- 1

  #Weather factor generation (1% chance every hour there is a storm).
  storm_time <- sample(c(0,1), 1, prob = c(0.99, 0.01))

  #Naive Bayes classifier.
  classifier <- MlClassifier()

  #Initital network placement.
  mapped_network<- SA(budget, city_grid, geo_radius, just_values = F)
  location_sen <- mapped_network$best
  location_sen <- cbind(location_sen, "moving"= rep(0, length(location_sen[,1])))

  #Run the network.
  while(hour_cnt <= 24 * time_from_SQL){
    pm_data <- NULL
    new_pm_data <- NULL
    i <- 1
    print(hour_cnt)
    
    #Generates particulate matter data from simulation.
    while (i <= dim(location_sen)[1]){
      new_pm_data <- sort_PM(date_from_SQL, city_grid[trunc(location_sen[i, 1] / 20) + city_grid_radius + geo_difference, trunc(location_sen[i, 2] / 20) + city_grid_radius + geo_difference], storm_time)
      pm_data <- rbind(pm_data, new_pm_data)
      i <- i + 1
    }
    
    #Movement of the mobile sensors.
    classed_data <- data_label(pm_data, classifier[input_month])
    new_dests <- priority_destinations(location_sen, classed_data, air_pref)
    updated_locations <- nearest_sensor_finder(new_dests, location_sen, air_pref, classed_data, geo_radius)
    location_sen <- updated_locations
    date_from_SQL <- date_from_SQL + 60 * 60
    storm_time <- sample(c(0, 1), 1, prob = c(0.99, 0.01))
    hour_cnt <- hour_cnt + 1
  }
  return(c(location_sen, classed_data))
}
  
##--SEND INFO TO DATABASE--##

  #Sensor Formatting
  location_sen <- as.data.frame(results[1])
  location_sen[, 1] <- location_sen[, 1] / 111111 + city_lat
  location_sen[, 2] <- location_sen[, 2] / (111111 * (cos(location_sen[, 1]))) + city_long
  location_sen[, 3] <- ifelse(location_sen[, 3] == 1, "fixed", "mobile")
  names(location_sen) <- c("lat", "lon", "type")

  #Send to Database
  dbWriteTable(my_DB, "Sensor", data.frame("N_ID" = Q_ID, location_sen[, 1:3]), append = TRUE, header = TRUE,row.names = FALSE)
  sensor_call <- paste0("SELECT S_ID FROM Sensor WHERE N_ID =", Q_ID, ";")
  sensor_query <- dbSendQuery(my_DB, sensor_call)
  sensor_IDs <- dbFetch(sensor_query)

  classed_data <- results[2]
  air_data <- data.frame("time"=date_from_SQL, sensor_IDs, classed_data[, 1:3])
  dbWriteTable(my_DB, "Air_Quality", air_data, append=TRUE, header=TRUE,row.names=FALSE)
  
  
##--CITY FORMATTER--##

#Reformat City
build_city <- function(city){
  #city: matrix, represents the zoning of the inputted location to be networked (0 = rural, 1 = residential, 2 = urban/industrial). 
  
  geo_radius <- 15000 / 20
  
  #Dezones the out of range parts of inputted location.
  for(i in 1:(2 * geo_radius)){
    for(j in 1:(2 * geo_radius)){
      dist <- sqrt((i - 750) ^ 2 + (j - 750) ^ 2)
      if(dist > geo_radius){
        city[i, j] <- -1
      }
    }
  }
  
  return(as.matrix(city))
  #city: matrix, reformatted city matrix.
}


##--INITIAL SENSOR PLACEMENT--##

#Simulated Annealing for Sensor Placement
SA <- function(budget, city_grid, geo_radius = 15000, r = 50, temperature = 3000, maxit = 1000, cooling = 0.95, just_values = TRUE) {
  #budget: real, client inputted budget.
  #city_grid: matrix, the reformatted city inputted by client.
  #geo_radius: int(divisible by 20), client inputted geographic radius to be monitored.
  #r: real, observable radius of the sensors.
  #temperature: int, initial temperature.
  #maxit: int, maximum number of iterations to execute for.
  #cooling: real, rate of cooling.
  #just_values: logical, only return a list of best objective value at each iteration.
  
  #Intialize sensor allocation.
  numSensors <- budget_constraint(budget)
  
  #Intialize solution.
  s_sol <- create_random(numSensors, geo_radius) 
  s_obj <- calc_obj(s_sol, city_grid, r, geo_radius)     
  best  <- s_sol                                            
  best_obj <- s_obj                                         
  
  #Keeps best solution.
  obj_vals <- best_obj
  cnt <- 0
  
  #Run simulated annealing process.
  for(i in 1:maxit) {
    #Generate neighboring solution.
    neigh <- create_random(numSensors, geo_radius)             
    neigh_obj <- calc_obj(neigh, city_grid, r, geo_radius) 
    
    #Replace best solution with neighboring solution of neighbor objective is better.
    if (neigh_obj >= best_obj) {                                
      s_sol <- neigh
      s_obj <- neigh_obj
      best <- neigh
      best_obj <- neigh_obj
    
    #Replace best solution with a worse neighbor based on a probability.
    } else if ( runif(1) <= exp((neigh_obj - s_obj) / temperature)){
      s_sol <- neigh
      s_obj <- neigh_obj
      cnt <- cnt + 1
    }
    
    #Temperature update.
    temperature <- temperature * cooling 
    
    obj_vals <- c(obj_vals, best_obj)
  }
  
  #Plotting of best sensor network.
  plot(best[, 1], best[, 2], xlim = c(-geo_radius, geo_radius), ylim = c(-geo_radius, geo_radius), pch = 20, xlab = "X", ylab = "Y")
  points(best[, 1][which(best[, 3] == 1)], best[, 2][which(best[, 3] == 1)], col = "green", pch = 20)
  legend("topleft", legend = c("Fixed", "Mobile"), col = c("Black", "Green"), pch = c(20, 20), cex = 0.5)
  title("Default Sensor Locations")
  circle(0, 0, geo_radius)
  
  ifelse(just_values, return(obj_vals), return(list(best = best, best_obj = best_obj, values = obj_vals)))
  return(best)
  #best:data_frame, the sensor information for the best network.
}

#Random placement generator
create_random <- function(sensors, geo_radius = 15000){
  #sensors: vector(length 2), indicates number of fixed sensors [1], and number of mobile sensors [2].
  #geo_radius: int(divisible by 20), radius of area to be tracked, as indicated by client.
  
  sensor_sol <- matrix(data = rep(0, 2 * sum(sensors)), nrow = sum(sensors), ncol = 2)
  i <- 0
  
  #Randomize sensor locations.
  while (i < sum(sensors)){
    i <- i + 1
    sensor_sol[i, 1] <- trunc(runif(1, -geo_radius, geo_radius))
    sensor_sol[i, 2] <- trunc(runif(1, -geo_radius, geo_radius))
    if (sqrt(sensor_sol[i, 1] ^ 2+sensor_sol[i, 2] ^ 2) > geo_radius)
      i <- i - 1
  }
  
  #Randomize swapping of sensors.
  sensor_type <- c(rep(0, sensors[2]), rep(1, sensors[1]))
  for (n in 1:sum(sensors)){
    random <- replicate(2, sample(1:sum(sensors), 1))
    hold <- sensor_type[random[1]]
    sensor_type[random[1]] <- sensor_type[random[2]]
    sensor_type[random[2]] <- hold
  }
  sensor_sol <- cbind(sensor_sol,sensor_type)
  
  return(sensor_sol)
  #sensor_sol: data_frame, randomized sensors.
}

#Generate Sensor Allocation from Budget 
budget_constraint<-function(budget, repair_cost = 0, opt_repair = 0, risk = 0.01, alpha = 0.05){
  #budget: real, inputted budget from client.
  #repair_cost: real, cost to repair one sensor.
  #opt_repair: 
  #risk: real, rate of sensor failure.
  #alpha:

  #Objective function.
  f_obj <- c(7,1)
  
  #Preliminary risk generation.
  EV1 <- 4 * risk
  EV2 <- risk
  
  #Constrainst generation.
  f_con <- matrix(c(3500, 500, EV1, EV2), nrow = 2, byrow = TRUE)
  f_rhs <- c(budget - repair_cost * opt_repair, 10000)
  f_dir <- c("<=", "<=")
  
  #Generate intial solution.
  sen_allocate <- lp("max", f_obj, f_con, f_dir, f_rhs, int.vec = 1:2)$solution
  
  #Readjust solution taking risk and alpha(mobile vs fixed) into account.
  fails <- dbinom(as.integer((sen_allocate[1] + sen_allocate[2]) * alpha), size = sen_allocate[1], prob = 4 * risk)
  
  #Risk not important for high and low budgets.
  if(fails >= 0.5){
    sen_allocate
    stop
  }
  else{
    #Factor in risk.
    while(fails > alpha){
      sen_allocate[1] <- sen_allocate[1] - 1
      sen_allocate[2] <- sen_allocate[2] + 1
      fails <- dbinom(as.integer((sen_allocate[1] + sen_allocate[2]) * alpha), size = sen_allocate[1], prob = 4 * risk)
    }
  }
  
  #Swap mobile and sensor indicies.
  allocate_hold <- sen_allocate[1]
  sen_allocate[1] <- sen_allocate[2]
  sen_allocate[2] <- allocate_hold
  
  return(sen_allocate)
  #sen_allocate: vector(length 2), the sensor allocation with number of fixed and mobile.
}

# Calculate the objective value of a valid candidate solution.
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
  
  #City indexing.
  city_grid_radius <- geo_radius / 20
  
  #Account for region sensors are in and mobile placement for obj value.
  for (i in 1:(length(centers[, 1]))){
    #Fixed sensors better in urban/industrial.
    if(city_grid[trunc(centers[i, 1] / 20) + city_grid_radius, trunc(centers[i, 2] / 20) + city_grid_radius] == 2 & centers[i, 3] == 0)
      region_factor <- region_factor + 1 / length(centers[, 1])
    #Mobile sensors better in residential.
    if(city_grid[trunc(centers[i, 1] / 20) + city_grid_radius, trunc(centers[i, 2] / 20) + city_grid_radius] == 1 & centers[i, 3] == 1)
      region_factor <- region_factor + 1 / length(centers[, 1])
    #Mobile sensors better towards the center.
    if(centers[i, 3] == 1){
      mobile_factor <- mobile_factor + (-sqrt(centers[i, 1] ^ 2 + centers[i, 2] ^ 2) + geo_radius) * 1 / (geo_radius * length(which(centers[, 3]==1)))
    }
  }
  
  obj_value <- 1 - space_reduct - edge_reduct + region_factor + mobile_factor
  
  return(obj_value)
  #obj_value: int, a value representing the relative value of the current network.
}


##--PM DATA CLASSIFIER--##

MlClassifier <- function(){
  #Load in all Kaggle data for machine learning.
  january <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/january-2017.csv"))
  february <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/february-2017.csv"))
  march <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/march-2017.csv"))
  april <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/april-2017.csv"))
  may <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/may-2017.csv"))
  june <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/june-2017.csv"))
  july <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/july-2017.csv"))
  august <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/august-2017.csv"))
  september <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/september-2017.csv"))
  october <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/october-2017.csv"))
  november <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/november-2017.csv"))
  december <- as_tibble(fread("air-quality-data-from-extensive-network-of-sensors/december-2017.csv"))
  
  #Adjusts for Polish time zone.
  Sys.setenv(TZ = 'Poland') 
  
  #Convert to manipulatable time.
  january$`UTC time` <- as_datetime(january$`UTC time`)
  february$`UTC time` <- as_datetime(february$`UTC time`)
  march$`UTC time` <- as_datetime(march$`UTC time`)
  april$`UTC time` <- as_datetime(april$`UTC time`)
  may$`UTC time` <- as_datetime(may$`UTC time`)
  june$`UTC time` <- as_datetime(june$`UTC time`)
  july$`UTC time` <- as_datetime(july$`UTC time`)
  august$`UTC time` <- as_datetime(august$`UTC time`)
  september$`UTC time` <- as_datetime(september$`UTC time`)
  october$`UTC time` <- as_datetime(october$`UTC time`)
  november$`UTC time` <- as_datetime(november$`UTC time`)
  december$`UTC time` <- as_datetime(december$`UTC time`)
  
  jan_test <- january %>% select(contains("pm"))
  feb_test <- february %>% select(contains("pm"))
  mar_test <- march %>% select(contains("pm"))
  apr_test <- april %>% select(contains("pm"))
  may_test <- may %>% select(contains("pm"))
  jun_test <- june %>% select(contains("pm"))
  jul_test <- july %>% select(contains("pm"))
  aug_test <- august %>% select(contains("pm"))
  sep_test <- september %>% select(contains("pm"))
  oct_test <- october %>% select(contains("pm"))
  nov_test <- november %>% select(contains("pm"))
  dec_test <- december %>% select(contains("pm"))

  #Fill data frame with all particulate data from Kaggle.
  janyr_noname <- next_3_rep(jan_test, "jan")  
  febyr_noname <- next_3_rep(feb_test, "feb")  
  maryr_noname <- next_3_rep(mar_test, "mar")  
  apryr_noname <- next_3_rep(apr_test, "apr")  
  mayyr_noname <- next_3_rep(may_test, "may")  
  junyr_noname <- next_3_rep(jun_test, "jun")  
  julyr_noname <- next_3_rep(jul_test, "jul")
  augyr_noname <- next_3_rep(aug_test, "aug") 
  sepyr_noname <- next_3_rep(sep_test, "sep")  
  octyr_noname <- next_3_rep(oct_test, "oct")  
  novyr_noname <- next_3_rep(nov_test, "nov")  
  decyr_noname <- next_3_rep(dec_test, "dec")  
  
  #Minimum number of days for a given month in Kaggle data.
  n <- min(dim(janyr_noname)[1], dim(febyr_noname)[1], dim(maryr_noname)[1], dim(apryr_noname)[1], dim(mayyr_noname)[1], dim(junyr_noname)[1], dim(julyr_noname)[1], dim(augyr_noname)[1], dim(sepyr_noname)[1], dim(octyr_noname)[1], dim(novyr_noname)[1], dim(decyr_noname)[1])
  
  #Randomly selects days for each month to then us for classifying the data.
  yr_noname <- cbind(janyr_noname[sample(dim(janyr_noname)[1], n),], febyr_noname[sample(dim(febyr_noname)[1], n),], maryr_noname[sample(dim(maryr_noname)[1], n),], apryr_noname[sample(dim(apryr_noname)[1], n),], mayyr_noname[sample(dim(mayyr_noname)[1], n),], junyr_noname[sample(dim(junyr_noname)[1], n),], julyr_noname[sample(dim(julyr_noname)[1], n),], augyr_noname[sample(dim(augyr_noname)[1], n),], sepyr_noname[sample(dim(sepyr_noname)[1], n),], octyr_noname[sample(dim(octyr_noname)[1], n),], novyr_noname[sample(dim(novyr_noname)[1], n),], decyr_noname[sample(dim(decyr_noname)[1], n),])
  
  #Removes outliers.
  for (cnt in 1:dim(yr_noname)[2]){
    outliers_1 <- boxplot.stats((yr_noname[, cnt]), coef = 3)$out
    yr_nout <- yr_noname[-which(yr_noname[, cnt] %in% outliers_1), ]
  }
  rownames(yr_nout) <- NULL
  
  
  jan_nB <- nB_by_month(yr_nout %>% select(contains("jan")))
  feb_nB <- nB_by_month(yr_nout %>% select(contains("feb")))
  mar_nB <- nB_by_month(yr_nout %>% select(contains("mar")))
  apr_nB <- nB_by_month(yr_nout %>% select(contains("apr")))
  may_nB <- nB_by_month(yr_nout %>% select(contains("may")))
  jun_nB <- nB_by_month(yr_nout %>% select(contains("jun")))
  jul_nB <- nB_by_month(yr_nout %>% select(contains("jul")))
  aug_nB <- nB_by_month(yr_nout %>% select(contains("aug")))
  sep_nB <- nB_by_month(yr_nout %>% select(contains("sep")))
  oct_nB <- nB_by_month(yr_nout %>% select(contains("oct")))
  nov_nB <- nB_by_month(yr_nout %>% select(contains("nov")))
  dec_nB <- nB_by_month(yr_nout %>% select(contains("dec")))
  
  all_nBs <- list("January" = jan_nB, "February" = feb_nB, "March" = mar_nB, "April"=apr_nB, "May"=may_nB, "June"=jun_nB, "July"=jul_nB, "August"=aug_nB, "September"=sep_nB, "October"=oct_nB, "November"=nov_nB, "December" =dec_nB)
  return(all_nBs)
  #all_nBs:
}

#Pull Kaggle data based on designated month.
next_3_rep <- function(df_test, month){
  #df_test: data_frame, data frame to be filled with Kaggle pm data.
  #month: string, designated month to choose Kaggle data from.
  
  #Initialization
  col <- 1
  df_noname <- NULL
  
  #Pulls corresponding Kaggle data.
  while(col <= length(df_test) - 2) {
    df_next_3 <- df_test[col:(col + 2)]
    names(df_next_3) <- c(paste0("pm010", month), paste0("pm025", month), paste0("pm100", month))
    df_noname <- rbind(df_noname, df_next_3)
    col <- col + 3
  }
  
  #Remove negative values and NAs
  df_noname[df_noname < 0] <- NA   
  df_noname <- na.omit(df_noname) 
  
  return(df_noname)
  #df_noname: data_frame, formatted Kaggle data for designated month.
}


#Attach classes to the Kaggle data.
nB_by_month <- function(yr_nout){
  #yr_nout: data_frame, the generated Kaggle data from the year.
  
  #Assign column names to data frame.
  colnames(yr_nout) <- c("pm010", "pm025", "pm100")  
  
  #Means of each pm type.
  yr_avg_pm010 <- mean(yr_nout$pm010)
  yr_avg_pm025 <- mean(yr_nout$pm025)
  yr_avg_pm100 <- mean(yr_nout$pm100)
  
  #Preparing factors for training based on means after outliers removed, per pm level.
  yr_nout$pm010.label <- as.factor(ifelse(yr_nout$pm010 >= yr_avg_pm010, 1, 0))
  yr_nout$pm025.label <- as.factor(ifelse(yr_nout$pm025 >= yr_avg_pm025, 1, 0))
  yr_nout$pm100.label <- as.factor(ifelse(yr_nout$pm100 >= yr_avg_pm100, 1, 0))
  yr_nout$rating <- as.numeric(as.character(yr_nout[,4])) + as.numeric(as.character(yr_nout[,5])) + as.numeric(as.character(yr_nout[,6]))  # row-sum of pm factors
  yr_nout$rating <- factor(yr_nout$rating)
  
  #Classification procedure (classes = 0, 1, 2, 3; from best air quality to worst).
  train_index <- createDataPartition(yr_nout$rating, p=0.75)$Resample1
  train <- yr_nout[train_index, ]
  test <- yr_nout[-train_index, ]
  yr_nB <- naiveBayes(rating ~ pm010 + pm025 + pm100, data = train)
  ###yr_trainPred = predict(yr_nB, newdata = train)
  ###yr_trainTable = table(train$rating, yr_trainPred)
  ###yr_testPred = predict(yr_nB, newdata = test[1:3])
  ###yr_testTable = table(test$rating, yr_testPred)
  
  return(yr_nB)
  #yr_nB: data_frame, classes of the air quality attached to Kaggle data frame.
}

#Classifies new data points using classifier generated from Kaggle.
data_label <- function(pm_data, nB){
  #pm_data: data_frame, generated particulate matter from simualtion.
  #nB: inputed naive Bayes classifier generated from the Kaggle data using machine learning
  
  #Classifies the inputted pm data.  
  test_data <- predict(nB, newdata = pm_data)
  combined <- cbind(pm_data, test_data)
  
  return(combined)
  #combined: data_frame, the classes of the inputted pm data.
}


##--SIMULATION--##

#Simulator Organizer and Call Function
sort_PM <- function(input_time, region, storm_time){
  #input_time: POSIXct, time of the simulation.
  #region: int(0,1,2), region the sensor being simulated for is in.
  #storm_time: binary, if the selected time is featuring a storm.
  
  #Time formatting.
  month <- lubridate::month(input_time, label = TRUE, abbr = FALSE)
  month_num <- lubridate::month(input_time)
  input_time <- round(input_time, "hour")
  year_num <- lubridate::year(input_time)
  day <- sample(c(1:30), 1)
  hour <- sample(c(0:23), 1)
  input_time <- as.POSIXct(paste0(year_num, "-", month_num, "-", day, " ", hour, ":00:00 CET"))
  year(input_time) <- 2017
  time_since <- as.numeric(input_time)
  pm_df <- data.frame(PM = rep(0, 3), row.names = c(1, 2.5, 10))
  
  #PM data simualtor and randomizer.
  #Rural
  if (region == 0){
    sensor_num <- sample(c(169, 225), 1)  
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  #Residential
  if (region == 1){
    sensor_num <- sample(c(204, 194, 210), 1)  
    
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  #Urban/Industrial
  if (region == 2){
    sensor_num <- sample(c(185, 182, 219), 1)
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  
  #Data frame formatting.
  pm_df <- transpose(pm_df)
  colnames(pm_df) <- c("pm010", "pm025", "pm100")
  
  return(pm_df)
  #pm_df: data_frame, simualted particulate matter data from kaggle with noise.
}

#Generate Spline of the Kaggle Data
smooth_reg_month_maker<-function(sensor, pms = 1, month = "january", time_since, storm_time){
  #sensor: int, sensor number to be pulling from for simulation.
  #pms: real, particulate matter to be splined.
  #month: month, the month to be splined.
  #time_since: UTC, the time since the beginning of the month (used to pull corresponding row).
  #storm_time: binary, if the selected time is featuring a storm.
  
  #Corresponding CSV pulling.
  sensor_locations <- read.csv("air-quality-data-from-extensive-network-of-sensors/sensor_locations.csv")
  get_data<-paste("air-quality-data-from-extensive-network-of-sensors/", month, "-2017.csv", sep = "")
  month_data <- as_tibble(fread(get_data))
  
  #Adjusts for Polish time.
  Sys.setenv(TZ = 'Poland')
  month_data$`UTC time` <- as_datetime(month_data$`UTC time`)
  current_month <- month_data
  #Creates the fit test.
  kable(head(is.na(current_month),n = 10))
  month_test <- current_month %>% select(-`UTC time`)
  medrep <- function(i){
    i[is.na(i)] <- median(i, na.rm=TRUE) 
    as.numeric(i)
  }
  month_med<- data.frame(apply(month_test, 2, medrep))
  month_med<-month_med %>% mutate(Date = current_month$`UTC time`)
  
  date <- month_med$Date
  sensor_and_pm<-paste("X", sensor, "_pm", pms, sep="")
  
  S_PM <- month_med[[sensor_and_pm]]
  fit <- smooth.spline(date , S_PM , df = 32)
  index <- match(time_since, fit$x)
  
  #Add noise to pulled pm data points.
  simulate_noise <- random_collect(fit$y[index], storm_time)
  
  return(simulate_noise)
  #simulate_noise: vector, the simualted pm data with noise added.
}

#Add Noise to Inputted Values
random_collect <- function(x, storm_time){
  #x: real, number to add noise to for simulation.
  #storm_time: binary, indicates if there is a storm occuring(causes higher error rates and more noise).
  
  #Error reading rate  generation.
  error_rate <- 0.01
  std_dev <- sqrt(abs(x))
  if(storm_time){
    error_rate <- 0.1
    std_dev <- 2 * sqrt(abs(x))
  }
  
  #Normal reading result.
  if (!sample(c(0,1), 1, prob = c(1-error_rate,error_rate)))
    return(rtruncnorm(1, a = 0, mean = x, sd = std_dev))
  #Erroneous reading result.
  else{
    #Erroneously high reading.
    if(sample(c(0,1), 1))
      return(rtruncnorm(1, a = x * 1.95, mean = x, sd = std_dev))
    #Erroneously low reading.
    else
      return(rtruncnorm(1, a = 0, b = x * 0.05, mean = x, sd = std_dev))
  }
  #returns the noisy reading.
}


##--MOBILE SENSOR MOVEMENT--##

#Generate Sensor Destinations
priority_destinations <- function(sensors, pm_data, quality_desired){
  #sensors: data_frame, all the sensors in the network.
  #pm_data: data_frame, the corresponding pm_data to the network.
  #quality_desired: int(0 or 3), the air quality of focus as designated by the client.
  
  #Pulls out sensors in priority locations based on classifier.
  destination_sensors <- sample(which(pm_data[, 4] == quality_desired), trunc(length(which(pm_data[, 4] == quality_desired))))
  destinations_x <- sensors[destination_sensors, 1]
  destinations_y <- sensors[destination_sensors, 2]
  destinations <- data.frame("x_dest" = destinations_x,"y_dest" = destinations_y)
  
  return(destinations)
  #destinations: data_frame, the (x,y) coordinates of the destinations to be moved to by sensors. 
}

#Nearest Mobile Sensor to Destination
nearest_sensor_finder <-function(destination, sensors, quality_desired, pm_class, geo_radius = 15000){
  #destination: data_frame, coordinates of final destinations for sensors to move to.
  #sensors: data frame, all the sensors in the network.
  #quality_desired: int(0 or 3), the air quality of focus as designated by the client.
  #pm_data: data_frame, the corresponding pm_data to the network.
  
  #Intialize 'moved' column of data frame, indicating if a sensor has already been chosen to move.
  sensors[, 4] <- rep(0, length(sensors[, 4]))
  
  #Find and move nearest sensor that is "open" (not already moved and not in a priority location).
  for(k in 1:length(destination[, 1])){
    mobile_sensors <- sensors[which(sensors[, 3] == 1), ]
    num_mobiles <- length(mobile_sensors[, 1])
    dist_vec <- vector(length = num_mobiles)
    
    #Calculate distances between destination and each mobile sensor.
    for(i in 1:num_mobiles){
      dist_vec[i] <- sqrt((destination[k, 1] - mobile_sensors[i, 1]) ^ 2 + (destination[k, 2] - mobile_sensors[i, 2]) ^ 2)
    }
    dist_vec <- unlist(dist_vec)
    dist_vec[which(dist_vec == 0)] <- 15001
    loop_iterate <- 1
    nth_term <- 1
    
    #Finds nearest "open" mobile sensor.
    while(loop_iterate){
      loop_iterate <- 1
      nth_term <- nth_term + 1
      #Exit loop if no nearby sensors are "open".
      if(nth_term > length(dist_vec)){
        break
      }
      near_mobile_index <- which(dist_vec == dist_vec[order(dist_vec)][nth_term])
      near_mobile <- mobile_sensors[near_mobile_index, ]
      near_index <- which(sensors[, 1] == near_mobile[1] & sensors[, 2] == near_mobile[2])
      #Sensor already moved, not "open".
      if(near_mobile[4] == 1){
        loop_iterate <- 2
        nth_term <- nth_term + 1
        already_indexed <- 1
      } 
      #Sensor already in priority location, not "open".
      else if(pm_class[near_index, 4] == quality_desired){
        loop_iterate <- 2
        nth_term <- nth_term + 1
      }
      
      #Move the mobile sensor.
      if(loop_iterate == 1){
        movement <- move_sensor(dist_vec[near_mobile_index], destination[k,], sensors[near_index,], geo_radius)
        movement <- unlist(movement)
        sensors[near_index, 1] <- movement[1] + sensors[near_index, 1]
        sensors[near_index, 2] <- movement[2] + sensors[near_index, 2]
        sensors[near_index, 4] <- 1
      }
      loop_iterate <- loop_iterate - 1
      
    }
  }
  
  return(sensors)
  #sensors: data_frame, updated sensor info after movements.
}

#Moves Sensor Closer to Destination
move_sensor <- function(distance, destination, near_sensor, geo_radius = 15000){
  #distance: real, distance to travel to get to destination.
  #destination: vector(length 2), coordinate of the final destiantion to move to.
  #geo_radius: int(divisible by 20), the geographic radius of coverage as specified by the client.
  
  #Goes towards destination if with 3 time steps (3000m).
  if(distance > 3000){
    destination <- sample(-geo_radius:geo_radius, 2)
  }
  x <- c(destination[1], near_sensor[1])
  y <- c(destination[2], near_sensor[2])
  x <- unlist(x)
  y <- unlist(y)
  dist_line <- lm(y ~ x)
  
  #No movement if already at destination.
  if(is.na(dist_line$coefficients[2]))
    return(c(0,0,0))
    
  #If more than one time step (1000m) moves 1000m closer to destination.
  if(distance>=1000){
    dest <- 1000
    #Determines the direction of movement. 
    if(x[1] > x[2]){
      x_dest <- sqrt(dest^2/(dist_line$coeff[[2]]^2+1))
    } else{
      x_dest <- -sqrt(dest^2/(dist_line$coeff[[2]]^2+1))
    }
    if(y[1] > y[2]){
      y_dest <- abs(dist_line$coeff[[2]] * x_dest)
    } else{
      y_dest <- -abs(dist_line$coeff[[2]] * x_dest)
    }
  }
  #If less than one time step(1000m) than move within 50m of the destination (do not want to fully overlap).
  else{
    x_minus_fifty <- sqrt(50^2/(dist_line$coeff[[2]]^2+1))
    #Determines direction of movement.
    if(x[1] > x[2]){
      x_dest <- destination[1] - x_minus_fifty
    } else{
      x_dest <- destination[1] + x_minus_fifty
    }
    if(y[1] > y[2]){
      y_dest <- destination[2] - dist_line$coeff[[2]] * x_minus_fifty
    } else{
      y_dest <- destination[2] + dist_line$coeff[[2]] * x_minus_fifty
    }
  }
  #If moving outside the geographic radius then sensor does not move.
  if(sqrt((x_dest+near_sensor[1]) ^ 2 + (y_dest + near_sensor[2])^2) > geo_radius){
    x_dest <- 0
    y_dest <- 0
  }
  
  movement <- c(x_dest,y_dest, 1)
  return(movement)
  #movement: vector(length 3), the updated location of the sensor and indicates that it already is moving for this hour.
}

data_analytics<-function(bigData, montht){
  distinct_locations<-distinct(bigData,x,y)
  results <- NULL
  i=1
  while(i <= nrow(distinct_locations)){
    indexesX<-which(bigData[,5] == distinct_locations[i,1])
    indexesboth<-which(bigData[indexesX,6] == distinct_locations[i,2])
    listofboth<-bigData[indexesX[indexesboth],]
    location<-listofboth[1,5:6]
    numberofinstances<-c(1:nrow(listofboth))
    #Data Analytics for the location
    #Data Analytics for PM010
    averagePM010<-mean(listofboth[,1])
    minPM010<-min(listofboth[,1])
    maxPM010<-max(listofboth[,1])
    if(length(numberofinstances)>1){
      lmPM010<-lm(numberofinstances~listofboth[,1])
      coefPM010<-coefficients(lmPM010)
      nextPredictedPM010<-as.numeric(coefPM010[1])+as.numeric(coefPM010[2])*((length(numberofinstances)+1):(length(numberofinstances)+50))
      print(nextPredictedPM010)
    }
    #Data Analytics for PM025
    averagePM025<-mean(listofboth[,2])
    minPM025<-min(listofboth[,2])
    maxPM025<-max(listofboth[,2])
    if(length(numberofinstances)>1){
      lmPM025<-lm(numberofinstances~listofboth[,2])
      coefPM025<-coefficients(lmPM025)
      nextPredictedPM025<-as.numeric(coefPM025[1])+as.numeric(coefPM025[2])*((length(numberofinstances)+1):(length(numberofinstances)+50))
      print(nextPredictedPM025)
    }
    #Data Analytics for PM100
    averagePM100<-mean(listofboth[,3])
    minPM100<-min(listofboth[,3])
    maxPM100<-max(listofboth[,3])
    if(length(numberofinstances)>1){
      lmPM100<-lm(numberofinstances~listofboth[,3])
      coefPM100<-coefficients(lmPM100)
      nextPredictedPM100<-as.numeric(coefPM100[1])+as.numeric(coefPM100[2])*((length(numberofinstances)+1):(length(numberofinstances)+50))
      print(nextPredictedPM100)
    }
    #Compute a Score
    pmdata<-c("pm010"=averagePM010,"pm025"=averagePM025,"pm100"=averagePM100)
    #data_label function will need to reference the previous ML Classifier output
    #classification<-data_label(pmdata,example[montht])
    #score<-(.50(classification[1,2])+.35(classification[2,2])+.15(classification[3,2]))/3
    result <- cbind("x" = distinct_locations[i,1],"y" = distinct_locations[i,2], averagePM010, minPM010, maxPM010, averagePM025, minPM025, maxPM025, averagePM100, minPM100, maxPM100)
    results <- rbind(results, result)
    i <- i+1
  }
  class <- data.frame("pm010"=results[,"averagePM010"], "pm025"=results[,"averagePM025"], "pm100"=results[,"averagePM100"])
  classification<- data_label(class,example[montht])
  final <- cbind(results, "quality score"= classification[,4])
}
