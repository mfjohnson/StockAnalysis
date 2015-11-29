# Review Holdings

require(quantmod)
require(TTR)

symbolList <- c("CRC","FAST","HCP","KO","NGG","OXY","WFC","XOM","VZ","QCOM")
tickers <- new.env()
getSymbols(Symbols = symbolList)


chartSeries(XOM,name = names(XOM), subset='last 3 months')
#addAroonOsc(n=40)
addRSI(n=14)
#addSAR()
reChart(major.ticks='months') 


