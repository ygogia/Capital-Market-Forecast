#Loading Necessary Packages for Forecasting

library(quantmod)
library(xts)
library(caret)
library(ggplot2)
library(forecast)

#Loading Stock data CSV File saved as table.csv for stock ticker entered by user 
data1=read.csv("E:\\Program Files\\XAMPP\\htdocs\\cmf\\table.csv")
#Ordering and Time Slicing the data monthly
dfx1 = xts(data1$Close, order.by=as.Date(data1$Date))
mwipro=to.monthly(dfx1)
wiproOpen=Op(mwipro)
ts2 = ts(wiproOpen,frequency=2)

#Saving First Plot  into 1.png
png(filename="E:\\Program Files\\XAMPP\\htdocs\\cmf\\1.png")
plot(ts2,xlab="Years+1",ylab="dfx1")
dev.off()

#Saving Second plot into 2.png
png(filename="E:\\Program Files\\XAMPP\\htdocs\\cmf\\2.png")
plot(decompose(ts2),xlab="years+1")
dev.off()

ts1Train = window(ts2,start=1,end=5)
ts1Test = window(ts2,start=5,end=(7-0.01))

#Saving Fourth plot into 4.png
png(filename="E:\\Program Files\\XAMPP\\htdocs\\cmf\\4.png")
plot(ts1Train)
lines(ma(ts1Train,order=3),col="red")
dev.off()
ets1 = ets(ts1Train,model="MMM")
fcast1=forecast(ets1)

#Saving Fifth Plot into 5.png
png(filename="E:\\Program Files\\XAMPP\\htdocs\\cmf\\5.png")
plot(fcast1)
lines(ts1Test,col="red")
dev.off()
