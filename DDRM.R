#EBITA Quantmod calculation
library(quantmod)
library(TTR)

tickers <-  new.env()
s <- c("FAST","XOM")
#"CEB",
#divGrowers <- read.csv("divGrow.csv", header=TRUE)
sapply(s, getFinancials,env=tickers)


## Calculate various ratios
ebita <- sapply(tickers, function(x) {
  x$IS$Q["Operating Income", ] / x$IS$Q["Total Revenue",]
}
)
revenue <- sapply(tickers, function(x) 
  x$IS$Q["Total Revenue",])
totalDividends <- sapply(tickers, function(x) x$CF$A["Total Cash Dividends Paid",]*-1)



#experiment <- sapply(tickers, )
# Calculate Dividend rate
#divRate <- sapply(tickers, function(x) {
#  divRate <- x$CF$Q["Amortization"]
#}
  


#View(divRate)
#df <- data.frame(divRate)
#View(df)
#rate <- 100*diff(df$XOM.f)/df[-nrow(df),]$XOM.f
#HistoricalGrowth <- mean(rate)

#View(rate)
