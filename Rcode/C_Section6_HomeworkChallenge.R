library(ggplot2)
#load data
stats<-read.csv("C:/D/GitRepos/RLanguage/RForDataScience_Data/Section 6 - Advanced Visualization With GGPlot2/S6-Homework-Data.csv")
head(stats)
tail(stats)
stats$Studio <- factor(stats$Studio)
str(stats)
stats$Genre <- factor(stats$Genre)
stats$Day.of.Week <- factor(stats$Day.of.Week)

summary(stats)

#day of the week profit
ggplot(data=stats, aes(x=Day.of.Week)) + geom_bar()



ggplot(data=stats, aes(x=Genre, y=Gross...US, colour=Studio, size=Budget...mill.))+
  geom_line() +
  geom_point() +
  geom_boxplot()

stats[stats$Profit.==max(stats$Profit.),]

#Filter displayed Studios and Genres
studios<- c("Buena Vista Studios", "Fox", "Paramount Pictures","Sony","Universal","WB")
genres<- c("action", "adventure", "animation","comedy","drama")
movies <- subset(stats, Studio %in% studios & Genre %in% genres)
movies$Genre <- factor(movies$Genre)
movies$Studio <- factor(movies$Studio)

g <- ggplot(data=movies, aes(x=Genre, y=Gross...US, colour=Studio, size=Budget...mill.))
g +  geom_jitter() + geom_point()

f <- ggplot(data=movies, aes(x=Genre,y=Gross...US))
f + geom_point()  # nope
f + geom_boxplot()  # getting there

f + geom_jitter() + geom_boxplot()
#add transparency and hide outliers
f + geom_jitter() + geom_boxplot(alpha=0.7, outlier.colour = NA)
#Add colour and size to the points
f + geom_jitter(aes(colour=Studio, size=Budget...mill.)) + geom_boxplot(alpha=0.7, outlier.colour = NA)
          
visual <- f + geom_jitter(aes(colour=Studio, size=Budget...mill.)) + geom_boxplot(alpha=0.7, outlier.colour = NA)

visual + ylab("Gross % US")
visual$labels$y <- "Gross % US"
visual$labels$size<-"Budget $M"

visual + 
  ggtitle("Domestic Gross % by Genre") + 
  theme(
    text=element_text(family="Comic Sans MS"),
    axis.title.x=element_text(colour="Blue", size=30),
    axis.title.y=element_text(colour="Blue", size=30),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),
    plot.title = element_text(colour="Black", size=40),
    legend.title = element_text(size=20)
  )
