#Homework Financial Statement

#Data
revenue  <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)
#Solution

profitPerMonth = revenue - expenses
print("profit for each month: ")
print(profitPerMonth)
profitAfterTax = round(profitPerMonth * 0.7, digits=2)
print("profit after tax for each month: ")
print(profitAfterTax)
profitMargin = round(profitAfterTax / revenue, 2) * 100
print("profit margin for each month: ")
print(profitMargin)
meanProfitAfterTax = mean(profitAfterTax)
maxProfitAfterTax = max(profitAfterTax)
minProfitAfterTax = min(profitAfterTax)
thisMonth = 0
badMonths = c()
goodMonths = c()
maxMonth = ""
minMonth = ""
for(paf in profitAfterTax){
  thisMonth = thisMonth + 1
  currentMonth = month.name[thisMonth]
  print(currentMonth)
  if (paf == maxProfitAfterTax){
    maxMonth = currentMonth
  } else if (paf == minProfitAfterTax){
    minMonth = currentMonth
  }
  if (paf < meanProfitAfterTax){
    badMonths = c(badMonths, currentMonth)
  }
  else{
    goodMonths = c(goodMonths, currentMonth)
  }
}
print("Good Months: ")
print(goodMonths)
print ("Bad Months: ")
print(badMonths)
print("The best month: ")
print(maxMonth)
print("The worst month: ")
print(minMonth)

#The exercise actually wanted the results in vector form
vGoodMonths <- profitAfterTax > mean(profitAfterTax)
print("Good Months vector: ")
print(vGoodMonths)
vBadMonths <- !vGoodMonths
print("Bad Months vector: ")
print(vBadMonths)
vMaxMonth <- profitAfterTax == max(profitAfterTax)
print("Best Month vector: ")
print(vMaxMonth)
vMinMonth <- profitAfterTax == min(profitAfterTax)
print("Best Month vector: ")
print(vMinMonth)

#Presented in units of 1000 $
print("Revenue by month (x$1000):")
print(round(revenue/1000))
print("Expenses by month (x$1000):")
print(round(expenses/1000))
print("Profit by month (x$1000):")
print(round(profitPerMonth/1000))
print("Profit after tax by month (x$1000):")
print(round(profitAfterTax/1000))
print("Profit margin by month (x$1000):")
print(round(profitMargin/1000))


#As bonus, place it all in a matrix, easy to consult

yearResults <- rbind(
  round(revenue/1000),
  round(expenses/1000),
  round(profitPerMonth/1000),
  round(profitAfterTax/1000),
  profitMargin,
  vGoodMonths,
  vBadMonths,
  vMaxMonth,
  vMinMonth
)
print("The year financial analysis in matrix form:")
print(yearResults)
