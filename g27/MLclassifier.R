MlClassifier <- function(){

require(readr)  #input/output
require(tibble) #as_tibble, easy to use
require(dplyr)  #data wrangling
require(plyr)
require(stringr)  #more data wrangling
require(lubridate)  #date/time
require(data.table) #data manipulation
require(ggplot2)  #plotting
require(caret)  #createDataPartition
require(e1071)  #naiveBayes
# require(knitr)  #quite fond of the kable function for making tables.
# require(ggthemes) #plotting
# require(gridExtra)  #extra space for plots
# require(leaflet)  #mapping
# require(leaflet.extras) #mapping
# require(RColorBrewer) #plotting
# require(ggridges) #plotting density ridges

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