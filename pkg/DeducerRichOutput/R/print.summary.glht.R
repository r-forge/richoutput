print.summary.glht <- function (x, digits = max(3, getOption("digits") - 3), ...) 
{
	code = "</pre>"
    code = paste(code,"<h2>Simultaneous Tests for General Linear Hypotheses</h2>\n")
    if (!is.null(x$type)) 
        code = paste(code,"<h3>Multiple Comparisons of Means:", x$type, "Contrasts</h3>\n")
    call <- if (isS4(x$model)) 
        x$model@call
    else x$model$call
    if (!is.null(call)) {
        callstring <- deparse(call)
		if (length(callstring) > 1) {
			callstr = callstring[1]
			for (i in 2:length(callstring)) {
				callstr = paste(callstr,str_trim(callstring[i],side="left"))
				}
			}
		code = paste(code,"<p><b>Fit: </b>",callstr,"</p>\n")
    }
    pq <- x$test
    mtests <- cbind(pq$coefficients, pq$sigma, pq$tstat, pq$pvalues)
    error <- attr(pq$pvalues, "error")
    pname <- switch(x$alternativ, less = paste("Pr(<", ifelse(x$df == 
        0, "z", "t"), ")", sep = ""), greater = paste("Pr(>", 
        ifelse(x$df == 0, "z", "t"), ")", sep = ""), two.sided = paste("Pr(>|", 
        ifelse(x$df == 0, "z", "t"), "|)", sep = ""))
    colnames(mtests) <- c("Estimate", "Std. Error", ifelse(x$df == 
        0, "z value", "t value"), pname)
    type <- pq$type
    if (!is.null(error) && error > .Machine$double.eps) {
        sig <- which.min(abs(1/error - (10^(1:10))))
        sig <- 1/(10^sig)
    }
    else {
        sig <- .Machine$double.eps
    }
    code = paste(code,"<h3>Linear Hypotheses:</h3>\n")
    alt <- switch(x$alternative, two.sided = "==", less = ">=", 
        greater = "<=")
    rownames(mtests) <- paste(rownames(mtests), alt, x$rhs)
    code = paste(code,h.printCoefmat(mtests, digits = digits, has.Pvalue = TRUE, 
        P.values = TRUE, eps.Pvalue = sig))
    adj <- switch(type, univariate = "(Univariate p values reported)", 
        `single-step` = "(Adjusted p values reported -- single-step method)", 
        Shaffer = "(Adjusted p values reported -- Shaffer method)", 
        Westfall = "(Adjusted p values reported -- Westfall method)", 
        paste("(Adjusted p values reported --", type, "method)"))
	code = paste(code,"<p>",adj,"</p>\n")
	code = paste(code,"<pre>\n")
	cat(code)
    invisible(x)
}
