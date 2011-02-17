descriptive.table <- function (vars, strata, data, func.names = c("Mean", "St. Deviation", 
    "Median", "25th Percentile", "75th Percentile", "Minimum", 
    "Maximum", "Skew", "Kurtosis", "Valid N"), func.additional) 
{
	dat <- eval(substitute(vars), data, parent.frame())
	if (missing(strata)) {
	        strata <- rep("all cases", dim(dat)[1])
			nostrata = TRUE
	    }
	    else { 
	        strata <- eval(substitute(d(strata)), data, parent.frame())
			strata <- d(sapply(strata, function(x) gsub("<","&lt;",x)))
			strata <- d(sapply(strata, function(x) gsub("c\\(","",x)))
			strata <- d(sapply(strata, function(x) gsub("[\"\\)]","",x)))
			nostrata = FALSE
	    }
	if (!missing(func.additional)) {
	        if (!is.list(func.additional) || is.null(names(func.additional))) 
	            stop("func.additional must be a named list of functions")
	        functions <- c(functions, unlist(func.additional))
	        func.names <- c(func.names, names(func.additional))
	    }

	descript.table <- function ()
	{
	    if (length(dim(dat)) < 1.5) 
	        dat <- d(dat)
		if (any(!sapply(dat, is.numeric))) {
			dropped <- paste(names(dat[!sapply(dat, is.numeric)]),collapse=", ")
	        dat <- dat[sapply(dat, is.numeric)]
	        warning(paste("Non-numeric variables dropped from descriptive table: <i>",dropped,"</i>",sep=""))
	    }
		if (dim(dat)[2] == 0) {
			stop("No numeric variables in dataset")
		}    
		func.indexes <- pmatch(func.names, c("Mean", "St. Deviation", 
	        "Median", "25th Percentile", "75th Percentile", "Minimum", 
	        "Maximum", "Skew", "Kurtosis", "Valid N"))
	    functions <- c(function(x) mean(x, na.rm = TRUE), function(x) sd(x, 
	        na.rm = TRUE), function(x) median(x, na.rm = TRUE), function(x) quantile(x, 
	        0.25, na.rm = TRUE), function(x) quantile(x, 0.75, na.rm = TRUE), 
	        function(x) min(x, na.rm = TRUE), function(x) max(x, 
	            na.rm = TRUE), function(x) skewness(x, na.rm = TRUE, 
	            type = 2), function(x) kurtosis(x, na.rm = TRUE, 
	            type = 2), function(x) sum(!is.na(x)))
	    functions <- functions[func.indexes]
	    tbl.list <- list()
			for (dv in 1:length(dat)) { 
			    for (ind in 1:length(functions)) {
			        tbl.list[[colnames(dat)[dv]]][[func.names[ind]]] <- by(dat[dv], strata, function(x) sapply(x, 
			            functions[[ind]]), simplify = FALSE)
			    }
			}
		outcomes <<- names(tbl.list)
		code="</pre><h1>Descriptive Statistics</h1>"
		
		data.frame.list <- list()
	
		
	
		if (!nostrata) {
			for (v in 1:length(dat)) { 
				dims <- dim(tbl.list[[1]][[1]]) # number of levels of each of the strata.
												# E.g., if there are three factors A, B, and C
												# and they have 3 levels, 2 levels, and 4 levels respectively,
												# then this would be [3 2 4].
				dims.rev <- rev(dims)
				dims.cp <- cumprod(dims)
				dims.rev.cp <- cumprod(dims.rev)
				stutter <- c(1,dims.cp)
				length(stutter) = length(dims)
				recycle <- c(1,dims.rev.cp)
				length(recycle) = length(dims)
				recycle = rev(recycle)
				
		        dn <- dimnames(tbl.list[[v]][[1]]) 
		        dnn <<- names(dn) 			
				cols = sum(length(dnn),length(functions))
				
				mat <- matrix(data = NA, ncol = cols, nrow = length(tbl.list[[v]][[1]]))
				data.fr <- as.data.frame(mat)
				colnames(data.fr) <- c(dnn, func.names)
					
				for (co in 1:length(dnn)) { # for each strata variable:
				r = 1
					for (rep in 1:recycle[co]) {
						for (i in 1:length(dn[[co]])) {
							for (stut in 1:stutter[co]) {
								data.fr[r,co] <- paste(dn[[co]][i],sep="")
								r = r+1
								}}}}
		 
				for (rw in 1:length(tbl.list[[v]][[1]])) { # for each row:
					for (fu in 1:length(functions)) { # for each function:
						data.fr[rw,fu+length(dnn)] <- tbl.list[[v]][[fu]][[rw]]
					}
				}
		
				data.frame.list[[colnames(dat)[v]]] <- data.fr
						
			}
		for (v in 1:length(data.frame.list)) {
			code = paste(code,"<h3>Variable: ",names(data.frame.list[v]),"</h3>",sep="")
			code = paste(code,h.df(data.frame.list[[v]], rowcolors = TRUE),"<BR>",sep="")	
			}
		}
		else # if there are no strata:
		{
			dnn <<- NULL
			mat <- matrix(data = NA, ncol = length(functions), nrow = length(dat))
			data.fr <- as.data.frame(mat)
			colnames(data.fr) <- func.names
			row.names(data.fr) <- names(tbl.list)
			for (v in 1:length(tbl.list)) { 
				for (co in 1:length(functions)) {
					data.fr[v,co] <- tbl.list[[v]][[co]]
					}
				}
			code = paste(code,h.df(data.fr, rowcolors = TRUE),"<BR>",sep="")	
		}
			Rc = deparse(match.call())
			Rca = ""
			for (i in 1:length(Rc)) Rca=paste(Rca,Rc[i])
		Rcall <<- gsub("  ","",Rca) 
		return(code)
	}

	results = withConditions(descript.table())
	
	if (!is.null(attr(results,"warnings"))) 
		results = paste(results,attr(results,"warnings"),sep="")
	
	results = paste(results,"<pre>",sep="")
			
predictors = dnn
pred = ""
	if (!is.null(predictors)) {
		for (i in 1:length(predictors))	pred = paste(pred," by ",predictors[i],sep="")
	}

ti = paste("[descriptive] ",outcome.labels(outcomes),pred,sep="")

	
Rdate = date()
test = "descriptives"

#h(ti, results, Rcall, predictors, outcomes, test, Rdate)
cat(results)
# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
}
