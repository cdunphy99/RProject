source ("Simulation.R")
source ("WarehouseList.R")

daysToSimulate = 365 #total number of days to simulate
checkpointsinDay=3 #times per day data is processed


  result=main(daysToSimulate, checkpointsinDay,warehouseList3)

  matResult=matrix(c(result[[1]]@day,result[[1]]@checkpoint,result[[1]]@netProfit), nrow=1,ncol=3)
  colnames(matResult)=c("Day","Checkpoint", "Net Profit")


  for(j in (2:(length(result)))){
    netProfit=result[[j]]@netProfit
    day=result[[j]]@day
    checkpoint=result[[j]]@checkpoint
    matResult=rbind(matResult,c(day, checkpoint, netProfit))
  }

  plot(matResult[,3],type='l', xlab="Checkpoint", ylab="Net Profit", main="Warehouse List 3",
  )

  finalNet=trunc ((tail(result,1)[[1]]@netProfit)*10^2) /(10^2)
  
  legend("bottomright", legend=c(paste("Net Profit $",finalNet)))
  

 

