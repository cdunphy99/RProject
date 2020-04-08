generateCustomers=function(){
  customerAmount= rnorm(1,100,100)
  customerList = c()
  for(i in 1:customerAmount){ # generates customers and adds it to a vector of customer objects
    newCust = new("customer", xcoord=runif(1,0,100), ycoord=runif(1,0,100), demand=rpois(1,1))
    customerList = c(customerList, newCust)
  }
  return (customerList)
}


plotCustomers=function(toPlot){
  pdf("dailyCustomerMaps/hello.pdf")
  plot(NULL, xlim=c(0,100),ylim=c(0,100))

  for (i in 1:length(toPlot)){  # iterates over the customer vector and plots their locations
    points(toPlot[[i]]@xcoord,toPlot[[i]]@ycoord)
  }
}


getCustomers=function(primaryW){ # returns list of customers and plots them on the map
  customerList=generateCustomers()
  plotCustomers(customerList)
  points(primaryW@xcoord,primaryW@ycoord, pch=24, col="red", bg="blue")
  return(customerList)
}