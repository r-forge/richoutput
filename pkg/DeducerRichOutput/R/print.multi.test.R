print.multi.test <- function (x, ...) {
code = "</pre>"
# Main title
	if (!is.null(attr(x, "header"))) 	
		code=paste(code,"<h1>",attr(x, "header"),"</h1>",sep="")

# Name of method
	if (!is.null(attr(x, "method"))) { 
		method = attr(x,"method")
		code = paste(code,"<h3>Method: ",method,"</h3>",sep="")
		} else {method = NULL}

# Name of factor and levels of factor
	if (!is.null(attr(x, "factor.name")) || !is.null(attr(x, "factor.levels"))) {
		code = paste(code,"<h3>",sep="")
		if (!is.null(attr(x, "factor.name"))) {
			factor.name = attr(x,"factor.name")
			predictors = factor.name
			code = paste(code,"Factor:",factor.name)
			} else 
				{
				predictors = NULL
				factor.name = NULL
				}
		if (!is.null(attr(x, "factor.levels"))) {
			factor.levels = attr(x,"factor.levels")	
			factor.levels2 <- gsub("<","&lt;",factor.levels)	
			factor.label = paste(factor.levels, collapse=" vs. ")
			factor.label2 = paste(factor.levels2, collapse=" vs. ")
			code = paste(code, " ( ", factor.label2, " ) ", sep="")
			} else { 
				factor.label = NULL
				}
		code = paste(code,"</h3>",sep="")
		} else {
			factor.name = NULL
			factor.label = NULL
			predictors = NULL
			}
# This next line sends the data.frame off to be turned into an HTML table
	x$'p-value' <- gsub("<","&lt;",format.pval(x$'p-value',eps = .001,digits=3))
	code = paste(code,h.df(x, rowcolors = TRUE),sep="")
		
# Adds some notes at the bottom
	if (!is.null(attr(x, "alternative")) || !is.null(attr(x,"null.value")))
		{
		code = paste(code,"<p class=\"b\">Notes:</p>",sep="")
		if (is.character(attr(x, "alternative"))) {
			code = paste(code,"<div>HA: ",attr(x, "alternative"),"</div>",sep="")
			}
	    if (!is.null(attr(x, "null.value"))) { 
	        code = paste(code,"<div>H0: ", names(attr(x, "null.value"))[1], "=", attr(x, 
	            "null.value"),"</div>",sep="")
			}
		}

# Creating a short label of outcome variables, suitable for printing on
# the title of the analysis but not put in the HTML results.
	if (!is.null(attr(x,"outcome.names"))) {
		outcomes = attr(x,"outcome.names")
		outcome.label = outcome.labels(outcomes)
		} else { 
			outcomes = NULL
			outcome.label = NULL
			}

# Getting the "call" (the R expression that produced the output) into a format
# that can be passed to OutputElement:
	if (!is.null(attr(x, "CALL")))
		{
		Rc = deparse(attr(x, "CALL"))
		Rca = ""
		for (i in 1:length(Rc)) Rca=paste(Rca,Rc[i])
		Rcall = gsub("  ","",Rca) # this produces a length-1 string
		} else Rcall = NULL
# Next, look for warning messages and add them to the code:
	if (!is.null(attr(x,"warnings"))) 
		code = paste(code,attr(x,"warnings"),sep="")

# Name of the test (e.g., t.test)		
	if (!is.null(attr(x, "func")))
		{
		test = attr(x, "func")
		} else 
			{
			test = "multi.test" 
			}

# Title:

	ti <- paste("[",test,"] ", 
		if (!is.null(outcome.label)) outcome.label,
		if (!is.null(factor.name)) paste(" by ",factor.name, if(!is.null(factor.levels)) paste(" (", factor.label, ")",sep=""), sep=""),
		sep="")

# closing pre tag
	code = paste(code,"<pre>",sep="")
		
	results <- code
	
	Rdate = date()
	
	# The last line sends these 7 parameters off to the function "h",
	# which will add them to an OutputElement and then add that element
	# to OutputRecord:
	
#	h(ti, results, Rcall, predictors, outcomes, test, Rdate)
	cat(results)	
	
# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
}
