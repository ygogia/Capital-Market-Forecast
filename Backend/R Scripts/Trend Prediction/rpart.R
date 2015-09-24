library(caret)
library(rpart)
rp = read.csv("infy.csv")

iTrain <- createDataPartition(y= rp$Number.Of.Trades,p=0.25,list=FALSE)      

test <- rp[iTrain,]
train <- rp[-iTrain,]
dim(train)

str(train)

dtree= rpart(Open.Price~. ,data=train,control=rpart.control(10))

printcp(dtree)
plotcp(dtree)
summary(dtree)



str(dtree)
plot(dtree)
text(dtree)
attributes(dtree)
dtree$variable.importance


predictDT = predict(dtree, test, type=c("vector"))
predictDT

table(predictDT, test$Open.Price)

