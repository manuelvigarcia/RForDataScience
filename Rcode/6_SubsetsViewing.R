
#using data from Matrices


matplot(t(Salary/MinutesPlayed), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.001, legend=Players, col=c(1:4,6), pch=15:18, horiz=F)

#First three players
Data <- MinutesPlayed[1:3,]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset:0.01, legend=Players[1:3], col=c(1:4,6), pch=15:18, horiz=F)


#Just the one top player
Data <- MinutesPlayed[1,]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset:0.01, legend=Players[1], col=c(1:4,6), pch=15:18, horiz=F)
#This plots only one column, 10 series with only a point each.
#Making the minutes played a matrix again
Data <- MinutesPlayed[1,, drop=F] #This way, dimensions are not dropped
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset:0.01, legend=Players[1], col=c(1:4,6), pch=15:18, horiz=F)

#make a first function.
#Fixed code
myplot <- function(){
  Data <- MinutesPlayed[2:3,, drop=F] #This way, dimensions are not dropped
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset:0.01, legend=Players[2:3], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot()

#Add parameters
myplot <- function(rows){
  Data <- MinutesPlayed[rows,, drop=F] #This way, dimensions are not dropped
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset:0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(1:5)
myplot(1:10)

#change the data visualized
myplot <- function(data, rows){
  Data <- data[rows,, drop=F] #This way, dimensions are not dropped
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset:0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(Salary, 1:10)
myplot(Salary, 1:2)
myplot(MinutesPlayed/Games, 3)

#Default values
myplot <- function(data, rows=1:10){
  Data <- data[rows,, drop=F] #This way, dimensions are not dropped
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset:0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(Salary)
