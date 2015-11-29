data(ttrc)

pList <- ttrc

stochOSC <- stoch(pList[,c("High","Low","Close")])
stochWPR <- WPR(pList[,c("High","Low","Close")])
plot(tail(stochOSC[,"fastK"], 100), type="l",
     main="Fast %K and Williams %R", ylab="",
     ylim=range(cbind(stochOSC, stochWPR), na.rm=TRUE) )
lines(tail(stochWPR, 100), col="blue")
lines(tail(1-stochWPR, 100), col="red", lty="dashed")
stoch2MA <- stoch( pList[,c("High","Low","Close")],
                   maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )
SMI3MA <- SMI(pList[,c("High","Low","Close")],
              maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )
stochRSI <- stoch( RSI(pList[,"Close"]) )