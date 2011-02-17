contin.tests.to.table <- function (tests, test.digits = 3, ...)
{
# The first block searches through 'tests' looking to see if there are any 
# elements that contain monte.carlo, exact, asymptotic, effect size estimates,
# or confidence intervals.
	{
		any.mc <- any(sapply(tests, function(test) sapply(test, function(x) !is.null(x$monte.carlo))))
		any.exact <- any(sapply(tests, function(test) sapply(test, function(x) !is.null(x$exact))))
		any.a <- any(sapply(tests, function(test) sapply(test, function(x) !is.null(x$asymptotic))))
		any.aest <- any(sapply(tests, function(test) sapply(test, 
	        function(x) sapply(x[c("asymptotic")], function(y) {
	            !is.null(y) && !is.null(y$estimate) && !is.na(y$estimate)
	        }))))
		any.ci <- any(sapply(tests, function(test) sapply(test, 
	        function(x) sapply(x[c("asymptotic")], function(y) {
				!is.null(y$conf.int) && !is.na(y$conf.int) 
			}))))
		any.param <- any(sapply(tests, function(test) sapply(test, 
	        function(x) sapply(x[c("asymptotic")], function(y) {
				!is.null(y$parameter) && !is.na(y$parameter)
			}))))
	
	}
# The next block computes the number of columns needed for a matrix based on the 
# presence of the elements identified in the previous block.
	{
	ncols = 0
	colLabels = ""
	colCode = ""
	if (any.a) {
		ncols = ncols + 3
		colLabels = c("statistic","parameter","asymptotic")
		}
	if (!any.param) {
		ncols = ncols - 1
		colLabels = colLabels[-match("parameter",colLabels)]
		}
	if (any.mc) {
		ncols = ncols + 1
		colLabels = c(colLabels,"monte.carlo")
		}	
	if (any.exact) {
		ncols = ncols + 1
		colLabels = c(colLabels,"exact")
		}
	if (any.aest) {
		ncols = ncols + 2
		colLabels = c(colLabels,"effect.size","estimate")
		}
	if (any.ci) {
		ncols = ncols + 3
		colLabels = c(colLabels,"lower","upper","conf.level")
		}
	colFinal = list(statistic = "statistic", parameter = "df", asymptotic = "asymptotic p-value", 
		monte.carlo = "Monte Carlo p-value", exact = "exact p-value", effect.size = "ES measure", 
		estimate = "ES est.", lower = "CI LL", upper = "CI UL", conf.level = "conf.level")
		
	testLabels = c("Pearson's Chi Squared","Log Likelihood Ratio (G)", "Fisher's Exact Test",
		"Spearman's rank correlation (S)", "Kendall's rank correlation (z)",
		"Kruskall-Wallis rank sum test (nominal rows)", "Kruskall-Wallis rank sum test (nominal cols)")
	
	}
# Next, the list is created
	{
	results = list()
	ntests = length(tests)
	nstrata = length(tests[[1]])
	}
# Next block iterates over strata, then over tests, then over test types
# (asymptotic, monte.carlo, or exact) and adds test info to a matrix called "result"
	{
	for (st in 1:nstrata) { # iterating across strata
		w = 0
		result = matrix(data = NA, nrow = ntests, ncol = ncols)
		rownames(result) <- names(tests)
		colnames(result) = colFinal[pmatch(colLabels,names(colFinal))]
		for (te in 1:ntests) { # iterating across tests
			test = tests[[te]][[st]]
			ntest = length(test)
				for (tn in 2:ntest) {
					stats = test[[tn]]
					stats <- stats[which(sapply(stats, function(x) all(!is.na(x))))]
					if (!is.null(stats$estimate)) {
						effect.size = list(effect.size = names(stats$estimate))
						stats$estimate = unname(stats$estimate)
						stats = c(stats,effect.size)
						} 
					if (!is.null(stats$conf.int)) {
						conf.level = list(conf.level = paste(attr(stats$conf.int,"conf.level")*100,"%",sep=""))
						lower = list(lower = stats$conf.int[[1]])
						upper = list(upper = stats$conf.int[[2]])
						stats = c(stats,lower,upper,conf.level)
						}
					names(stats) = gsub("p.value",names(test[tn]),names(stats))
					co = pmatch(names(stats),colLabels)
					stat.co = stats[!is.na(co)]
					co.co = co[!is.na(co)]
					# formatting for digits:
					stat.co = format(stat.co,nsmall=2,digits=test.digits)
					if (!is.null(attr(test[[tn]],"warnings"))) {
						w = w + 1
						p = pmatch(names(test[tn]),names(stat.co))
						stat.co[[p]] = paste(stat.co[[p]],"<sup><i>",letters[w],"</i></sup>",sep="")
						warn = sub("<div>",paste("<div><sup><i>",letters[w],"</i></sup>",sep=""),attr(test[[tn]],"warnings"))
						} else warn = NULL
					result[te,co.co] = unlist(stat.co)
					if (!is.null(warn)) {
						if (is.null(attr(result,"warnings")))
							attr(result,"warnings") = warn
						else attr(result,"warnings") = c(attr(result,"warnings"),warn)
					}
				}
				result[is.na(result)] <- "&nbsp;"
				results[[test$stratum]] <- result
			}
		}
	}
	return(results)
}
