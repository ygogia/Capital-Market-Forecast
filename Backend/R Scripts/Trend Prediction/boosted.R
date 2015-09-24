library(caret)
library(gbm)
library(Metrics)
rp = read.csv("infy.csv")

iTrain <- createDataPartition(y= rp$Number.Of.Trades,p=0.25,list=FALSE)      

test <- rp[iTrain,]
train <- rp[-iTrain,]
dim(train)

xtrain <- train[,3:ncol(train)]
ytrain = train[,2]
xtest <-  test[,3:ncol(train)]
ytest =  test[,2]

dim(xtrain)
dim(ytrain)
GBM_NTREES = 400
GBM_SHRINKAGE = 0.05
GBM_DEPTH = 4
GBM_MINOBS = 30

g<-gbm.fit(x=xtrain,y=ytrain,distribution = "gaussian",n.trees = GBM_NTREES,shrinkage = GBM_SHRINKAGE,interaction.depth = GBM_DEPTH,n.minobsinnode = GBM_MINOBS)
tP1 <- predict.gbm(object = g,newdata = xtrain,GBM_NTREES)
hP1 <- predict.gbm(object = g,newdata = xtest,GBM_NTREES)

rmse(ytrain,tP1)
rmse(ytest,hP1)
rmse(ytest,mean(ytrain))

summary(g)
