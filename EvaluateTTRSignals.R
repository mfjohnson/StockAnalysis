# Evaluate Stock price purchase signals
library(quantmod)
library(TTR)
library(xts)
library(zoo)
library(PerformanceAnalytics)
options("getSymbols.warning4.0"=FALSE)
getSymbols("FAST")

data(ttrc)
#ADX
adxTrend <- ADX(ttrc[,c("High","Low","Close")])
#Aroon
aroonTrend <- aroon( ttrc[,c("High", "Low")], n=20 )
#ATR
atr <- ATR(ttrc[,c("High","Low","Close")], n=14)
#Bollinger Bands
bbands.HLC <- BBands( ttrc[,c("High","Low","Close")] )
bbands.close <- BBands( ttrc[,"Close"] )
#CCI
cci <- CCI(ttrc[,c("High","Low","Close")])

# Chaikin
ad <- chaikinAD(ttrc[,c("High","Low","Close")], ttrc[,"Volume"])

#Chaikin Money Flow
cmf <- CMF(ttrc[,c("High","Low","Close")], ttrc[,"Volume"])
plot(cmf)


#Chande Momentum Oscillator
cmo <- CMO(ttrc[,"Close"])

# Donchian Channel
dc <- DonchianChannel( ttrc[,c("High","Low")] )

# De-Trended Price Oscillator
priceDPO <- DPO(ttrc[,"Close"])
volumeDPO <- DPO(ttrc[,"Volume"])

plot(priceDPO)
plot(volumeDPO)

# DV Intermediate Oscillator
dvi <- DVI(ttrc[,"Close"])

# Arms’ Ease of Movement Value
emv <- EMV(ttrc[,c("High","Low")], ttrc[,"Volume"])

# Guppy Multiple Moving Averages
gmma <- GMMA(ttrc[,"Close"])

# Know Sure Thing
kst <- KST(ttrc[,"Close"])
kst4MA <- KST(ttrc[,"Close"],
              maType=list(list(SMA),list(EMA),list(DEMA),list(WMA)))

# MACD
macd  <- MACD( ttrc[,"Close"], 12, 26, 9, maType="EMA" )
macd2 <- MACD( ttrc[,"Close"], 12, 26, 9,
               maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )

# Money Flow Index
mfi <- MFI(ttrc[,c("High","Low","Close")], ttrc[,"Volume"])


# On Balance Volume (OBV)
obv <- OBV(ttrc[,"Close"], ttrc[,"Volume"])


# Rate of Change / Momentum
roc <- ROC(ttrc[,"Close"])
mom <- momentum(ttrc[,"Close"])

# Analysis of Running/Rolling/Moving Windows
rsi <- RSI(ttrc[, "Close"], n = 14, maType="WMA", wts=ttrc[,"Volume"])

# Parabolic Stop-and-Reverse
sar <- SAR(ttrc[,c("High","Low")])

# SMA Moving Averages
ema.20 <-   EMA(ttrc[,"Close"], 20)
#
# Evaluate buy/sell signals
evalSignals <- function(priceMatrix) {
  print("-------------------")
  priceMatrix
  print("------------------")
}

#
# Backtest indicators
#
# Backtest Arron
#
aroonOscillator <- data.frame(aroonTrend)
sig <- Lag(ifelse(aroonOscillator$oscillator > 80, -1, ifelse(aroonOscillator$oscillator < -80, 1,0)),1)
names(sig) <- c("ArronSignal")
aroonModel <- cbind(ttrc, sig, aroonTrend)

# 
# Function to determine the trade size based on signal
determineTrades <- function(x, c, s) {
  cat(sprintf("Start: Cash = %d, Shares=%d, date=%s\n", c,s, x[1]))
  commission <- 9.99
  cash <- c
  minShares <- 100
  shares <- s
  purchase <- 0
  sell <- 0
  adjShares <-0
  transAmount <-0
  signal <- as.numeric(x[7])
  closePrice <- as.numeric(x[5])
  transDate <- as.Date(x[1])
  result <- c("NOP",transDate, shares, cash, 0, 0, 0)
  
  if (!is.na(signal)){
    cat("Signal:", signal)
    if ((cash > 5000) & (signal == 1)) {
      adjShares <- floor(cash / closePrice)
      if (adjShares > minShares) {
        purchase <- closePrice
        transAmount <- adjShares * purchase * -1
        cash <<- cash + transAmount - commission
        shares <<- shares + adjShares
        #assign("cash", cash , envir=parent.frame(1))
        #assign("shares", shares, envir=parent.frame(2))
        cat("Purchase:", purchase, "Shares:", shares," Cash:",cash,"\n")
        result <- c("Buy",transDate, shares, cash, adjShares, purchase, transAmount)
        cat(sprintf("Share Purchase transaction amount = %s\n",result[6]))
      } else if ((signal == -1) & (shares > 0)) {
        cat("Sell ")
        cat("SignalX:",signal," Shares:", shares,"\n")
        # Liquidate all shares
        transAmount <- (shares * closePrice)
        adjShares <- shares * -1
        purchase <- closePrice
        cash <<- cash + transAmount  - commission
        shares <<- shares + adjShares
        #assign("cash", cash + transAmount - commission, envir=parent.frame(1))
        #assign("shares", , envir=parent.frame(2))
        result <- c("Sale",transDate, shares, cash, adjShares, purchase, transAmount)
        
      }
    }
    cat(sprintf("->>%s, %s, %s, %s, %s, %s, %s\n",result[1],result[2],result[3],result[4],result[5],result[6],result[7]))
    return(result)
  }
  shares <- 0
}  

#x <- aroonModel[aroonModel$Lag.1 != 0 & !is.na(aroonModel$Lag.1),]
#b <- apply(aroonModel,1,testFunction)
cash <- 10000
shares <- 0
b <- data.frame()
lst <- aroonModel[!is.na(aroonModel$Lag.1) & aroonModel$Lag.1 != 0,]
for(trans in lst) {
  tmp <- determineTrades(trans,cash, shares)
  print(tmp)
  b <- tmp
}


#ret <- ROC(ttrc[, c("Close")])*sig
#eq <- cumsum(ret)
#plot(eq)

#table.Drawdowns(ret, top=10)
#table.DownsideRisk(ret)c
#charts.PerformanceSummary(ret)