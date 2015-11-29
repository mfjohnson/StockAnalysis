## DDRM Analytics
library(quantmod)
stockList <- c("CRC","FAST","HCP")

financials <- getFinancials(Symbol = "HDP")
a <- viewFin(HDP.f,"IS","Q")
View(a)