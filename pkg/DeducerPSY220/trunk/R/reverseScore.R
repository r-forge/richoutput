# This function takes a set of items and the maximum value for the response scale
# and runs a principal components analysis on those items. It takes the loadings
# on the first PC and identifies which ones are negative. These are selected out,
# reverse-scored, and their variable labeles are appended with an "r". Then 
# they are tacked on to the end of the original data frame.

# Still to do:  Find out how to deal with NAs, as in the atw dataset.
# See na.omit() or na.exclude()


reversed <- function(rawdat,max)
 {
dat <- na.omit(rawdat)
pc <- princomp(dat) #principal components analysis of a set of items
signs <- pc$loadings[,1] #loadings on first principal component
rev <- signs<0 #gives TRUE to values recommended for reversal (those with negative
               # loadings on the first principal component
items<-dat[rev] #picks out the items that are TRUE in rev
other.items<-dat[!rev] #picks out the other items
items.r <- max + 1 - items # reverses the items
revname <- paste(names(items.r),"r",sep="") #puts an r at the end of the names of reversed items
colnames(items.r) <- revname #replaces variable names with those new r names 
new.dat <- data.frame(other.items,items.r) #new dataset with reversed & non-reversed items
new.dat
#avg <- apply(new.dat,1,mean) #computes the average of those
#newer.dat <- data.frame(new.dat,avg) #new data frame including reversed, non-reversed, and average
#newer.dat
 }

#demonstration
#bss <- read.table("C:/Documents and Settings/altermattw/My Documents/Bill's/Courses/Research Methods/R/bss.csv",header=T,sep=",",quote="")
#bss.items <- bss[,2:12] #makes a data frame with just the items, no subject numbers
#bss.r <- reverse(bss.items,7) #selects out likely candidates for reversal
#
