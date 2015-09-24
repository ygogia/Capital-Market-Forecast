ProjDirPath = "C:\\xampp\\htdocs\\Testing\\"



#Loading Necessary Packages for Prediction
library(caret)
library(kknn)


#Loading Stock data CSV File saved as table.csv for stock ticker entered by user
DataPath = paste0(ProjDirPath,"table.csv")
stockData=read.csv(DataPath)

#Adding a new column "Distance" to stockData
stockData["Distance"] <- NA
no_of_row <- nrow(stockData)
for(n in 1:no_of_row){
stockData$Distance[n] <- stockData$Open[n] - stockData$Close[n+1]  
}

#Adding a new column "Polarity" to stockData
stockData["Polarity"] <- NA
stockData$Polarity <- ifelse(stockData$Distance>0, "Up", "Down")

#Data Partition
PartitionData <- createDataPartition(y= stockData$Volume,p=0.40,list=FALSE)      
TrainData <- stockData[-PartitionData,]
TestData <- stockData[PartitionData,]
dim(TrainData)
dim(TestData)

#Applyin knn algorithm 
model <- kknn(Polarity~.,TrainData,TestData,k=13)
prediction <- summary(model)


#Obtaining Next Day Polarity as Result
result <- as.matrix(prediction)
result[1]


#Analyzing Algorithm Precision
fit <- fitted(m1)
table(TestData$Polarity, fit)

confusionMatrix(fit,TestData$Polarity)