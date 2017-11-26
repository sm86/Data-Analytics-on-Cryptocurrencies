library(lubridate) 
library(arules)
library(arulesViz)

#ethereum
eth <- read.csv("ethereum_price.csv")
#fixing the date
eth$Date <- as.Date(eth$Date, format="%B %d, %Y")
#Convert into correct number format removing commas
eth$Market.Cap<- as.numeric(gsub(",","",eth$Market.Cap))
eth$Volume <- as.numeric(gsub(",","",eth$Volume))
#Missing values treatment in Ethereum. The first value is missing, so deleted it.
eth<- eth[-which(is.na(eth$Market.Cap)),]
#assing currency attribute
eth["currency"] <-  "ethereum"
#Only 2017 year 
eth<- eth[year(eth$Date)==2017,]
eth$change <- c(0, diff(eth$Close))
eth$change_percent <- c(0,(eth$change[2:length(eth$change)] / eth$Close[1:length(eth$change)-1]) * 100)

#Waves
waves <- read.csv("waves_price.csv")
#fixing the date
waves$Date <- as.Date(waves$Date, format="%B %d, %Y")
waves$Market.Cap <-  as.numeric(gsub(",","",waves$Market.Cap))
waves$Volume <-  as.numeric(gsub(",","",waves$Volume))
# 19 values in beginning are zeros
which(is.na(waves$Market.Cap))
waves <- waves[-(471:489),]
waves["currency"] <- "waves"
waves<- waves[year(waves$Date)==2017,]
waves$change <- c(0, diff(waves$Close))
waves$change_percent <- c(0,(waves$change[2:length(waves$change)] / waves$Close[1:length(waves$change)-1]) * 100)

# Bitcoin
btc <- read.csv("bitcoin_price.csv")
btc$Date <- as.Date(btc$Date, format="%B %d, %Y")
btc["currency"] <- "bitcoin"
btc <- btc[year(btc$Date)==2017,]
btc$Market.Cap <-  as.numeric(gsub(",","",btc$Market.Cap))
btc$Volume <-  as.numeric(gsub(",","",btc$Volume))
btc$change <- c(0, diff(btc$Close))
btc$change_percent <- c(0,(btc$change[2:length(btc$change)] / btc$Close[1:length(btc$change)-1]) * 100)

# RIPPLE XRP
xrp <- read.csv("ripple_price.csv")
xrp$Date <- as.Date(xrp$Date, format="%B %d, %Y")
xrp["currency"] <- "ripple"
xrp <- xrp[year(xrp$Date)==2017,]
xrp$Market.Cap <-  as.numeric(gsub(",","",xrp$Market.Cap))
xrp$Volume <-  as.numeric(gsub(",","",xrp$Volume))
xrp$change <- c(0, diff(xrp$Close))
xrp$change_percent <- c(0,(xrp$change[2:length(xrp$change)] / xrp$Close[1:length(xrp$change)-1]) * 100)

# Stratis
strat <- read.csv("stratis_price.csv")
strat$Date <- as.Date(strat$Date, format="%B %d, %Y")
strat["currency"] <- "stratis"
strat <- strat[year(strat$Date)==2017,]
strat$Market.Cap <-  as.numeric(gsub(",","",strat$Market.Cap))
strat$Volume <-  as.numeric(gsub(",","",strat$Volume))
strat$change <- c(0, diff(strat$Close))
strat$change_percent <- c(0,(strat$change[2:length(strat$change)] / strat$Close[1:length(strat$change)-1]) * 100)

# Dash
dash <- read.csv("dash_price.csv")
dash$Date <- as.Date(dash$Date, format="%B %d, %Y")
dash["currency"] <- "dash"
dash <- dash[year(dash$Date)==2017,]
dash$Market.Cap <-  as.numeric(gsub(",","",dash$Market.Cap))
dash$Volume <-  as.numeric(gsub(",","",dash$Volume))
dash$change <- c(0, diff(dash$Close))
dash$change_percent <- c(0,(dash$change[2:length(dash$change)] / dash$Close[1:length(dash$change)-1]) * 100)

# Lite coin
ltc <- read.csv("litecoin_price.csv")
ltc$Date <- as.Date(ltc$Date, format="%B %d, %Y")
ltc["currency"] <- "litecoin"
ltc <- ltc[year(ltc$Date)==2017,]
ltc$Market.Cap <-  as.numeric(gsub(",","",ltc$Market.Cap))
ltc$Volume <-  as.numeric(gsub(",","",ltc$Volume))
ltc$change <- c(0, diff(ltc$Close))
ltc$change_percent <- c(0,(ltc$change[2:length(ltc$change)] / ltc$Close[1:length(ltc$change)-1]) * 100)

