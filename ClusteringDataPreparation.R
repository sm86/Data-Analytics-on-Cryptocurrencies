library(lubridate) 

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

# Bitcoin
btc <- read.csv("bitcoin_price.csv")
btc$Date <- as.Date(btc$Date, format="%B %d, %Y")
btc["currency"] <- "bitcoin"
btc <- btc[year(btc$Date)==2017,]
btc$Market.Cap <-  as.numeric(gsub(",","",btc$Market.Cap))
btc$Volume <-  as.numeric(gsub(",","",btc$Volume))

# RIPPLE XRP
xrp <- read.csv("ripple_price.csv")
xrp$Date <- as.Date(xrp$Date, format="%B %d, %Y")
xrp["currency"] <- "ripple"
xrp <- xrp[year(xrp$Date)==2017,]
xrp$Market.Cap <-  as.numeric(gsub(",","",xrp$Market.Cap))
xrp$Volume <-  as.numeric(gsub(",","",xrp$Volume))

# Stratis
strat <- read.csv("stratis_price.csv")
strat$Date <- as.Date(strat$Date, format="%B %d, %Y")
strat["currency"] <- "stratis"
strat <- strat[year(strat$Date)==2017,]
strat$Market.Cap <-  as.numeric(gsub(",","",strat$Market.Cap))
strat$Volume <-  as.numeric(gsub(",","",strat$Volume))

# Dash
dash <- read.csv("dash_price.csv")
dash$Date <- as.Date(dash$Date, format="%B %d, %Y")
dash["currency"] <- "dash"
dash <- dash[year(dash$Date)==2017,]
dash$Market.Cap <-  as.numeric(gsub(",","",dash$Market.Cap))
dash$Volume <-  as.numeric(gsub(",","",dash$Volume))

# Lite coin
ltc <- read.csv("litecoin_price.csv")
ltc$Date <- as.Date(ltc$Date, format="%B %d, %Y")
ltc["currency"] <- "litecoin"
ltc <- ltc[year(ltc$Date)==2017,]
ltc$Market.Cap <-  as.numeric(gsub(",","",ltc$Market.Cap))
ltc$Volume <-  as.numeric(gsub(",","",ltc$Volume))

# Monero
xmr <- read.csv("monero_price.csv")
xmr$Date <- as.Date(xmr$Date, format="%B %d, %Y")
xmr["currency"] <- "monero"
xmr <- xmr[year(xmr$Date)==2017,]
xmr$Market.Cap <-  as.numeric(gsub(",","",xmr$Market.Cap))
xmr$Volume <-  as.numeric(gsub(",","",xmr$Volume))

# Ethereum Classic
etc <- read.csv("ethereum_classic_price.csv")
etc$Date <- as.Date(etc$Date, format="%B %d, %Y")
etc["currency"] <- "ethereum classic"
etc <- etc[year(etc$Date)==2017,]
etc$Market.Cap <-  as.numeric(gsub(",","",etc$Market.Cap))
etc$Volume <-  as.numeric(gsub(",","",etc$Volume))

# Neo 
neo <- read.csv("neo_price.csv")
neo$Date <- as.Date(neo$Date, format="%B %d, %Y")
neo["currency"] <- "neo"
neo <- neo[year(neo$Date)==2017,]
neo$Market.Cap <-  as.numeric(gsub(",","",neo$Market.Cap))
neo$Volume <-  as.numeric(gsub(",","",neo$Volume))

# Nem
nem <- read.csv("nem_price.csv")
nem$Date <- as.Date(nem$Date, format="%B %d, %Y")
nem["currency"] <- "nem"
nem <- nem[year(nem$Date)==2017,]
nem$Market.Cap <-  as.numeric(gsub(",","",nem$Market.Cap))
nem$Volume <-  as.numeric(gsub(",","",nem$Volume))

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
df<- df[, c("Date", grep("Close", names(df), value = TRUE))]

# Convert into xts data type
df <- xts(df, order.by = df$Date)
# Remove the heading row
df <- df[,-1]
# Intilize the column Names
colnames(df) <- symbols
# covert into numeric matrix
storage.mode(df) <- "numeric"

# Differnece of consecutive days. Increase/Decrease in a day.
df <- apply(df,2,function(x)(diff(x)))


