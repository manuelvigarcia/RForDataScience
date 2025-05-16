library(ggplot2)
#load data
stats<-read.csv("C:/D/GitRepos/RLanguage/RForDataScience_Data/Section 6 - Advanced Visualization With GGPlot2/S6-Movie-Ratings.csv")
head(stats)
str(stats)
columnNames <- colnames(stats)
columnNames[1] <- "Title"
columnNames[3] <- "Critic.rating"
columnNames[4] <- "Audience.rating"
columnNames[5] <- "Budget"
columnNames[6] <- "Year"
colnames(stats) <- columnNames
#Audience rating vs critic rating
qplot(data=stats, x=Critic.rating, y=Audience.rating, size=I(4))

#Audience rating vs critic rating, colored by budget
stats[stats$Critic.rating==0,]
budgetLevel <-stats[,"Budget"]
budgetlevelN <- budgetLevel * 1/30
stats$Budget.Level <- budgetlevelN
qplot(data=stats, x=Critic.rating, y=Audience.rating, size=I(4), colour=Budget.Level)

#Audience rating vs budget
qplot(data=stats, x=Audience.rating, y=Budget, size=I(4))

#Critic rating vs budget
qplot(data=stats, x=Critic.rating, y=Budget, size=I(4))

str(stats)
summary(stats)
factor(stats$Year)
stats$Year <- factor(stats$Year)
summary(stats)
factor(stats$Genre)
stats$Genre <- factor(stats$Genre)
summary(stats)

#-------------------------Aesthetics
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating))  #blank graph area

#add geometry
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating))+
  geom_point()

#add color
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre))+
  geom_point()

#add size
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre, size=Genre))+
  geom_point() #warning: Using size for a discrete variable is not advised

#add size in a better way
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre, size=Budget))+
  geom_point() 

#Plotting with layers (added to an object)
ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre, size=Budget))+
  geom_line() 

ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre, size=Budget))+
  geom_line() +
  geom_point() +
  geom_boxplot()

#Overriding Aesthetics
q <- ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre, size=Budget))
q+geom_point() # grapth as we had it earlier

q + geom_point(aes(size=Critic.rating)) # dots are bigger for higher critic ratings

q + geom_point(aes(colour=Budget))

#overriding coordinates
q + geom_point(aes(x=Budget))+xlab("Budget in millions")

q + geom_line(size=1) + geom_point()

#mapping vs. Setting

r <- ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating))

r + geom_point()

#Add colour mapping -> map values of the column to different colours
r + geom_point(aes(colour=Genre))

#Add colour with setting -> set a colour for the whole
r + geom_point(colour="DarkGreen")

r + geom_point(aes(size=Budget))


#Histograms and Density Charts
s<-ggplot(data=stats, aes(x=Budget))
s+geom_histogram(binwidth = 10)

#add colour
s+geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#density
s+geom_density(aes(fill=Genre))
s+geom_density(aes(fill=Genre), position="stack")

#Starting layer tips
t <- ggplot(data=stats, aes(x=Audience.rating))
t + geom_histogram(binwidth = 10, fill="White", colour="Blue")

#Same thing in another way
t <- ggplot(data=stats)
t + geom_histogram(binwidth = 10, aes(x=Audience.rating), fill="White", colour="Blue")
t + geom_histogram(binwidth = 10, aes(x=Critic.rating), fill="White", colour="Blue")

#Start with an empty plot, then add data, aesthetics, etc
t<-ggplot()

#--------------------------------------- statistical transfromations
u<- ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, colour=Genre))
u + geom_point() + geom_smooth() #not good with so much shadow
u + geom_point() + geom_smooth(fill=NA)


#boxplots
u <- ggplot(data=stats, aes(x=Genre, y=Audience.rating, colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
u + geom_boxplot(size=1.2) + geom_jitter()
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

# Same for critic rating
v <- ggplot(data=stats, aes(x=Genre, y=Critic.rating, colour=Genre))
v+geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)


#-----------------------------Using facets
v <- ggplot(data=stats, aes(x=Budget))
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")+
  facet_grid(Genre~.)
#independent scale
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")+
  facet_grid(Genre~., scales="free")

#with scatter plots:
w<-ggplot(data=stats, aes(x=Critic.rating,y=Audience.rating, colour=Genre))
w + geom_point(size=3)
#facets
w + geom_point(size=3)+facet_grid(Genre~.)
w + geom_point(size=3)+facet_grid(Year~.)
w + geom_point(size=3)+facet_grid(Genre~Year)
w + geom_point(size=3)+geom_smooth()+facet_grid(Genre~Year)
w + geom_point(size=Budget)+geom_smooth()+facet_grid(Genre~Year)

#-----------------------------------------coordinates
m <- ggplot(data=stats, aes(x=Critic.rating, y=Audience.rating, size=Budget, colour=Genre))
m + geom_point()
#zoom into the higher budget
m + geom_point() + xlim(50,100) + ylim(50,100) #it does cut data, not just make bigger
#example of leaving data out:
n<-ggplot(data=stats,aes(x=Budget))
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") + ylim(0,50)

#zoom instead
n + geom_histogram(binwidth=10, aes(fill=Genre),colour="Black") + coord_cartesian(ylim=c(0,50))

#Improving the multi plot
w + geom_point(size=Budget)+geom_smooth()+facet_grid(Genre~Year) + coord_cartesian(ylim=c(0,100))


#---------------------theme
#use them to make all your project charts look alike
o<-ggplot(data=stats, aes(x=Budget))
h<-o+geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#axes label
h + xlab("Money Axis")+ylab("Number of Movies")
#Change other elements in the axes with a theme
h + xlab("Money Axis")+ylab("Number of Movies")+
  theme(axis.title.x=element_text(colour="DarkGreen", size=30), #axis label colour and size
        axis.title.y=element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),                    #Axis scale size
        axis.text.y = element_text(size=20))

#leyend formatting
h + xlab("Money Axis")+ylab("Number of Movies")+
  theme(axis.title.x=element_text(colour="DarkGreen", size=30), #axis label colour and size
        axis.title.y=element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),                    #Axis scale size
        axis.text.y = element_text(size=20),
        legend.title=element_text(size=30),                     #legend
        legend.text=element_text(size=20),
        legend.position = "inside",
        legend.position.inside=c(1,1),
        legend.justification=c(1,1),
        plot.title=element_text(colour="DarkBlue", size=40, family="Courier")
        )
