#Include other files
source ("header.R") #contains definitions of classes
source("customers.R") #contains relevant functions to get customers
source("deliveries.R") #contains relevant classes to assign deliveries
source("Time.R")
source("Warehouses.R")



main=function(daysToSimulate,checkpointsinDay,warehouseList){
#Set inital company checkpoint data
  initialCheckpoint=new("checkpointData", warehouses=warehouseList, day=0, checkpoint=0, netProfit=0, incomingOrder=0)


#Simulate days using for loop appending new checkpoint data to checkpoint list
  checkpointList=list(initialCheckpoint)

#for loop for days
  for(i in 1:daysToSimulate){
    count=1
    
    #while loop for checkpoints in each day
    while(count<=checkpointsinDay){
      newCheckpoint=createCheckpoint(checkpointList,checkpointsinDay)
      checkpointList = c(checkpointList, newCheckpoint)
      count=count+1
    }
  }

  print("summary")
  for(i in 1:length(checkpointList)){
    print("day")
    print(checkpointList[[i]]@day)
    print("net profit")
    print(checkpointList[[i]]@netProfit)
  }

  print("warehouse stocks")
  for(i in 1:length(tail(checkpointList,n=1)[[1]]@warehouses)){
    print(tail(checkpointList,n=1)[[1]]@warehouses[[i]]@stock)
  }

  return(checkpointList)
  
}

#creates data to update checkpoint list
createCheckpoint=function(checkpointList,checkpointsinDay){
  print("new checkpoint")
  #create new checkpoint
  newCheckpoint= new("checkpointData", warehouses=tail(checkpointList,n=1)[[1]]@warehouses,incomingOrder=tail(checkpointList,n=1)[[1]]@incomingOrder)

  print("update time")
  #update day and checkpoint
  newCheckpoint=updateTime(newCheckpoint,checkpointList,checkpointsinDay)

  print("restock warehouse")
  newCheckpoint=restockWarehouse(newCheckpoint) #function will only run at the first checkpoint of each day to restock from incoming order and refill secondary warehouses

  print("customer list")
  #generates customers
  customerList=getCustomers(newCheckpoint)

  print("deliveries")
  #links customers to warehouses and gets cost
  newCheckpoint=assignDeliveries(customerList,newCheckpoint)

  print(paste("warehouse stock ",newCheckpoint@warehouses[[1]]@stock))

  print("process orders")
  newCheckpoint=processOrders(checkpointList, newCheckpoint) #Function that will process daily order adding to profit

  print("deliver orders")
  newCheckpoint=deliverOrders(newCheckpoint) #function that will pay money for shipping reducing profit

  newCheckpoint=orderRestock(newCheckpoint) #function will only run at the first checkpoint of each day to order more stock from manufacturer

return(newCheckpoint)
}

