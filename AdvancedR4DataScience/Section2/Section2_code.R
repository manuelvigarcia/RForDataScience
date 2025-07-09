getwd()
setwd(paste0(getwd(),"/../Section2/Data"))
getwd()

#basic import: fin <- read.csv("Future-500-The-Dataset.csv")
fin <- read.csv("Future-500-The-Dataset.csv", na.strings=c(""))
fin

head(fin)
tail(fin)
str(fin)
summary(fin)

#Changing from non-factors to factors
factor(fin$ID)
fin$ID <- factor(fin$ID)
str(fin)
factor(fin$Name)
fin$Name <- factor(fin$Name)
fin$Industry <- factor(fin$Industry)
fin$State <- factor(fin$State)
fin$City <- factor(fin$City)
str(fin)
fin$Inception <- factor(fin$Inception)

#Factor variable trap
#First convert from character to number
a <- c("12", "13", "14", "12", "12")
a
typeof(a)
b <- as.numeric(a)
b
str(a)
str(b)
#From factor to numeric
z <- factor(a)
str(z)
y <- as.numeric(z)
typeof(y) #"double" as it should
y #wrong conversion, theese are the numerics of the categories identifiers

typeof(z)  #"Integer"

#First change it to characters, so it picks up the values, not the identifiers, then to numeric
x <- as.numeric(as.character(z))
x
typeof(x)


head(fin)
str(fin)
#convert profit to factor to convert it back to numbers
fin$Profit <- factor(fin$Profit)
summary(fin)
fin$Profit <- as.numeric(as.character(fin$Profit))
summary(fin)


#sub() and gsub()
fin$Expenses <- gsub(" Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
fin$Growth <- gsub("%","",fin$Growth)
str(fin)

#Convert from character to numeric
fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
str(fin)

#Locating missing datah
head(fin,24)
complete.cases(fin)
fin[!complete.cases(fin),]
# to pick up all rows, we updated the import to transform "" strings to NA
str(fin)

#filtering: to get the NA rows
#basic:
fin[fin$Revenue == 9746272,]   #aparece indicación de que hay filas con revenue NA
fin[which(fin$Revenue == 9746272),]
fin[fin$Employees == 45,]
fin[which(fin$Employees == 45),]

#find the rows with NA
fin[fin$Expenses == NA,]  #Not this way

fin[is.na(fin$Expenses),]
fin[is.na(fin$State),]
fin[is.na(fin$Industry),]
fin[is.na(fin$Inception),]
fin[is.na(fin$Employees),]
fin[is.na(fin$City),]
fin[is.na(fin$Revenue),]
fin[is.na(fin$Profit),]
fin[is.na(fin$Growth),]

#make a backup
fin_backup <- fin

#remove rows with missing Industry
fin[is.na(fin$Industry),]  #these are the ones
fin[!is.na(fin$Industry),]  #these are the rest, those to keep

fin <- fin[!is.na(fin$Industry),]
str(fin)
fin[!complete.cases(fin),] #Industry NAs are not in the NA list anymore

#resett the dataframe index
rownames(fin) <- 1:nrow(fin)
fin
#the same would be achieved by ditching the row names
rownames(fin) <- NULL

#Restore the data from other data. e.g. state from city
fin[!complete.cases(fin),]
fin[is.na(fin$State),]

fin[is.na(fin$State) & fin$City == "New York",]
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"
#check
fin[c(11,377),] #--> shows the corrected rows with "NY" in the State column
#Now California
fin[is.na(fin$State) & fin$City == "San Francisco",]
fin[is.na(fin$State) & fin$City == "San Francisco","State"] <- "CA"
fin[c(82,265),]
fin_backup2 <- fin
#Check that we do not have any more NA in the State column
fin[!complete.cases(fin),]

#Replace missing data with Median Imputation Method
median(fin[,"Employees"])  #Median employees of all companies: NA because we have one NA
median(fin[,"Employees"], na.rm=TRUE) #median for all those which are not NA
median_employee_retail <- median(fin[fin$Industry=="Retail", "Employees"], na.rm=TRUE) #Median for Retail with no NA
fin[is.na(fin$Employees) & fin$Industry=="Retail",]  #what we want to fix
fin[is.na(fin$Employees) & fin$Industry=="Retail","Employees"] <-median_employee_retail
#check
fin[3,]

median_employee_financial <- median(fin[fin$Industry=="Financial Services", "Employees"], na.rm=TRUE) #Median for Financial with no NA
fin[is.na(fin$Employees) & fin$Industry=="Financial Services", "Employees"] <- median_employee_financial
fin[330,]

fin[!complete.cases(fin),]

#Also median imputation method for missing growth
med_growth_const<- median(fin[fin$Industry=="Construction", "Growth"], na.rm=TRUE)
fin[is.na(fin$Growth) & fin$Industry=="Construction", "Growth"] <- med_growth_const
#Check
fin[8,]

#Use median imputation method for the missing revenue and expenses
fin[!complete.cases(fin),]
median_revenue_construction <- median(fin[fin$Industry=="Construction","Revenue"], na.rm=TRUE)
fin[is.na(fin$Revenue) & fin$Industry=="Construction", "Revenue"] <- median_revenue_construction
#check
fin[c(8,42),]

fin[!complete.cases(fin),]

#Same method for the missing Expenses, also in the Construction industry
median_expenses_construction <- median(fin[fin$Industry=="Construction","Expenses"], na.rm=TRUE)
#Extra filter to only overwrite NA Revenue where Profit is also NA.
fin[is.na(fin$Expenses)&fin$Industry == "Construction" & is.na(fin$Profit), "Expenses"] <- median_expenses_construction
#check
fin[c(8,42),]


#get values derived from other data
#Revenue - Expenses = Profit
#Revenue - Profit = Expenses
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
#check
fin[c(8,42),]

fin[!complete.cases(fin),]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]
#check
fin[c(15),]

fin[!complete.cases(fin),] #This one we let go because that datum is irrelevant for our analysis.

#install.packages("ggplot2")
library(ggplot2)

#A scatterplot classified by industry showing revenue, expenses, profit
p <- ggplot(data=fin)

p + geom_point(aes(x=Revenue, y=Expenses,
                   colour=Industry, size = Profit))

#A scatterplot that includes industry trends for the expenses~revenue relationship
d <- ggplot(data=fin, aes(x=Revenue, y=Expenses,
                          colour=Industry))

d + geom_point() +
  geom_smooth(fill=NA, size = 1.2)

#BoxPlots showing growth by industry
f <- ggplot(data=fin, aes(x=Industry, y=Growth, colour = Industry))
f+geom_boxplot(size=1)

#Extra
f + geom_jitter() +
  geom_boxplot(size = 1, alpha = 0.6, outlier.color = "red")
