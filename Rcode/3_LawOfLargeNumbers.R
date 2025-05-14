#Law of large numbers

#normal distribution
myn=10
maxPower = 8

for(exponente in seq(1,maxPower)){
  asExpected = 0
  numbers = myn**exponente
  for(i in rnorm(numbers, 0, 1)) {
    if ((i> -1) & (i<1)){
        asExpected=asExpected + 1
      }
  }
  print(asExpected/numbers)
}


#toss of a coin
for(exponente in seq(1,maxPower)){
  asExpected = 0
  sample_size = myn**exponente
  for(toss in rnorm(sample_size, 0, 1)){
    if(toss<0){
      asExpected = asExpected+1
    } else if (toss == 0){
      sample_size = sample_size-1
    }
  }
  print(asExpected/sample_size)
}
