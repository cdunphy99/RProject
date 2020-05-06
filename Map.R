makeMap=function(day, checkpoint){
  plot( 0,0,type='n',
      xlab = "South", ylab = "West",
      xlim=c(0,200),
      ylim=c(0,180),)

#MA rectangle
segments(x0=10, y0=60, x1 =120 , y1 = 60,
         col = "black", lty = par("lty"), lwd = par("lwd"))

segments(x0=10, y0=60, x1 =10 , y1 = 150 ,
        col = "black", lty = par("lty"), lwd = par("lwd"))
segments(x0=10, y0=150, x1 =120 , y1 = 150 ,
         col = "black", lty = par("lty"), lwd = par("lwd"))
segments(x0=120, y0=150, x1 =120 , y1 = 90,
         col = "black", lty = par("lty"), lwd = par("lwd"))
# upper parallel
segments(x0=120, y0=90, x1 =150 , y1 = 90,
         col = "black", lty = par("lty"), lwd = par("lwd"))
# lower parallel
segments(x0=120, y0=60, x1 =120 , y1 = 10,
        col = "black", lty = par("lty"), lwd = par("lwd"))
segments(x0=150, y0=90, x1 =150 , y1 = 10,
        col = "black", lty = par("lty"), lwd = par("lwd"))

segments(x0=120, y0=10, x1=150, y1=10)

segments(x0=30, y0=150, x1=30, y1=60, lty="dashed")

segments(x0=30, y0=120, x1=60, y1=120, lty="dashed")

segments(x0=30, y0=90, x1=60, y1=90, lty="dashed")

segments(x0=60, y0=150, x1=60, y1=60, lty="dashed")

segments(x0=90, y0=150, x1=90, y1=60, lty="dashed")

segments(x0=120, y0=90, x1=120, y1=60, lty="dashed")

title(main=paste("Day: ", day,"  Checkpoint: ",checkpoint))

legend(120,180,legend=c("Customer", "Primary Warehouse", "Secondary Warehouse"),
  col = c("black","red","red"),
  pt.bg=c(NULL,"green","blue"),
  pch = c(20,24,24), 
  bty = "n", 
  pt.cex = 1, 
  cex = 1, 
  text.col = "black", 
  horiz = F , 
  inset = c(0.1, 0.1))
}