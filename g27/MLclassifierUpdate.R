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

#function created to fill a data frame with all particulate data from Kaggle
#df.noname = Data frame of all pm values with no dates 
#df.test= data from the respective month to load into dataframe
#col= the col that is desired to load into the matrix, default value is set to 1
next3rep = function(df.test, month){
  col = 1
  df.noname = NULL
  while(col <= length(df.test)-2) {
    df.next3 = df.test[col:(col+2)]
    names(df.next3) = c(paste0("pm010",month), paste0("pm025",month), paste0("pm100",month))
    df.noname = rbind(df.noname, df.next3)
    col = col+3
  }
  df.noname[df.noname < 0] = NA   # mark negative values NA
  df.noname = na.omit(df.noname)  # eventually omit NA
  return(df.noname)
}
janyr.noname = next3rep(jan.test, "jan")  # fill rest of jan
febyr.noname = next3rep(feb.test, "feb")  # fill with feb
maryr.noname = next3rep(mar.test, "mar")  # fill with mar
apryr.noname = next3rep(apr.test, "apr")  # fill with apr
mayyr.noname = next3rep(may.test, "may")  # fill with may
junyr.noname = next3rep(jun.test, "jun")  # fill with jun
julyr.noname = next3rep(jul.test, "jul")  # fill with jul
augyr.noname = next3rep(aug.test, "aug")  # fill with aug
sepyr.noname = next3rep(sep.test, "sep")  # fill with sep
octyr.noname = next3rep(oct.test, "oct")  # fill with oct
novyr.noname = next3rep(nov.test, "nov")  # fill with nov
decyr.noname = next3rep(dec.test, "dec")  # fill with dec

#finds the minimum number of days in the kaggle data for a given month
n <- min(dim(janyr.noname)[1], dim(febyr.noname)[1], dim(maryr.noname)[1], dim(apryr.noname)[1], dim(mayyr.noname)[1], dim(junyr.noname)[1], dim(julyr.noname)[1], dim(augyr.noname)[1], dim(sepyr.noname)[1], dim(octyr.noname)[1], dim(novyr.noname)[1], dim(decyr.noname)[1])

#randomly selects days for each month to then us for classifying the data
yr.noname <- cbind(janyr.noname[sample(dim(janyr.noname)[1], n),], febyr.noname[sample(dim(febyr.noname)[1], n),], maryr.noname[sample(dim(maryr.noname)[1], n),], apryr.noname[sample(dim(apryr.noname)[1], n),], mayyr.noname[sample(dim(mayyr.noname)[1], n),], junyr.noname[sample(dim(junyr.noname)[1], n),], julyr.noname[sample(dim(julyr.noname)[1], n),], augyr.noname[sample(dim(augyr.noname)[1], n),], sepyr.noname[sample(dim(sepyr.noname)[1], n),], octyr.noname[sample(dim(octyr.noname)[1], n),], novyr.noname[sample(dim(novyr.noname)[1], n),], decyr.noname[sample(dim(decyr.noname)[1], n),])

# we need to remove outliers using interquartile range
for (cnt in 1:dim(yr.noname)[2]){
outliers1 = boxplot.stats((yr.noname[ ,cnt]),coef = 3)$out
yr.nout = yr.noname[-which(yr.noname[ ,cnt] %in% outliers1), ]
}
rownames(yr.nout) = NULL

nBbymonth <- function(yr.nout){
colnames(yr.nout) = c("pm010", "pm025", "pm100")  
  
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
#(confusionMatrix(yr.testPred, test$rating)$overall['Accuracy'])
return(yr.nB)
}

jan.nB =nBbymonth(yr.nout %>% select(contains("jan")))
feb.nB =nBbymonth(yr.nout %>% select(contains("feb")))
mar.nB =nBbymonth(yr.nout %>% select(contains("mar")))
apr.nB =nBbymonth(yr.nout %>% select(contains("apr")))
may.nB =nBbymonth(yr.nout %>% select(contains("may")))
jun.nB =nBbymonth(yr.nout %>% select(contains("jun")))
jul.nB =nBbymonth(yr.nout %>% select(contains("jul")))
aug.nB =nBbymonth(yr.nout %>% select(contains("aug")))
sep.nB =nBbymonth(yr.nout %>% select(contains("sep")))
oct.nB =nBbymonth(yr.nout %>% select(contains("oct")))
nov.nB =nBbymonth(yr.nout %>% select(contains("nov")))
dec.nB =nBbymonth(yr.nout %>% select(contains("dec")))

all.nBs = list("January" = jan.nB, "February" = feb.nB, "March" = mar.nB, "April"=apr.nB, "May"=may.nB, "June"=jun.nB, "July"=jul.nB, "August"=aug.nB, "September"=sep.nB, "October"=oct.nB, "November"=nov.nB, "December" =dec.nB)
return(all.nBs)
}

#After running the confusion matrix our predicter has 87.37% accuracy!
#We can now just input generated pm values and get labels automatically


#Function made to take in new data points that are able to classify simulated data
#pm_data = generated partiulate matter dataframe
#nB= inputed naive Bayes classifier generated from the Kaggle data using machine learning
data_label <- function(pm_data, nB){
  testdata = predict(nB, newdata = pm_data)
  combined= cbind(pm_data, "class"=testdata)
  return(combined)
}
