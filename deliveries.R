
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2)) # euclidean distance formula function

assignDeliveries=function(customerList, primaryW){
  deliveryList=c()
  for (i in 1:length(customerList)){
    custDist=euc.dist(rbind(customerList[[i]]@xcoord,customerList[[i]]@ycoord),rbind(primaryW@xcoord,primaryW@ycoord))

    order=new("delivery", client=customerList[[i]], facility=primaryW, distance=custDist )
    
    deliveryList=c(deliveryList,order)
  }
  return(deliveryList)
}