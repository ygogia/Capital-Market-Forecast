install.packages("e1071")
install.packages("ggplot2")
install.packages("caret")
library(e1071)
library(ggplot2)
library(caret)
dataset = read.csv("infy.csv")
index <- 1:nrow(dataset)
testindex <- sample(index, trunc(length(index)*30/100))
testset <- dataset[testindex,]
trainset <- dataset[-testindex,]
model <- svm(Polarity~., data = trainset)
prediction <- predict(model, testset[,-9])
summary(model)
tab <- table(pred = prediction, true = testset[,9])
tab


