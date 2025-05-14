#Homework Financial Statement

#Data
revenue  <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)
#Solution

profitPerMonth = revenue - expenses
print("profit for each month: ")
print(profitPerMonth)
profitAfterTax = (revenue * 0.7) - expenses
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
