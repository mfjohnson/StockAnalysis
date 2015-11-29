require(quantmod)
getSymbols('FAST', src="google")

calcWeeklyReturn <- function(x) {

    allReturns(x)  # returns all periods
    weeklyReturns <- periodReturn(x,period='yearly')
    #b <- nrow(weeklyReturns)
    #b <- nrow(subset(weeklyReturns, yearly.returns < 0))
    #a <- mean(weeklyReturns)
}

a <- calcWeeklyReturn(FAST)


#a <- periodReturn(priceList,period='yearly',subset='2003::')  # returns years 2003 to present
#a <- periodReturn(priceList,period='weekly',subset='2003')  # returns year 2003
plot(a)
#print(a)