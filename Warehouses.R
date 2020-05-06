processOrders= function(checkpointList, newCheckpoint){
  productPrice=60
  revenue=0
  for(i in 1:length(newCheckpoint@deliveries)){
    revenue=newCheckpoint@deliveries[[i]]@client@demand*productPrice+revenue
  }
  totalProfit=tail(checkpointList,n=1)[[1]]@netProfit+revenue
  newCheckpoint@netProfit=totalProfit
  return(newCheckpoint)
}



deliverOrders=function(newCheckpoint){
  mileCost=0.2
  productCost=1

  deliveryCost=0
  for(i in 1:length(newCheckpoint@deliveries)){
    deliveryCost=(newCheckpoint@deliveries[[i]]@distance*mileCost+newCheckpoint@deliveries[[i]]@client@demand*productCost)+deliveryCost
  }
  print("delivery cost")
  newCheckpoint@netProfit=newCheckpoint@netProfit-deliveryCost
  return(newCheckpoint)
}


restockWarehouse=function(newCheckpoint){

  #update stocks of warehouses if start of day
  if(newCheckpoint@checkpoint==1){
    
    #update stock from manufacturer for primary warehouse
    if(newCheckpoint@incomingOrder!=0){
      newCheckpoint@warehouses[[1]]@stock=newCheckpoint@warehouses[[1]]@stock+newCheckpoint@incomingOrder
      newCheckpoint@incomingOrder=0
      print(paste("warehouse has been restocked day",newCheckpoint@day))
    }
    

    if(length(newCheckpoint@warehouses)!=1){
      #update stock of secondary warehouse by importing form primary warehouse
      for(i in 2:(length(newCheckpoint@warehouses))){
        if(newCheckpoint@warehouses[[i]]@stock<newCheckpoint@warehouses[[i]]@s){
          restockAmount=newCheckpoint@warehouses[[i]]@S-newCheckpoint@warehouses[[i]]@stock
          if (restockAmount<newCheckpoint@warehouses[[1]]@stock){
            restockCost=0.5
            newCheckpoint@warehouses[[i]]@stock=restockAmount+newCheckpoint@warehouses[[i]]@stock
            newCheckpoint@warehouses[[1]]@stock=newCheckpoint@warehouses[[1]]@stock-restockAmount
            newCheckpoint@netProfit=newCheckpoint@netProfit-restockAmount*restockCost
          }
        }
      }
    }
  }
  return (newCheckpoint)
}

orderRestock=function(newCheckpoint){
  #at then end of the first checpoint so beginning of the day order from manufacturer if needed
  if(newCheckpoint@checkpoint==1 && newCheckpoint@warehouses[[1]]@stock < newCheckpoint@warehouses[[1]]@s && newCheckpoint@incomingOrder==0){
    #order stock from manufacturer for primary warehouse
    orderPrice=50 #price per unit to order
    print(paste("newCheckpoint stock incoming order: ", newCheckpoint@incomingOrder!=0))
    print(paste("Ordering for Primary day:",newCheckpoint@day))
    newCheckpoint@incomingOrder=newCheckpoint@warehouses[[1]]@S-newCheckpoint@warehouses[[1]]@stock
    print(paste("Amount spent on restock",newCheckpoint@incomingOrder*orderPrice) )
    newCheckpoint@netProfit=newCheckpoint@netProfit-(newCheckpoint@incomingOrder*orderPrice)
  }
  return(newCheckpoint)
}