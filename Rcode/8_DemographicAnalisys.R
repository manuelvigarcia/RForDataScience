#Importing Data into RStudio

#Selecting file manually

stats<-read.csv(file.choose())
rm(stats)

getwd()
setwd("C:/D/GitRepos/RLanguage/RForDataScience_Data/Section 5 - Data Frames")

# get the file directly
stats<-read.csv("C:/D/GitRepos/RLanguage/RForDataScience_Data/Section 5 - Data Frames/S5-Demographic-Data.csv")


#Analysing dataframe

nrow(stats) # prints 195
ncol(stats) # prints 5
head(stats)
tail(stats, n=15)
str(stats) #insight statistics in the dataframe
summary(stats)  #Summary data for the dataframe


#Using the $
#Accessing the birth rate for Angola (3rd country)
stats[3,3]
stats[3, "Birth.rate"]

stats$Birth.rate # this refers to the whole 3rd column it is the same as
stats[,"Birth.rate"]

str(stats)
income_levels <- c("High income", "Low income", "Lower middle income", "Upper middle income")
income_levels
levels(stats$Income.Group) <- income_levels
str(stats)

# Dataframe basic operations
#subsetting
stats[1:10,]
stats[3:9,]
stats[c(4,100),]
stats[1,]
stats[,1] # -> vector. need to use drop=F
stats[,1,drop=F]

#arithmetic operations with columns
stats$Birth.rate * stats$Internet.users # -> vector with the products
stats$Birth.rate + stats$Internet.users # -> vector with the sums

#Add column to a df
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
stats$xyz <- 1:5 # adds a colum recicling 1-5 until the 195 is filled.
#Let's remove those fake columns
stats$MyCalc <- NULL
stats$xyz <- NULL


#Filtering data frames ---------------------------------
head(stats)
#Countries with less than 2% internet users
stats$Internet.users < 2  # prints a vector of logical result: TRUE if the condition is met.
#Convert it to a variable
afilter <- stats$Internet.users < 2
#use the variable to select only the rows that meet the condition
stats[afilter,]
#filter by that condition directly
stats[stats$Internet.users < 2,]

#Countries with more than 40 bitth rate
stats[stats$Birth.rate > 40,]

#Combine both conditions
stats[stats$Birth.rate>40 & stats$Internet.users < 2,]

#See which countries have high income
stats[stats$Income.Group == "High income",]

#Display all information about Malta
stats[stats$Country.Name == "Malta",]

