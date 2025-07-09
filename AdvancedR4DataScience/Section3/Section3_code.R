getwd()
setwd(paste0(getwd(),"/Data"))
getwd()
util <- read.csv("Machine-Utilization.csv")
str(util)
summary(util)
factor(util$Machine)
util$Machine <- factor(util$Machine)
summary(util)

#Derive utilization column: practice how to add columns
util$Utilization = 1-util$Percent.Idle
head(util, 24)
util$PosixTime <- as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")
head(util, 50)
summary(util)

#reorganize dataframe
util$Timestamp<-NULL
summary(util)
util <- util[,c(4,1,2,3)]
head(util,12)

RL1 <- util[util$Machine=="RL1",]
RL1$Machine <- factor(RL1$Machine)
head(RL1,24)
summary(RL1)

#Start constructing the result list:
#  Character: Machine name
#      That'll be RL1

#  Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=T),
                    mean(RL1$Utilization, na.rm=T),
                    max(RL1$Utilization, na.rm=T))
util_stats_rl1

#  Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
util_under_90 <- length(which(RL1$Utilization < 0.90))>0
util_under_90

list_rl1 <- list("RL1", util_stats_rl1, util_under_90)
list_rl1

#Naming componets in a list

names(list_rl1)

names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
list_rl1
#or:
list_rl1 <- NULL
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90)
list_rl1


#Extracting components in a list
#[] -> returns a list
#[[]] -> get the object
#$ -> same as [[]], just prettier
list_rl1
list_rl1[1]  # gives a list of just one element that is the name of the machine
list_rl1[[1]]  # gives one string "RL1"
list_rl1$Machine  #gives the string "RL1"
typeof(list_rl1[1])    # --> "list"
typeof(list_rl1[[1]])  # --> "character"
typeof(list_rl1$Machine) #-->"character"


list_rl1[2]
list_rl1[[2]]
list_rl1$Stats


#Accessing the 3rd element of the stats element in the list
list_rl1$Stats[3]


list_rl1[3]
list_rl1[[3]]
list_rl1$LowThreshold

typeof(list_rl1[3])
typeof(list_rl1[[3]])
typeof(list_rl1$LowThreshold)


## adding new elements to a list
list_rl1
list_rl1[4] <- "New Information"

#  Vector: All hours where utilisation is unknown (NA’s)
RL1[is.na(RL1$Utilization),]  ## complete rows where the Utilization is NA
RL1[is.na(RL1$Utilization),"PosixTime"]   #Only the times of the rows with NA Utilization

#Add to the list
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

list_rl1[40]<-"More new information"
list_rl1

#Remove elements from a list

list_rl1[40]<-NULL
list_rl1[39]<-NULL
list_rl1[38]<-NULL
list_rl1[37]<-NULL
list_rl1[36]<-NULL
list_rl1[35]<-NULL
list_rl1[34]<-NULL
list_rl1[33]<-NULL
list_rl1[32]<-NULL
list_rl1[31]<-NULL
list_rl1[30]<-NULL
list_rl1[29]<-NULL
list_rl1[28]<-NULL
list_rl1[27]<-NULL
list_rl1[26]<-NULL
list_rl1[25]<-NULL
list_rl1[24]<-NULL
list_rl1[23]<-NULL
list_rl1[22]<-NULL
list_rl1[21]<-NULL
list_rl1[20]<-NULL
list_rl1[19]<-NULL
list_rl1[18]<-NULL
list_rl1[17]<-NULL
list_rl1[16]<-NULL
list_rl1[15]<-NULL
list_rl1[14]<-NULL
list_rl1[13]<-NULL
list_rl1[12]<-NULL
list_rl1[11]<-NULL
list_rl1[10]<-NULL
list_rl1[9]<-NULL
list_rl1[8]<-NULL
list_rl1[7]<-NULL
list_rl1[6]<-NULL
list_rl1[4]<-NULL


#  Dataframe: For this machine
list_rl1$Data <- RL1
summary(list_rl1)


#challenge: How do you access the first timestamp in the Unknown hours?
list_rl1$UnknownHours[1]
str(list_rl1)
list_rl1[[4]][1]

# Subsetting a list
list_rl1[1]        # --> $Machine: "RL1"
list_rl1[1:3]      # --> $Machine: "RL1"  $Stats: 0.8492262 0.9516976 0.9950000 $LowThreshold: TRUE
list_rl1[c(1,4)]   # --> $Machine: "RL1"  UnknownHours: "2016-09-01 00:00:00 CEST" "2016-09-01 01:00:00 CEST" . . .
list_rl1[c("Machine","Stats")]      # --> $Machine: "RL1"  $Stats: 0.8492262 0.9516976 0.9950000 


#  Plot: For all machines
#install.packages("ggplot2")
library(ggplot2)

p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine), size=1.2)+
  facet_grid(Machine~.) +
  geom_hline(yintercept=0.90)

rl1_plot <- p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine), size=1.2)+
  facet_grid(Machine~.) +
  geom_hline(yintercept=0.90,
             colour="Gray", size=1.2, linetype=3)

list_rl1$Plot <- rl1_plot
list_rl1
str(list_rl1)
