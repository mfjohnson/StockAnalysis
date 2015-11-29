# Quantmode introduction
#install.packages("quantmod") #Install the quantmod library
library("quantmod")  #Load the quantmod Library
stockData <- new.env() #Make a new environment for quantmod to store data in


symbol <- "CDNS"
tickers <- c(symbol) #Define the tickers we are interested in

#Download the stock history (for all tickers)
getSymbols(tickers, env = stockData, src = "yahoo")
#Use head to show first six rows of matrix
closePriceLabel <- sprintf("%s.Close",symbol)
#tz <- 'stockData$FAST'
#stockPrices <- get(tz)
stockPrices <- stockData$CDNS
trend <- aroon( Cl(stockPrices), n=20 )
sig <- Lag(ifelse(trend$oscillator > 70, -1, ifelse(trend$oscillator < -70, 1,0)),1)
names(sig) <- c("sig")
a <- cbind(stockPrices,sig)
a$AdjShares <- NA
a$TransPrice <- NA
a$cash <- NA
a$transaction <- NA
names(a)
priorIndicator <-0
cash <- 10000
shares <- 0
batchSize <- 50
for(i in 1:NROW(a)){
  price <- as.numeric(a[i,closePriceLabel])
  transSignal <- as.numeric(a[i, "sig"])
  if (!is.na(transSignal)) {
    if((cash > (batchSize*price) & transSignal == 1) ) {
      # Buy shares
      a[i, "TransPrice"] <- price * -1
      adjShares <- floor(cash / price)
      adjCash <- adjShares * price
      cash <- cash - adjCash
      a[i, "AdjShares"] <- adjShares
      a[i, "cash"] <- cash
      shares <- shares + adjShares
      a[i,"transaction"] <- "BUY"
    } else if(shares > 0 & transSignal == -1) {
      # Sell Shares
      a[i,"TransPrice"] <- price
      a[i,"AdjShares"] <- shares * -1
      cash <- cash + (shares * price)
      a[i, "cash"] <- cash
      shares <- 0
      a[i,"transaction"] <- "SELL"
    } else {
      a[i, "AdjShares"] <- 0
      a[i, "TransPrice"] <- 0
    }
  } else {
    a[i, "AdjShares"] <- 0
    a[i, "TransPrice"] <- 0    
  }
  
}
z <- subset(a, transaction == 'SELL')
plot(z$cash)
tail(trend,2)



