library(caret)
library(kknn)
rp = read.csv("apple.csv")

Train <- createDataPartition(y= rp$Number.Of.Trades,p=0.25,list=FALSE)      

test1 <- rp[Train,]
train1 <- rp[-Train,]
dim(train1)

m1 <- kknn(Polarity~.,train1,test1,k=13)
summary(m1)
fit <- fitted(m1)
table(test1$Polarity, fit)
