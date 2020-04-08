source("customers.R")
source("deliveries.R")

setClass("warehouse", slots=list(s="numeric", S="numeric",xcoord="numeric",ycoord="numeric"))
# s = lower bound of stock before restocking
# S = starting supply and amount to restock to

setClass ("customer", slots=list(xcoord="numeric", ycoord="numeric", demand="numeric"))

setClass("delivery", slots=list(client="customer", facility="warehouse", distance="numeric"))

dir.create("dailyCustomerMaps")

main=function(){
  primaryW = new("warehouse",s=300,S=1000, xcoord=50, ycoord=50)
  customerList=getCustomers(primaryW)
  deliveryList=assignDeliveries(customerList,primaryW)
}

main()