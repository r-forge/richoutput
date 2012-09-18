replacep <- function(datafr) {
	datafr[grep("^p$",names(datafr))] <- format.pval(datafr[grep("^p$",names(datafr))],digits=2,eps=.001)
	return(datafr)
}

replacepadj <- function(datafr) {
	datafr[grep("^p adj$",names(datafr))] <- format.pval(datafr[grep("^p adj$",names(datafr))],digits=2,eps=.001)
	return(datafr)
}


