one.sample.test <- function (variables, data = NULL, test = t.test, ...) 
{
    arguments <- as.list(match.call()[-1])
    vars <- eval(substitute(variables), data, parent.frame())
	func = deparse(substitute(test))
	
	one.sample.t <- function() {
	    if (length(dim(vars)) < 1.5) {
	        vars <- d(vars)
	        fn <- arguments$variables
	        names(vars) <- if (is.call(fn)) 
	            format(fn)
	        else as.character(fn)
	    }
	    data <- vars
	    tests <- list(NULL)
	    for (i in 1:ncol(data)) {
	        if (is.character(data[[i]])) {
	            warning(paste("'", names(data)[i], "' is a character vector. Attempting to coerce into a numeric one.", 
	                sep = ""))
	            data[[i]] <- as.numeric(data[[i]])
	        }
	        if (is.factor(data[[i]])) {
	            warning(paste("'", names(data)[i], "' is a factor. Attempting to coerce into numeric.\n", 
	                sep = ""))
	            data[[i]]
	            tmp <- as.numeric(as.character(data[[i]]))
	            if (length(na.omit(tmp)) == length(na.omit(data[[i]]))) 
	                data[[i]] <- tmp
	            else data[[i]] <- as.numeric(data[[i]])
	        }
	        if (is.logical(data[[i]])) {
	            data[[i]] <- as.numeric(data[[i]])
	        }
	        if (!is.numeric(data[[i]])) {
	            warning(paste("'", names(data)[i], "' is not numeric. It will be dropped.\n", 
	                sep = ""))
	            next
	        }
	        if (length(na.omit(data[[i]])) < 3) {
	            warning(paste("'", names(data)[i], "' has fewer than 3 valid values. It will be dropped.", 
	                sep = ""))
	            next
	        }
	        tests[[names(data)[i]]] <- test(na.omit(data[[i]]), ...)
	    }
	    result <- multi.test(tests)
			attr(result,"outcome.names") = names(vars)
			attr(result,"func") = func
			attr(result, "header") = "One-Sample Test"
			result
	    }
	results <- withConditions(one.sample.t())
	attr(results,"CALL") = match.call()
	return(results)
}