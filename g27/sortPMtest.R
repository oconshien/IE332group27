sortPM <- function(input_time, region){
  month <- month(input_time, label = TRUE, abbr = FALSE)
  time_since <- as.numeric(input_time) - as.numeric(as.POSIXct("2019-1-1 0:00"))  + as.numeric(as.POSITct("2017-1-1 0:00"))
  print(month)
    if (region == 0){
      sensor_num <- sample(c(169, 219, 225))  
      smooth_reg_month_maker(sensor_num, 1, month, time_since)
      smooth_reg_month_maker(sensor_num, 25, month, time_since)
      smooth_reg_month_maker(sensor_num, 10, month, time_since)
    }
    if (region == 1){
      sensor_num <- sample(c(204, 194, 178))  
      smooth_reg_month_maker(sensor_num, 1, month, time_since)
      smooth_reg_month_maker(sensor_num, 25, month, time_since)
      smooth_reg_month_maker(sensor_num, 10, month, time_since)
    }
    
    if (region == 2){
      sensor_num <- sample(c(185, 182, 219))
      smooth_reg_month_maker(sensor_num, 1, month, time_since)
      smooth_reg_month_maker(sensor_num, 25, month, time_since)
      smooth_reg_month_maker(sensor_num, 10, month, time_since)
    }
}