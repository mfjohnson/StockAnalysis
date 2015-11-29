# Quantmode introduction
#install.packages("quantmod") #Install the quantmod library
library("quantmod")  #Load the quantmod Library
stockData <- new.env() #Make a new environment for quantmod to store data in



tickers <- c("FAST","WFC") #Define the tickers we are interested in

#Download the stock history (for all tickers)
getSymbols(tickers, env = stockData, src = "yahoo")
StockPrices <- get("FAST", envir = stockData)
#Use head to show first six rows of matrix
head(StockPrices)

