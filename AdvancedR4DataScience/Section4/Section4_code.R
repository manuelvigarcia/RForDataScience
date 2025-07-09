# meteorological data.
#import data
getwd()
setwd(paste0(getwd(),"/../Section4/Data/Weather Data/"))
getwd()
Chicago <- read.csv("Chicago-F.csv", row.names=1)
Chicago
NewYork <- read.csv("NewYork-F.csv", row.names=1)
Houston <- read.csv("Houston-F.csv", row.names=1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names=1)

#Check imported values
Chicago
NewYork
Houston
SanFrancisco

is.data.frame(Chicago)

#Convert all to Matrices
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)
is.matrix(Chicago)
is.matrix(SanFrancisco)

#Lest put it into a list
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather

#Try accessing single elements
Weather[3]  # List
Weather[[3]] #just the matrix
Weather$Houston  #Same here


#Mini divergence to learn about Apply family of functions
matrix_data <- c(27,63,42,111,12,1,54,34,98,21,44,14,54,101,2)
M <- matrix(matrix_data, nrow=3, ncol=5,byrow=T)
is.matrix(M)
M
#Operate by rows. 2nd parameter is 1
apply(M, 1, mean)            # --> [1] 51.0 41.6 43.0
apply(M,1,max)               # --> [1] 111  98 101
#Operate by columns. 2nd parameter is 2
apply(M,2,mean)              # --> [1]  24.00000  43.66667  43.33333 103.33333  11.66667


#Using apply
apply(Chicago, 1, mean) #   # --> 59.333333       43.250000        3.253333        9.916667      208.666667
#Check
mean(Chicago["AvgHigh_F",])       # --> [1] 59.33333
mean(Chicago["AvgLow_F",])        # --> [1] 43.25
mean(Chicago["AvgPrecip_inch",])  # --> [1] 3.253333
mean(Chicago["DaysWithPrecip",])  # --> [1] 9.916667
mean(Chicago["HoursOfSunshine",]) # --> [1] 208.6667

#Analyze one city
apply(Chicago,1,max)
apply(Chicago,1,min)

#Compare cities
apply(Chicago,1,mean)
apply(NewYork,1,mean)
apply(Houston,1,mean)
apply(SanFrancisco,1,mean)

#REcreate apply with loops
#find the mean of every row:
# via loops
output <- NULL
for(i in 1:5){
  output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output

#via apply
apply(Chicago, 1, mean)


#Using lapply()
lapply(Weather, t)

lapply(Weather, rbind, NewRow=1:12)

lapply(Weather, rowMeans)

#Combining lapply with []
#Extracting the January AvgHigh_F for Chicago
Weather$Chicago[1,1]
#which is the same as
Weather[[1]][1,1]

#if we want the January AvgHigh_f for all 4 cities
Weather[[1]][1,1]
Weather[[2]][1,1]
Weather[[3]][1,1]
Weather[[4]][1,1]

#Which is kind of the typical work for lapply
lapply(Weather, "[", 1, 1)

#All the AvgHigh_f for all cities
lapply(Weather, "[", 1, )

#And if we want to filter the Weather and only show values for March
lapply(Weather, "[", , 3)
Weather

##Personal practice
#Find the total precipitation in a year for each of the cities
sum(Weather$Chicago["AvgPrecip_inch",]) # This is the sum for just Chicago
sum(Weather$NewYork["AvgPrecip_inch",])
sum(Weather$Houston["AvgPrecip_inch",])
sum(Weather$SanFrancisco["AvgPrecip_inch",])
#Then, put as with lapply
#Get all the months of AvgPrecip_inch
lapply(Weather, "[", "AvgPrecip_inch",)
typeof(lapply(Weather, "[", "AvgPrecip_inch",))
#now make the sum of each element
lapply(lapply(Weather, "[", "AvgPrecip_inch",),sum)  # --> exactly what we wanted
#Now, the same for DaysWithPrecip, HoursOfSunshine
lapply(lapply(Weather, "[", "DaysWithPrecip",), sum) # --> Yearly days with precipitation
lapply(lapply(Weather, "[", "HoursOfSunshine",), sum) #--> Yearly hours of sunshine


##Adding your own function in lapply
lapply(Weather, rowMeans)     # calculates the means for each row in each of the 4 elements inside Weather
#But we can use anything instead of "rowMeans"
lapply(Weather, function(x) x[1,] ) # --> first row for each city ("AvgHigh_F")
lapply(Weather, function(x) x[5,] ) # --> Fifth row, i.e. Sunshine hours for each city
lapply(Weather, function(x) x[,12]) # --> Last column for each city. This is: all data points for December in each city

lapply(Weather, function(z) z[1,]-z[2,]) # --> difference between first and second rows: i.e. temp difference
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))  # --> This is the % temp. change per month in each city

#Exercise: calculate the average precipitation for each precipitation day
#We'll be working with these data
lapply(Weather, "[", c(3,4),)
lapply(Weather, function(y) round(y[3,]/y[4,],4))   # --> And these are the average inches of rain for each rainy day


#Using sapply()  --> Simpler version of lapply returning vector or matrix
#AvgHigh_F for July:
lapply(Weather, "[", 1,7)
typeof(lapply(Weather, "[", 1,7)) # --> "list"
#If we use sapply
sapply(Weather, "[", 1,7)         # --> we get a vector
typeof(sapply(Weather, "[", 1,7)) # --> "double"
#AvgHigh_F for the last 3 months of the year
lapply(Weather, "[", 1,10:12)     # --> list with the three month names and the AvhHigh_F value for each one
sapply(Weather, "[", 1,10:12)     # --> Matrix of months by Cities

#Let's work towards one of the deliverables
#We almost had it when westarted with lapply
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2)   # --> this can be presented as deliverable 1


lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))  # --> this makes deliverable 2

#sapply is a simplified version of lapply, just using simplyfy=FALSE and USE.NAMES=FALSE
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2), simplify = F, USE.NAMES = F) # --> exact same as lapply

#Nesting apply Functions
lapply(Weather, rowMeans)

#Get the maximum for each observation
apply(Weather$Chicago,1, max) # --> now that it is not a list, max() can be applied
#so, for the whole list of matrices
#in the function way of doing things:
lapply(Weather, function(x) apply(x, 1, max))
#but the apply function was already defined, is not mine, so:
lapply(Weather, apply, 1, max)

sapply(Weather, apply, 1, max)  # --> deliverable 3
#And for the minimums
sapply(Weather, apply, 1, min)  # --> deliverable 4


Weather$Chicago
which.max(Weather$Chicago[1,]) # --> this gives us the max for Chicago, which appears to be July
# How do we just get the month name?
names(which.max(Weather$Chicago[1,]))     # --> "Jul"

#and for all the cities: we'll have apply to get the month name and sapply to do it for all cities
apply(Weather$Chicago, 1, function(x) names(which.max(x))) # --> list of the months where the max of each data point
#Now for all cities
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
#beautify:
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))



#Pregunta del examen
#Question 5: You have a list as per the below code.
M1 <- rbind(c(100,200,300,400,500), rep(10,5))
M2 <- rbind(1:5, rep(10,5))
MyAwesomeList <- list(M1, M2)
MyAwesomeList
#How do you divide the first row by the second row for every matrix in this list and return the result as a matrix?
sapply(MyAwesomeList, function(x) x[1,]/x[2,])

