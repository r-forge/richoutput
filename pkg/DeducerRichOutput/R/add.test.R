add.test <- function (tables, name, htests, types = c("asymptotic", "monte.carlo", 
    "exact")) 
{
	add.t <- function() {
	    types <- match.arg(types, c("asymptotic", "monte.carlo", 
	        "exact"), TRUE)
	    if (is.function(htests)) 
	        htests <- list(htests)
	    if (length(htests) != length(types)) stop("type and tests must be the same length")	
	    if (class(tables) != "contingency.tables") stop("tables is not a contingency.tables object")
	    for (i in 1:length(tables)) {
	        if (class(tables[[i]]) != "contin.table") 
	            next
	        tests <- list()
	        for (j in 1:length(tables[[i]])) {
	            tab <- tables[[i]]
	            if (class(tab[[j]]) != "single.table") 
	                next
# capturing warnings for particular tests
	            tests[[j]] <- list(stratum = names(tab)[j], 
					asymptotic = if ("asymptotic" %in% types) 
						withConditions(try(htests[[which(types == "asymptotic")]](tab[[j]]$table))) 
						else NA, 
	                monte.carlo = if ("monte.carlo" %in% types) 
						withConditions(try(htests[[which(types == "monte.carlo")]](tab[[j]]$table))) 
						else NA, 
	                exact = if ("exact" %in% types) 
						withConditions(try(htests[[which(types == "exact")]](tab[[j]]$table))) 
						else NA)
	            tests[[j]] <- tests[[j]][!is.na(tests[[j]])]
	            invalid <- sapply(tests[[j]], function(x) class(x) == 
	                "try-error")
	            htestNA <- structure(list(statistic = NA, parameter = NA, 
	                p.value = NA, method = "", data.name = ""), class = "htest")
	            for (index in 1:length(tests[[j]])) if (invalid[index]) 
	                tests[[j]][[index]] <- htestNA
	        }
	        test.l <- list(tests)
	        if (is.null(tables[[i]]$tests)) {
	            tables[[i]]$tests <- list()
	            class(tables[[i]]$tests) <- "contin.tests"
	# begin addition
				if (!is.null(attr(tables[[i]],"strata.name"))) attr(tables[[i]]$tests,"strata.name") = attr(tables[[i]],"strata.name")
				attr(tables[[i]]$tests,"table") = names(tables)[i]
	# end addition
	        }
	        tables[[i]]$tests[name] <- test.l
	    }
	    tables
	}
	# wrapping all tables in withConditions
	tables <- withConditions(add.t())
}
