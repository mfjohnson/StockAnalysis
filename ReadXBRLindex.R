# Read XBRL indexes
library(RCurl)
library(XML)
readXMLFile <- function() {
  base.url <- 'http://www.sec.gov/Archives/edgar/monthly/xbrlrss-'
  xml.url <- paste(base.url,"2005-04.xml",sep="")
  script  <- getURL(xml.url)
  doc     <- xmlParse(script)
  titles    <- xpathSApply(doc,'//item/title',xmlValue)
  descriptions    <- xpathSApply(doc,'//item/description',xmlValue)
  pubdates <- xpathSApply(doc,'//item/pubDate',xmlValue)
  xbrlFiles <- xpathSApply(doc, '//item/edgar:xbrlFiling', 
            namespaces = xmlNamespaceDefinitions(doc, simplify = TRUE), xmlValue)
}

debug(readXMLFile)
readXMLFile()