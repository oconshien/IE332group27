sortPM <- function(input_time, region, storm_time){
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
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  if (region == 1){
    sensor_num <- sample(c(204, 194, 210), 1)  
    
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  
  if (region == 2){
    sensor_num <- sample(c(185, 182, 219), 1)
    pm_df[1,] <- smooth_reg_month_maker(sensor_num, 1, month, time_since, storm_time)
    pm_df[2,] <- smooth_reg_month_maker(sensor_num, 25, month, time_since, storm_time)
    pm_df[3,] <- smooth_reg_month_maker(sensor_num, 10, month, time_since, storm_time)
  }
  pm_df <- transpose(pm_df)
  colnames(pm_df) <- c("pm010", "pm025", "pm100")
  return(pm_df)
}