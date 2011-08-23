print.ez <- function(results) {
	code = "</pre>"
	code = paste(code,"<h1>Analysis of Variance</h1>\n")
	for(i in 1:length(results)) {
			code = paste(code,"<h3>",names(results[i]),"</h3>\n",sep="")
			code = paste(code,h.df(results[[i]], rowcolors = TRUE),"\n",sep="")
		}
	if(!is.null(attr(results,"warnings"))) code = paste(code,attr(results,"warnings"))
	code = paste(code,"<pre>\n")
	cat(code)
	invisible(results)
	}
