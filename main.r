source ("Simulation.R")



#make type warehouse and store in list 
  primaryW = new("warehouse", s=100, S=2000, xcoord=75, ycoord=100,stock=2000,monthlyRent=2500)
  secondW= new("warehouse", s=200, S=500, xcoord=130,ycoord=50, stock=500,monthlyRent=2500)
  thirdW= new("warehouse", s=500, S=500, xcoord=100, ycoord=100, stock=500,monthlyRent=2500)
  warehouseList=list(primaryW, secondW, thirdW)

daysToSimulate = 365 #total number of days to simulate
checkpointsinDay=3 #times per day data is processed

result=main(daysToSimulate, checkpointsinDay,warehouseList)


matResult=matrix(c(result[[1]]@day,result[[1]]@checkpoint,result[[1]]@netProfit), nrow=1,ncol=3)
colnames(matResult)=c("Day","Checkpoint", "Net Profit")


for(i in 2:length(result)){
  netProfit=result[[i]]@netProfit
  day=result[[i]]@day
  checkpoint=result[[i]]@checkpoint
  matResult=rbind(matResult,c(day, checkpoint, netProfit))
}

plot(matResult[,3],type='l', xlab="Checkpoint", ylab="Net Profit")


