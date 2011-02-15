h.printCoefmat <- function (x, digits = max(3, getOption("digits") - 2), signif.stars = getOption("show.signif.stars"),
	signif.legend = signif.stars, dig.tst = max(1, min(5, digits -
	1)), cs.ind = 1:k, tst.ind = k + 1, zap.ind = integer(0),
	P.values = NULL, has.Pvalue = nc >= 4 && substr(colnames(x)[nc],
	1, 3) == "Pr(", eps.Pvalue = .Machine$double.eps, na.print = "NA",
	...)
{
	if (is.null(d <- dim(x)) || length(d) != 2L)
		stop("'x' must be coefficient matrix/data frame")
	nc <- d[2L]
	if (is.null(P.values)) {
		scp <- getOption("show.coef.Pvalues")
		if (!is.logical(scp) || is.na(scp)) {
			warning("option \"show.coef.Pvalues\" is invalid: assuming TRUE")
			scp <- TRUE
		}
		P.values <- has.Pvalue && scp
	}
	else if (P.values && !has.Pvalue)
		stop("'P.values' is TRUE, but 'has.Pvalue' is not")
	if (has.Pvalue && !P.values) {
		d <- dim(xm <- data.matrix(x[, -nc, drop = FALSE]))
		nc <- nc - 1
		has.Pvalue <- FALSE
	}
	else xm <- data.matrix(x)
	k <- nc - has.Pvalue - (if (missing(tst.ind))
		1
	else length(tst.ind))
	if (!missing(cs.ind) && length(cs.ind) > k)
		stop("wrong k / cs.ind")
	Cf <- array("", dim = d, dimnames = dimnames(xm))
	ok <- !(ina <- is.na(xm))
	for (i in zap.ind) xm[, i] <- zapsmall(xm[, i], digits)
	if (length(cs.ind)) {
		acs <- abs(coef.se <- xm[, cs.ind, drop = FALSE])
		if (any(ia <- is.finite(acs))) {
			digmin <- 1 + if (length(acs <- acs[ia & acs != 0]))
					floor(log10(range(acs[acs != 0], finite = TRUE)))
				else 0
			Cf[, cs.ind] <- format(round(coef.se, max(1, digits -
				digmin)), digits = digits)
		}
	}
	if (length(tst.ind))
		Cf[, tst.ind] <- format(round(xm[, tst.ind], digits = dig.tst),
		digits = digits)
	if (any(r.ind <- !((1L:nc) %in% c(cs.ind, tst.ind, if (has.Pvalue) nc))))
	for (i in which(r.ind)) Cf[, i] <- format(xm[, i], digits = digits)
	ok[, tst.ind] <- FALSE
	okP <- if (has.Pvalue)
		ok[, -nc]
	else ok
	x1 <- Cf[okP]
	dec <- getOption("OutDec")
	if (dec != ".")
		x1 <- chartr(dec, ".", x1)
	x0 <- (xm[okP] == 0) != (as.numeric(x1) == 0)
	if (length(not.both.0 <- which(x0 & !is.na(x0)))) {
		Cf[okP][not.both.0] <- format(xm[okP][not.both.0], digits = max(1,
		digits - 1))
	}
	if (any(ina))
		Cf[ina] <- na.print
	if (P.values) {
		if (!is.logical(signif.stars) || is.na(signif.stars)) {
		warning("option \"show.signif.stars\" is invalid: assuming TRUE")
		signif.stars <- TRUE
		}
		if (any(okP <- ok[, nc])) {
			pv <- as.vector(xm[, nc])
			Cf[okP, nc] <- format.pval(pv[okP], digits = dig.tst,
			eps = eps.Pvalue)
			signif.stars <- signif.stars && any(pv[okP] < 0.1)
			if (signif.stars) {
				Signif <- symnum(pv, corr = FALSE, na = FALSE,
				cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
				symbols = c("***", "**", "*", ".", " "))				
				Cf <- cbind(Cf, format(Signif))
				colnames(Cf)[5] = "sig."
			}
		}
		else signif.stars <- FALSE
		}
	else signif.stars <- FALSE
	code = h.df(Cf, rowcolors = TRUE)
	if (signif.stars && signif.legend) {
		sig.code = "***<i>p</i>&lt;.001, **<i>p</i>&lt;.01, *<i>p</i>&lt;.05, .<i>p</i>&lt;.10"
		code = paste(code,"<div><i>Note:</i> ", sig.code, "</div>\n")
		}
	return(code)
}
