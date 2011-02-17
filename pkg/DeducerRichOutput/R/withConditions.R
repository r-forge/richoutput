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
		warns = paste("<div>",myWarnings,"</div>",sep="", collapse="")
		warnMessages = paste("<p class = \"b\">Warning:</p>",warns,sep="")
		attr(val,"warnings") = warnMessages
		}
	return(val)
}
