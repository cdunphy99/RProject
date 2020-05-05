setClass("warehouse", slots=list(s="numeric",S="numeric",xcoord="numeric",ycoord="numeric",stock="numeric", monthlyRent="numeric"))
# s = lower bound of stock before restocking
# S = starting supply and amount to restock to

setClass ("customer", slots=list(xcoord="numeric", ycoord="numeric", demand="numeric"))

setClass("delivery", slots=list(client="customer", facility="warehouse", distance="numeric"))

# Create a directory to store customer map information
#dir.create("dailyData")

setClass("checkpointData", slots=list(day="numeric", checkpoint="numeric", netProfit="numeric", deliveries="list", warehouses="list",incomingOrder="numeric"))