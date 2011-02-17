print.glht <- function (x, digits = max(3, getOption("digits") - 3), ...) 
{
    code = "</pre>\n"
	code = paste(code,"<H1>General Linear Hypotheses</H1>\n",sep="")
    if (!is.null(x$type)) 
        code = paste(code,"<H2>Multiple Comparisons of Means:", x$type, "Contrasts</H2>\n",sep="")
    beta <- coef(x)
    lh <- matrix(beta, ncol = 1)
    colnames(lh) <- "Estimate"
    alt <- switch(x$alternative, two.sided = "==", less = ">=", 
        greater = "<=")
    rownames(lh) <- paste(names(beta), alt, x$rhs)
    code = paste(code,"<H3>Linear Hypotheses:</H3>\n",sep="")
	code = paste(code,h.df(lh, rowcolors = TRUE),"\n",sep="")
	code = paste(code,"<pre>\n",sep="")
	cat(code)
}
