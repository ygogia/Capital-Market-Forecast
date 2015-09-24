library(randomForest)

rF = read.csv("infy.csv")
str(rF)

rF1 = randomForest(Price.Date~.,data= rF, mtry=4, ntree=400)
class(rm)
class(rF1)
str(rF1)

rF1$confusion
rF1$importance
