two.sample.test <- function (formula, data = NULL, test = t.test, ...) 
{
    variables <- eval(formula[[2]], data, parent.frame())
    factor.var <- eval(formula[[3]], data, parent.frame())
	func = deparse(substitute(test))

	two.sample.t <- function () {
		factor.var <- d(sapply(factor.var, function(x) gsub("c\\(","",x)))
		factor.var <- d(sapply(factor.var, function(x) gsub("[\"\\)]","",x)))
#		factor.var <- d(sapply(factor.var, function(x) gsub("<","&lt;",x)))
	    if (length(dim(variables)) < 1.5) {
	        variables <- d(variables)
	        fn <- formula[[2]]
	        names(variables) <- if (is.call(fn)) 
	            format(fn)
	        else as.character(fn)
	    }
	    if (length(dim(factor.var)) > 1.5) 
	        factor.var <- factor.var[, 1]
	    x <- as.factor(factor.var)
	    y <- variables
	    if (length(levels(as.factor(as.integer(x)))) != 2L) 
	        stop("factor must have 2 and only two levels")
	    tests <- list()
#	    tests[[1]] <- list(func = func, level = gsub("<","&lt;",levels(x)))
	    tests[[1]] <- list(func = func, level = levels(x))
	    sample1 <- !is.na(x) & x == levels(x)[1]
	    sample2 <- !is.na(x) & x == levels(x)[2]
	    for (var.name in colnames(y)) {
	        tmp.x <- na.omit(y[sample1, var.name, drop = TRUE])
	        tmp.y <- na.omit(y[sample2, var.name, drop = TRUE])
	        if (length(tmp.y) < 3L || length(tmp.x) < 3L) {
	            warning(paste(var.name, "must have at least 3 observations per group. Dropping..."))
	            next
	        }
	        tests[[var.name]] <- test(tmp.x, tmp.y, ...)
	    }
	    result <- multi.test(tests)
	    if (identical(t.test, test)) 
	        colnames(result)[1:2] <- c(paste("mean of", tests[[1]]$level[1]), 
	            paste("mean of", tests[[1]]$level[2]))		 
		if(is.call(formula[[3]])) {
			factorname = strsplit(deparse(formula[[3]]), "[\\(,]")[[1]][2]	
			} else {factorname = as.character(formula[[3]])}
		attr(result,"factor.name") = factorname
		attr(result,"factor.levels") = tests[[1]]$level
		attr(result,"outcome.names") = colnames(y)
		attr(result,"func") = func
		attr(result, "header") = "Comparison of Two Independent Samples"
		result
    }
	results <- withConditions(two.sample.t())
	attr(results,"CALL") = match.call()
	return(results)
}
