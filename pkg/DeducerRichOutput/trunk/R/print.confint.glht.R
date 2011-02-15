print.confint.glht <- function (x, digits = max(3, getOption("digits") - 3), ...) 
{
    xtmp <- x
	code = "</pre>\n"
    code = paste(code,"<h2>Simultaneous Confidence Intervals</h2>\n",sep="")
    if (!is.null(x$type)) 
        code = paste(code,"<h3>Multiple Comparisons of Means:", x$type, "Contrasts</h3>\n")
    level <- attr(x$confint, "conf.level")
    attr(x$confint, "conf.level") <- NULL
    code = paste(code,"<p><b>Fit: </b>")
    if (isS4(x$model)) {
		callstring <- deparse(x$model@call)
		if (length(callstring) > 1) {
			callstr = callstring[1]
			for (i in 2:length(callstring)) {
				callstr = paste(callstr,str_trim(callstring[i],side="left"))
				}
			}
        code = paste(code,callstr,sep="")
    }
    else {
        callstring <- deparse(x$model$call)
		if (length(callstring) > 1) {
			callstr = callstring[1]
			for (i in 2:length(callstring)) {
				callstr = paste(callstr,str_trim(callstring[i],side="left"))
				}
			}
		code = paste(code,callstr,sep="")
    }
	code = paste(code,"</p>\n",sep="")
    error <- attr(x$confint, "error")
    if (!is.null(error) && error > .Machine$double.eps) 
        digits <- min(digits, which.min(abs(1/error - (10^(1:10)))))
    code = paste(code,"<p><b>Quantile = </b>", round(attr(x$confint, "calpha"), digits),"</p>\n")
    if (attr(x, "type") == "adjusted") {
        code = paste(code,"<p>",level * 100, "% family-wise confidence level</p>\n", sep = "")
    }
    else {
        code = paste(code,"<p>",level * 100, "% confidence level</p>\n", sep = "")
    }
    code = paste(code,"<h3>Linear Hypotheses:</h3>\n")
    alt <- switch(x$alternative, two.sided = "==", less = ">=", 
        greater = "<=")
    rownames(x$confint) <- paste(rownames(x$confint), alt, x$rhs)
    code = paste(code,h.df(format(x$confint, nsmall = digits, digits = digits),rowcolors = TRUE),"\n",sep="")
	code = paste(code,"<pre>")
    cat(code)
    invisible(xtmp)
}
