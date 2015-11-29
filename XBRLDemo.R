
## Setting stringsAsFactors = FALSE is highly recommended
## to avoid data frames to create factors from character vectors.
options(stringsAsFactors = FALSE)
## Load the library
library(XBRL)
## XBRL instance file to be analyzed, accessed
## directly from SEC website:
inst <- "http://www.sec.gov/Archives/edgar/data/21344/000002134413000050/ko-20130927.xml"
## Level 1: Function that does all work and returns
## a list of data frames with extracted information:
## Not run:
xbrl.vars <- xbrlDoAll(inst, verbose=TRUE)
## Level 2: Using the XBRL() "mutable state" function:
xbrl <- XBRL()
xbrl$setCacheDir("XBRLcache")
xbrl$openInstance(inst)
## Perform a discovery of the taxonomy:
xbrl$processSchema(xbrl$getSchemaName())
## Process instance file:
xbrl$processContexts()
xbrl$processUnits()
xbrl$processFacts()
print("Before footnotes")
xbrl$processFootnotes()
print("Before close")
#xbrl$closeInstance()
#print("Before get resykts")
#xbrl.vars <- xbrl$getResults()
## End(Not run)
## Level 3: Using specialized functions that call C++ code directly:
## Parse the instance (doc is an pointer to external memory that needs to be freed):
#doc <- xbrlParse(inst)
## Get a data frame with facts:
#fct <- xbrlProcessFacts(doc)
## Get a data frame with contexts:
#cts <- xbrlProcessContexts(doc)
## Get a data frame with units:
#unt <- xbrlProcessUnits(doc)
## Free the external memory used:
#xbrlFree(doc)