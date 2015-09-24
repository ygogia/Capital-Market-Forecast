library(caret)
library(kknn)
rp = read.csv("infy.csv")


Train <- createDataPartition(y= rp$Volume,p=0.40,list=FALSE)      

train1 <- rp[-Train,]
dim(train1)


m1 <- kknn(Polarity~.,train1,test1,k=13)
prediction <- summary(m1)

result <- as.matrix(prediction)
result[1]

fit <- fitted(m1)
table(test1$Polarity, fit)

confusionMatrix(fit,test1$Polarity)
