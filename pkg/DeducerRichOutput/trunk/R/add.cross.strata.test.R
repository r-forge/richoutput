add.cross.strata.test <- function (tables, name, htests, types = c("asymptotic", "monte.carlo", 
    "exact")) 
{
	add.cross.strata.t <- function() {
	    types <- match.arg(types, c("asymptotic", "monte.carlo", 
	        "exact"), TRUE)
		if (names(tables[[1]][1]) == "No Strata") 
			stop("No strata for cross-strata test")
	    if (is.function(htests)) 
	        htests <- list(htests)
	    if (length(htests) != length(types)) 
	        stop("type and tests must be the same length")
	    if (class(tables) != "contingency.tables") 
	        stop("tables is not a contingency.tables object")
	    count.tables <- extract.counts(tables)
	    for (i in 1:length(tables)) {
	        if (class(tables[[i]]) != "contin.table") 
	            next
	        tests <- list(stratum = "Cross Strata", asymptotic = if ("asymptotic" %in% 
	            types) htests[[which(types == "asymptotic")]](count.tables[[names(tables)[i]]]) else NA, 
	            monte.carlo = if ("monte.carlo" %in% types) htests[[which(types == 
	                "monte.carlo")]](count.tables[[names(tables)[i]]]) else NA, 
	            exact = if ("exact" %in% types) htests[[which(types == 
	                "exact")]](count.tables[[names(tables)[i]]]) else NA)
	        tests <- tests[!is.na(tests)]
	        test.l <- list(tests)
	        if (is.null(tables[[i]]$cross.strata.tests)) {
	            tables[[i]]$cross.strata.tests <- list()
	            class(tables[[i]]$cross.strata.tests) <- "contin.tests"
	# begin addition
				if (!is.null(attr(tables[[i]],"strata.name"))) attr(tables[[i]]$cross.strata.tests,"strata.name") = attr(tables[[i]],"strata.name")
				attr(tables[[i]]$cross.strata.tests,"cross") = TRUE
				attr(tables[[i]]$cross.strata.tests,"table") = names(tables)[i]
	# end addition
	        }
	        tables[[i]]$cross.strata.tests[name] <- list(test.l)
	    }
	    tables
	}
	tables <- withConditions(add.cross.strata.t())
}
