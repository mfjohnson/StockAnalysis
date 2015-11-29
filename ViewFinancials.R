# Quantmod financials
library(quantmod)

fin <- getFinancials('AMGN', auto.assign=F)
BS.q<-viewFinancials(fin,'BS',"Q") 
BS.q