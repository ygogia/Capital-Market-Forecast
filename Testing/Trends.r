ProjDirPath = "C:\\xampp\\htdocs\\Testing\\"



#Loading Necessary Packages for Forecasting
library(quantmod)
library(xts)
library(caret)
library(ggplot2)
library(forecast)


#Loading Stock data CSV File saved as table.csv for stock ticker entered by user 
DataPath = paste0(ProjDirPath,"table.csv")
stockData=read.csv(DataPath)


#Ordering and Time Slicing the data monthly
OrderedData = xts(stockData$Close, order.by=as.Date(stockData$Date))
TimeSlicedData = to.yearly(OrderedData)
Open=Op(TimeSlicedData)
FinalData = ts(Open,frequency=2)


#Saving First Plot  into TimeSlice.png
TimeSlicePath = paste0(ProjDirPath,"TimeSlice.png")
png(filename= TimeSlicePath)
plot(FinalData, xlab="Years+1",ylab="Ordered Data")
dev.off()


#Saving Second plot into Trends.png
TrendsPath = paste0(ProjDirPath,"Trends.png")
png(filename= TrendsPath)
plot(decompose(FinalData),xlab="years+1")
dev.off()

TrainData = window(FinalData,start=1,end=5)
TestData = window(FinalData,start=5,end=(7-0.01))


#Saving Fourth plot into MovingAverage.png
MAPath = paste0(ProjDirPath,"MovingAverage.png")
png(filename= MAPath)
plot(TrainData)
lines(ma(TrainData,order=3),col="red")
dev.off()
etss = ets(TrainData,model="MMM")
fcast = forecast(etss)


#Saving Fifth Plot into ExpMovAvg.png
EMAPath = paste0(ProjDirPath,"ExpMovAvg.png")
png(filename=EMAPath)
plot(fcast)
lines(TestData,col="red")
dev.off()

