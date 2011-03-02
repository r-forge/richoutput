print.summary.lm <- function (x, digits = max(3, getOption("digits") - 3), symbolic.cor = x$symbolic.cor, 
    signif.stars = getOption("show.signif.stars"), ...) 
{
	code = "</pre><h1>Linear Model Summary</h1>"
	callstring <- deparse(x$call)
		if (length(callstring) > 1) {
			callstr = callstring[1]
			for (i in 2:length(callstring)) {
				callstr = paste(callstr,str_trim(callstring[i],side="left"))
				}
			} else callstr = callstring
    code = paste(code, "<p><b>Call: </b>", callstr,"</p>\n")
#    code = paste(code, "<p><b>Call: </b>", deparse(x$call),"</p>\n")
    resid <- x$residuals
    df <- x$df
    rdf <- df[2L]
	code = paste(code,"<p><b>")
	if (!is.null(x$w) && diff(range(x$w)))
		code = paste(code, "Weighted ")
	code = paste(code, "Residuals:</b></p>\n")
    if (rdf > 5L) {
        nam <- c("Min", "1Q", "Median", "3Q", "Max")
        rq <- if (length(dim(resid)) == 2L) 
            structure(apply(t(resid), 1L, quantile), dimnames = list(nam, 
                dimnames(resid)[[2L]]))
        else {
            zz <- zapsmall(quantile(resid), digits + 1)
            structure(zz, names = nam)
        }
        code = paste(code,h.m(rq, digits = digits),"\n")
    }
    else if (rdf > 0L) {
        code = paste(code,h.m(resid, digits = digits), "\n")
    }
    else {
        code = paste(code,"<p><b>ALL", df[1L], "residuals are 0: no residual degrees of freedom!</b></p>\n")
    }
    if (length(x$aliased) == 0L) {
        code = paste(code,"<p><b>No Coefficients</b></p>\n")
    }
    else {
        if (nsingular <- df[3L] - df[1L]) 
            code = paste(code,"<p><b>Coefficients: </b>(", nsingular, " not defined because of singularities)</p>\n", 
                sep = "")
        else code = paste(code,"<p><b>Coefficients:</b></p>\n")
        coefs <- x$coefficients
        if (!is.null(aliased <- x$aliased) && any(aliased)) {
            cn <- names(aliased)
            coefs <- matrix(NA, length(aliased), 4, dimnames = list(cn, 
                colnames(coefs)))
            coefs[!aliased, ] <- x$coefficients
        }
        code = paste(code,h.printCoefmat(coefs, digits = digits, signif.stars = signif.stars, 
            na.print = "NA", ...))
    }
    code = paste(code,"<p><b>Residual standard error:</b>", format(signif(x$sigma, 
        digits)), "on", rdf, "degrees of freedom</p><br/>\n")
    if (nzchar(mess <- naprint(x$na.action))) 
        code = paste(code,"<p>  (", mess, ")</p>\n", sep = "")
    if (!is.null(x$fstatistic)) {
		code = paste(code,"<table>\n")
        code = paste(code,"<tr><th align=\"right\">Multiple R-squared:</th><td>", formatC(x$r.squared, digits = digits),"</td></tr>\n")
        code = paste(code,"<tr><th align=\"right\">Adjusted R-squared:</th><td>", formatC(x$adj.r.squared, digits = digits),"</td></tr>\n")
		code = paste(code,"<tr><th align=\"right\">F-statistic:</th><td>", formatC(x$fstatistic[1L], digits = digits),"</td></tr>\n")
		code = paste(code,"<tr><th align=\"right\">DF:</th><td>(", x$fstatistic[2L], ", ", x$fstatistic[3L], ")</td></tr>\n")
		code = paste(code,"<tr><th align=\"right\"><i>p</i>-value:</th><td>", format.pval(pf(x$fstatistic[1L], x$fstatistic[2L], 
			x$fstatistic[3L], lower.tail = FALSE), digits = digits), "</td></tr>\n")
		code = paste(code,"</table>\n")
    }
    correl <- x$correlation
    if (!is.null(correl)) {
        p <- NCOL(correl)
        if (p > 1L) {
            code = paste(code,"<p>Correlation of Coefficients:</p>\n")
            if (is.logical(symbolic.cor) && symbolic.cor) {
                code = paste(code,h.m(symnum(correl, abbr.colnames = NULL)))
            }
            else {
                correl <- format(round(correl, 2), nsmall = 2, 
                  digits = digits)
                correl[!lower.tri(correl)] <- ""
                code = paste(code,h.m(correl[-1, -p, drop = FALSE]),"\n")
            }
        }
    }
	code = paste(code,"<br/><hr><pre>\n")
    cat(code)
    invisible(x)
}
