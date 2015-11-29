# Option Analytics
require(quantmod)

optChain <- getOptionChain("HCP", NULL)
for(i in 1:length(names(optChain))) {
  a <- optChain[i]
  
}
