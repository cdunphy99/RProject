#Function that updates the day and checkpoint number
updateTime= function(newCheckpoint,checkpointList,checkpointsinDay){
  if (tail(checkpointList,n=1)[[1]]@day==0){
    newCheckpoint@day=1
    newCheckpoint@checkpoint=1
    return(newCheckpoint)
  }

  if (tail(checkpointList,n=1)[[1]]@checkpoint<checkpointsinDay){
    newCheckpoint@day=tail(checkpointList,n=1)[[1]]@day
    newCheckpoint@checkpoint=tail(checkpointList,n=1)[[1]]@checkpoint+1
  }
  else{
    newCheckpoint@checkpoint=1
    newCheckpoint@day=tail(checkpointList,n=1)[[1]]@day+1
  }

if(newCheckpoint@day %% 30 ==0){
  for(i in 1:length(newCheckpoint@warehouses)){
    newCheckpoint@netProfit=newCheckpoint@netProfit-newCheckpoint@warehouses[[i]]@monthlyRent
  }
}
  return(newCheckpoint)
}