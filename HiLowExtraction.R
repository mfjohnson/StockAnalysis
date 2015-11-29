require(quantmod)
require(TTR)


#aroon <- aroon(priceList[,c("High", "Low")], n=25)
shares <<- 0
cash <<- 10000
minTransaction <<- 5000

actOnSignal <- function(x) {
  sig <- x[10]
  
  if (sig == 1 & cash > minTransaction) {
    
  }
  
}

evaluateAroon <- function(x) {
  
  a <- aroon(LoHi(x),n=25)
  b <- cbind(x, a)
  b$sig <- ifelse(b$oscillator > 80, -1, ifelse(b$oscillator < -80, 1,0))
  b$action <- NA
  b$shares <- 0
  b$cash <- 0
  
  shares <<- 0
  cash <<- 10000
  myReturn <- lag(b$sig) * dailyReturn(s)
  #sapply(b, actOnSignal(b$sig))
  #b[nrow(a)]
  return(myReturn)
}


prices <- getSymbols("QCOM", auto.assign=FALSE)
names(prices) <- c("Open","High","Low", "Close", "Volume", "Adjusted")
debug(evaluateAroon)
myReturn <- evaluateAroon(prices)
View(myReturn)