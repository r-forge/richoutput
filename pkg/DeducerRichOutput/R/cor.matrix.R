cor.matrix <- function (variables, with.variables, data = NULL, test = cor.test, 
    ...) 
{
    arguments <- as.list(match.call()[-1])
    variables <- eval(substitute(variables), data, parent.frame())
    if (missing(with.variables)) 
        with.variables <- variables
    else {
        with.variables <- eval(substitute(with.variables), data, 
            parent.frame())
        if (length(dim(with.variables)) < 1.5) {
            with.variables <- d(with.variables)
            fn <- arguments$with.variables
            names(with.variables) <- if (is.call(fn)) 
                format(fn)
            else as.character(fn)
        }
    }
	cor.mat <- function() {
	    if (length(dim(variables)) < 1.5) {
	        variables <- d(variables)
	        fn <- arguments$variables
	        names(variables) <- if (is.call(fn)) 
	            format(fn)
	        else as.character(fn)
	    }

	    cors <- list()
	    for (var1 in colnames(variables)) {
	        cors[[var1]] <- list()
	        for (var2 in colnames(with.variables)) {
	            tmp <- na.omit(data.frame(as.numeric(variables[[var1]]), 
	                as.numeric(with.variables[[var2]])))
	            names(tmp) <- c(var1, var2)
	            cors[[var1]][[var2]] <- test(tmp[[1]], tmp[[2]], 
	                ...)
	            attr(cors[[var1]][[var2]], "N") <- nrow(tmp)
	        }
	    }
	    class(cors) <- "cor.matrix"
	    cors
	}
	cors <- withConditions(cor.mat())
}
