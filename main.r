

setClass("warehouse", slots=list(s="numeric", S="numeric",coords="list"))
# s = lower bound of stock before restocking
# S = starting supply and amount to restock to

setClass ("customer", slots=list(xcoord="numeric", ycoord="numeric", demand="numeric"))


primaryW = new("warehouse",s=300,S=1000)


generateMap=function(){
plot(NULL, xlim=c(0,100),ylim=c(0,100))
}


generateCustomers=function(){
  customerAmount= rnorm(1,100,100)
  customerList = c()
  for(i in 1:customerAmount){
    newCust = new("customer", xcoord=runif(1,0,100), ycoord=runif(1,0,100), demand=rpois(1,1))
    customerList = c(customerList, newCust)
  }
}


generateCustomers()
generateMap()