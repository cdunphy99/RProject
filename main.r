source("customers.R")

setClass("warehouse", slots=list(s="numeric", S="numeric",xcoord="numeric",ycoord="numeric"))
# s = lower bound of stock before restocking
# S = starting supply and amount to restock to

setClass ("customer", slots=list(xcoord="numeric", ycoord="numeric", demand="numeric"))

setClass("delivery", slots=list(client="customer", facility="warehouse", distance="numeric"))


euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2)) # euclidean distance formula function


assignDeliveries=function(customerList, primaryW){
  deliveryList=c()
  for (i in 1:length(customerList)){
    order=new("delivery", client=customerList[[i]], facility=primaryW, distance= euc.dist(rbind(customerList[[i]]@xcoord,customerList[[i]]@ycoord),rbind(primaryW@xcoord,primaryW@ycoord)))
    deliveryList=c(deliveryList,order)
  }
  return(deliveryList)
}


main=function(){
  primaryW = new("warehouse",s=300,S=1000, xcoord=50, ycoord=50)
  customerList=getCustomers(primaryW)
  deliveryList=assignDeliveries(customerList,primaryW)
}




main()












