k.sample.test <- function (formula, data = NULL, test = oneway.test, ...) 
{
    variables <- eval(formula[[2]], data, parent.frame())
    factor.var <- eval(formula[[3]], data, parent.frame())
	func = deparse(substitute(test))
	
	k.sample.t <- function() {
	    if (length(dim(variables)) < 1.5) {
	        variables <- d(variables)
	        fn <- formula[[2]]
	        names(variables) <- if (is.call(fn)) 
	            format(fn)
	        else as.character(fn)
	    }
	    if (length(dim(factor.var)) > 1.5) 
	        factor.var <- factor.var[, 1]
	    x <- factor(factor.var)
	    y <- variables
	    tests <- list()
	    tests[[1]] <- list(func = func, level = gsub("<","&lt;",levels(x)))
	    for (var.name in colnames(y)) {
	        tmp <- na.omit(data.frame(y = y[, var.name], x = x))
	        tests[[var.name]] <- test(y ~ x, tmp, ...)
	        tests[[var.name]]$parameter = round(tests[[var.name]]$parameter, 
	            3)
	    }
	    result <- multi.test(tests)
		if(is.call(formula[[3]])) {
			factorname = strsplit(deparse(formula[[3]]), "[\\(,]")[[1]][2]	
			} else {factorname = as.character(formula[[3]])}
		attr(result, "factor.name") = factorname
		attr(result, "factor.levels") = tests[[1]]$level 
		attr(result, "header") = "K-Sample Test"
		attr(result, "outcome.names") = names(variables)
		attr(result, "func") = func
	    result
	}
	results <- withConditions(k.sample.t())
	attr(results, "CALL") = match.call()
	return(results)
}
