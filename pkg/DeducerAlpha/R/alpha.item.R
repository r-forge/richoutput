alpha.item <- 
function (dat) 
{
    S <- cov(na.omit(dat))
    s <- sqrt(diag(S))
    if ((!is.numeric(S)) || !is.matrix(S) || (nrow(S) != ncol(S)) || 
        any(abs(S - t(S)) > max(abs(S)) * 1e-10) || nrow(S) < 
        2) 
        stop("argument must be a square, symmetric, numeric covariance matrix")
    k <- dim(S)[1]
    if (k < 3) {
        warning("there are fewer than 3 items in the scale")
        return(invisible(NULL))
    }
    S <- cov(na.omit(dat))
    reliab <- function(S) {
        k <- dim(S)[1]
        ones <- rep(1, k)
        v <- as.vector(ones %*% S %*% ones)
        reliab <- (k/(k - 1)) * (1 - (1/v) * sum(diag(S)))
        reliab
    }
    alpha <- matrix(0, k, 1)
    for (i in 1:k) {
        alpha[i, 1] <- reliab(S[-i, -i])
    }
    variable <- rownames(S)
    o <- order(alpha, decreasing = T)
	if(length(variable) < nrow(dat)) {
	    pc <- princomp(na.omit(dat))
	    PC1 <- pc$loadings[, 1]
	    item.deleted <- data.frame(alpha, PC1)
	    item.deleted <- item.deleted[o, ]
		}
		else {
			item.deleted <- alpha[o]
			names(item.deleted) <- variable[o]
			}
	#TODO:  Add item means to check for differences in scale.
    results <- list(total = reliab(S), item.deleted = item.deleted)
    code = "</pre><h2>Reliability</h2>"
    code = paste(code, "<p><b>Cronbach's alpha = </b>", formatC(results$total, 
        digits = 5), "</p>", sep = "")
    code = paste(code, "<h3>Alpha if item deleted</h3", sep = "")
    code = paste(code, h.df(results$item.deleted, rowcolors = TRUE), sep = "")
    code = paste(code, "<p>Note: <i>N</i> = ", dim(na.omit(dat))[1], 
        ". ", dim(dat)[1] - dim(na.omit(dat))[1], " cases removed for missing data</p>", 
        sep = "")
    code = paste(code, "<pre>", sep = "")
    return(code)
}
