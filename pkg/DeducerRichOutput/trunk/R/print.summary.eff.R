print.summary.eff <- function (x, ...) 
{
	code = "</pre>"
	code = paste(code,"<h1>",x$header,"</h1>\n")
    code = paste(code,h.m(x$effect))
    if (!is.null(x$lower)) {
        code = paste(code,"<h2>",x$lower.header,"</h2>\n",h.m(x$lower))
		code = paste(code,"<h2>",x$upper.header,"</h2>\n",h.m(x$upper))
    }
    if (!is.null(x$thresholds)) {
        code = paste(code,"<h2>Thresholds:</h2>\n")
        code = paste(code,h.m(x$thresholds))
    }
    if (!is.null(x$warning)) 
        code = paste(code,"<br/>\n",x$warning,"<br/>\n")
	code = paste(code,"<br/><hr><pre>\n")
	cat(code)
    invisible(x)
# 	TO DO: Put the confidence intervals into the same cells as the means,
# 	perhaps underneath the means and in parentheses.
# 	Use format(x$effect,digits=3) to get 2-decimal-place character string
# 	representations of the means. Do the same for x$lower and x$upper.
# 	Then need a way to put those values together.
# 	Then need to format them for HTML. Can no longer use h.m, which seems
# 	to be expecting raw number values for the entries.
}