# Monero
xmr <- read.csv("monero_price.csv")
xmr$Date <- as.Date(xmr$Date, format="%B %d, %Y")
xmr["currency"] <- "monero"
xmr <- xmr[year(xmr$Date)==2017,]
xmr$Market.Cap <-  as.numeric(gsub(",","",xmr$Market.Cap))
xmr$Volume <-  as.numeric(gsub(",","",xmr$Volume))
xmr$change <- c(0, diff(xmr$Close))
xmr$change_percent <- c(0,(xmr$change[2:length(xmr$change)] / xmr$Close[1:length(xmr$change)-1]) * 100)

# Ethereum Classic
etc <- read.csv("ethereum_classic_price.csv")
etc$Date <- as.Date(etc$Date, format="%B %d, %Y")
etc["currency"] <- "ethereum classic"
etc <- etc[year(etc$Date)==2017,]
etc$Market.Cap <-  as.numeric(gsub(",","",etc$Market.Cap))
etc$Volume <-  as.numeric(gsub(",","",etc$Volume))
etc$change <- c(0, diff(etc$Close))
etc$change_percent <- c(0,(etc$change[2:length(etc$change)] / etc$Close[1:length(etc$change)-1]) * 100)


# Neo 
neo <- read.csv("neo_price.csv")
neo$Date <- as.Date(neo$Date, format="%B %d, %Y")
neo["currency"] <- "neo"
neo <- neo[year(neo$Date)==2017,]
neo$Market.Cap <-  as.numeric(gsub(",","",neo$Market.Cap))
neo$Volume <-  as.numeric(gsub(",","",neo$Volume))
neo$change <- c(0, diff(neo$Close))
neo$change_percent <- c(0,(neo$change[2:length(neo$change)] / neo$Close[1:length(neo$change)-1]) * 100)

# Nem
nem <- read.csv("nem_price.csv")
nem$Date <- as.Date(nem$Date, format="%B %d, %Y")
nem["currency"] <- "nem"
nem <- nem[year(nem$Date)==2017,]
nem$Market.Cap <-  as.numeric(gsub(",","",nem$Market.Cap))
nem$Volume <-  as.numeric(gsub(",","",nem$Volume))
nem$change <- c(0, diff(nem$Close))
nem$change_percent <- c(0,(nem$change[2:length(nem$change)] / nem$Close[1:length(nem$change)-1]) * 100)



library(TSclust)
library(xts)

# List of all the currencies
datasets <- list(btc, eth, xrp,waves,strat,nem,ltc,xmr,etc,neo,dash)
symbols = c("btc", "eth", "xrp", "waves", "strat", "nem", "ltc", "xmr", "etc", "neo", "dash")

# Formating data type
for (i in seq_along(datasets)) {
  for (j in seq_along(colnames(datasets[[i]]))) {
    if (colnames(datasets[[i]])[j] != "Date") {
      colnames(datasets[[i]])[j] <- paste(colnames(datasets[[i]])[j], symbols[i], sep = ".")
    }
  }
}
df <- Reduce(function(x, y) merge(x, y, all = TRUE, by = "Date"), datasets)
# Consider only closing prices
df<- df[, grep("change_percent", names(df), value = TRUE)]

colnames(df) <- symbols

data <- list()
ind <- 1

# will contain the list of indices which give null in the below for loop
c1 <- c()



for(rind in 1:nrow(df)) {
  row <- df[(rind),]
  lst <- c()
  for(colind in 1:ncol(row)) {
    col <- row[colind]
    if(col > 5) {
      lst <- c(lst, paste("i", colnames(col), sep =""))
    }
    else if(col < -5) {
      lst <- c(lst, paste("d", colnames(col), sep=""))
    }
    else {
      next
    }
  }
  if(!is.null(lst)) {
    data[[ind]] <- lst
    ind <- ind + 1
  }
  else {
      c1 <- c(c1, rind)
  }
}

data <-as(data, "transactions")
rules <- apriori(data , parameter = list(supp = 0.01, conf = 0.9, maxlen = 20))
summary(rules)
rules <- sort(rules, by="confidence", decreasing = TRUE)
inspect(rules[1:5])
