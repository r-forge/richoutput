print.freq.table <- function (x) 
{
	variables = names(x)
	code = "</pre><H1>Frequencies</H1>"
	for (v in 1:length(x)) {
		code = paste(code,"<H3>Frequencies ( ",variables[v]," )</H3>", sep="")
		freq <- h.df(x[[v]][[1]])
		code = paste(code, freq, "<BR>")
		code = paste(code, "<H3>Case Summary ( ",variables[v]," )</H3>",sep="")
		case.sum <- h.df(x[[v]][[2]])
		code = paste(code,case.sum,"<BR><BR><HR><BR>")
	}
	ti = paste("[Frequencies] ",outcome.labels(variables))
	code = paste(code,"<pre>",sep="")
	results <- code
	if (!is.null(attr(x,"warnings"))) 
		results = paste(results,attr(results,"warnings"),sep="")
	Rc = deparse(match.call())
		Rca = ""
		for (i in 1:length(Rc)) Rca=paste(Rca,Rc[i])
		Rcall = gsub("  ","",Rca)
	outcomes <- outcome.labels(variables)
	test = "frequencies"
	Rdate = date()
	
#	h(ti, results, Rcall, predictors = NULL, outcomes, test, Rdate)
	cat(results)
# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)		
}
