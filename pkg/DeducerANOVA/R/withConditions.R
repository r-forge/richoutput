withConditions <- function(expr) { 	
	myWarnings <- NULL
	myErrors <- NULL 	
	wHandler <- function(w) {
		myWarnings <<- c(myWarnings, w$message) 	 
		invokeRestart("muffleWarning") 	
	}
	val <- withCallingHandlers(expr, warning = wHandler)
	if (!is.null(myWarnings)) {
		myWarnings = unique(myWarnings)
		attr(val,"warnings") = myWarnings
		}
	return(val)
}
