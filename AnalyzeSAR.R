# SAR Pricing Analysis
require(quantmod)
require(TTR)

symbolList <- c("HDP","VMW")
evaluateSAR <- function(x) {
  x$sar <- SAR(x[, c(2,4)])
  x$sarDif <- x[,c(4)] - x[, c(7)]
  sarCurrent <- x[nrow(x), c("sarDif")]
  currentScore <- x[nrow(x), ]
  result = "NA"
  currentScore$sarAction = ifelse(currentScore$sarDif > 0, "Buy",ifelse(currentScore$sarDif < 0, "Sell","NA"))

  return(currentScore)
}

tickets <- new.env()
getSymbols(Symbols = symbolList, env=tickets)
debug(evaluateSAR)
sapply(tickets, evaluateSAR)

