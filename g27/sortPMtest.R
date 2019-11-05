sortPM <- function(input_time, region){
  month <- lubridate::month(input_time, label = TRUE, abbr = FALSE)
  input_time <- round(input_time, "hour")
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
  return(pm_df)
}