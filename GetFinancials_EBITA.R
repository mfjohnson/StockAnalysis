# EBITA_GetFinancials
tickers <-  new.env()
s <- c("AAPL","GOOG","IBM","GS","AMZN","GE")

lapply(s, getFinancials,env=tickers)
sapply(ls(envir=tickers),
       function(x) {x <- get(x) ## get the varible name
       x$IS$A["Operating Income", ] / x$IS$A["Total Revenue",]})