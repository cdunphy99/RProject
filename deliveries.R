 
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2)) # euclidean distance formula function


#links each customer to closes warehouse and gets distance
assignDeliveries=function(customerList, newCheckpoint){
  deliveryList=c()
  for (i in 1:length(customerList)){
    isEmpty=TRUE
    for(j in 1:length(newCheckpoint@warehouses)){
      if(newCheckpoint@warehouses[[j]]@stock-customerList[[i]]@demand>=0){
      isEmpty=FALSE
      }
    }
    if (isEmpty==TRUE){
      break
    }
    
    custDist=c()
    for(j in 1:length(newCheckpoint@warehouses)){
      custDist=c(custDist, euc.dist(rbind(customerList[[i]]@xcoord,customerList[[i]]@ycoord),rbind(newCheckpoint@warehouses[[j]]@xcoord,newCheckpoint@warehouses[[j]]@ycoord)))
    }




    lowestKey = c(1:length(newCheckpoint@warehouses))
    
    for (j in 1:length(custDist)){
      for (k in 1:j){
        if(custDist[[j]]<custDist[[k]]){
          temp= custDist[j]
          custDist[j]=custDist[k]
          custDist[k]=temp

          temp= lowestKey[j]
          lowestKey[j]=lowestKey[k]
          lowestKey[k]=temp
        }
      }
    }


    key=1
    for(key in 1:length(lowestKey)){
      if(newCheckpoint@warehouses[[lowestKey[key]]]@stock-customerList[[i]]@demand>=0){
        newCheckpoint@warehouses[[lowestKey[key]]]@stock=newCheckpoint@warehouses[[lowestKey[key]]]@stock-customerList[[i]]@demand
        order=new("delivery", client=customerList[[i]], facility=newCheckpoint@warehouses[[lowestKey[key]]], distance=custDist[[key]])
        deliveryList=c(deliveryList,order)
        break
      }
    }
  }






  if(length(deliveryList)==0){ # runs if there are no more deliveries to be made because the warehouse ran out of stock
    nullCustomer=new("customer", demand=0)
    nullOrder=new("delivery", client=nullCustomer, facility=newCheckpoint@warehouses[[1]],distance=0)
    print("empty")
    deliveryList=c(nullOrder)
  }else{
      print("returning deliveries")
  }

  newCheckpoint@deliveries=deliveryList
  return(newCheckpoint)
}
