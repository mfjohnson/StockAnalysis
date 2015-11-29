library(RCurl)
library(XML)
xml.url <- "http://www.huffingtonpost.com/rss/liveblog/liveblog-1213.xml"
script  <- getURL(xml.url)
doc     <- xmlParse(script)
titles    <- xpathSApply(doc,'//item/title',xmlValue)
descriptions    <- xpathSApply(doc,'//item/description',xmlValue)
pubdates <- xpathSApply(doc,'//item/pubDate',xmlValue)