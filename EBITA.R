#EBITA Quantmod calculation
library(quantmod)
library(TTR)

tickers <-  new.env()
s <- c("FAST","XOM")
#"CEB",
#divGrowers <- read.csv("divGrow.csv", header=TRUE)
sapply(s, getFinancials,env=tickers)


ebita <- sapply(tickers, function(x) 
  x$IS$Q["Operating Income", ] / x$IS$Q["Total Revenue",])
View(ebita)
revenue <- sapply(tickers, function(x) 
  x$IS$Q["Total Revenue",])

df <- data.frame(revenue)
View(df)
rate <- 100*diff(df$XOM.f)/df[-nrow(df),]$XOM.f
x <- mean(rate)
x
View(rate)
