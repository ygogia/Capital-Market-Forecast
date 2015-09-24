library(quantmod)
library(xts)
library(caret)
library(ggplot2)
library(forecast)
data1=read.csv("infy.csv")
dfx1 = xts(data1$Close.Price, order.by=as.Date(data1$Price.Date))
minfy=to.monthly(dfx1)
infyOpen=Op(minfy)
ts2 = ts(infyOpen,frequency=12)
plot(ts2,xlab="Years+1",ylab="dfx1")
plot(decompose(ts2),xlab="years+1")

ts1Train = window(ts2,start=1,end=5)
ts1Test = window(ts2,start=5,end=(7-0.01))
ts1Train
ts1Test
plot(ts1Train)
lines(ma(ts1Train,order=3),col="red")

ets1 = ets(ts1Train,model="MMM")
ets1
fcast1=forecast(ets1)
plot(fcast1)
lines(ts1Test,col="red")
accuracy(fcast1,ts1Test)