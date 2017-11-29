library(lubridate)
library(xts)
library('ggplot2')
library('forecast')
library('tseries')

setwd("/media/shashank/New Volume/Sem/DataAnalysis/Project/cryptocurrencypricehistory")

btc <- read.csv("bitcoin_price.csv")
btc$Date <- as.Date(btc$Date, format="%B %d, %Y")
df <- btc[,c("Date","Close")]
df$Close <- as.integer(df$Close)
df <- df[year(df$Date)>2016,]


# reverse the dataset
df<-df[dim(df)[1]:1,]

#df <- xts(df[,-1], order.by = df$Date)
#plot(df, x = time(df), ylab="usd")

dt <- ts(df[,"Close"])
plot(dt)

dt$clean = tsclean(dt)
plot(dt$clean)

dt$cnt_ma = ma(dt$clean, order=7) # using the clean count with no outliers
dt$cnt_ma30 = ma(dt$clean, order=30)

plot(dt$cnt_ma)

adf.test(na.approx(diff(log(df))), alternative="stationary", k=0)

acf(df)
acf(log(df))
acf(na.approx(diff(log(df))),na.action = na.pass)

auto.arima(dt$clean)
(fit <- arima(log(dt$clean), order= c(3, 2, 2)))
pred <- predict(fit, n.ahead = 100)
ts.plot(as.ts(dt$clean),2.718^pred$pred, log = "y", lty = c(1,3))