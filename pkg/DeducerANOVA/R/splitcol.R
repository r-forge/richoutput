splitcol <- function(variable,split,newnames) {
	tmp <- strsplit(as.character(variable),split)
	newvars <- data.frame(t(sapply(tmp,c)))
	names(newvars) <- newnames
	return(newvars) 
	}