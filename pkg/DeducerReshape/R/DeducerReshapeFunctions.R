reshape.long <- function(data, varying.list, idvar = "id",
	ids = rownames(data), within.name = "time",
	within.levels = c("colnames","integers","letters"), drop=NULL){
	# If idvar is a column of data with duplicated values,
	# use a dummy idvar
	if (idvar %in% names(data) && any(duplicated(data[[idvar]]))){
		ids <- make.unique(as.character(data[[idvar]]))
		idvar <- make.unique(c(names(data), "id"))[length(data)+1L]
		rmidvar <- TRUE
	} else rmidvar <- FALSE
	# Define the levels of the within-subjects factor
	within.levels <- match.arg(within.levels)
	if (within.levels == "colnames" && length(varying.list) > 1L){
		warning("The within-subjects factor levels will be the names of the first group of variables")
	}
	within.levels <- switch(within.levels,
		"colnames" = varying.list[[1L]],
		"integers" = seq_along(varying.list[[1L]]),
		"letters" = letters[seq_along(varying.list[[1L]])])
	# Call reshape
	long.data <- reshape(data, varying = varying.list,
		v.names = names(varying.list), idvar = idvar, ids = ids,
		timevar = within.name, times = within.levels, drop = drop,
		direction = "long")
	attr(long.data, "reshapeLong") <- NULL
	# Move newly created idvar to the first column,
	# and remove it if adequate
	nc <- length(long.data)
	if (!(idvar %in% names(data))) long.data <- long.data[c(nc, 1:(nc-1L))]
	if (rmidvar) long.data <- long.data[2:nc]
	long.data
}

reshape.wide <- function(data, idvar = "id", wvar = "time",
	v.names, fun.aggregate = mean, order.by.variable = TRUE){
	# Create new variable timevar, that combines the values of wvar
	if (length(wvar) > 1L){
		datanames <- names(data)
		timevar <- make.unique(c(datanames, "time"))[length(datanames)+1L]
		# Rename "sep" in wvar, if it exists, to avoid error in creating timevar
		if (any(wvar=="sep")){
			newsep <- make.unique(c(datanames, "sep"))[length(datanames)+1L]
			names(data)[which(datanames=="sep")] <- newsep
			wvar[which(wvar=="sep")] <- newsep
		}
		data[[timevar]] <- do.call(interaction, data[wvar])
	}else timevar <- wvar
	# Aggregate duplicated values of idvar and timevar
	byvar <- c(idvar, timevar)
	if (anyDuplicated(data[byvar])){
		data <- aggregate(data[v.names], by = data[byvar], FUN = fun.aggregate)
	}
	# Call reshape
	wide.data <- reshape(data, v.names = v.names, idvar = idvar,
		timevar = timevar, direction = "wide")
	newvars <- attr(wide.data, "reshapeWide")$varying
	attr(wide.data, "reshapeWide") <- NULL
	# Re-order the new columns
	if (order.by.variable){
		positions1 <- match(newvars, names(wide.data))
		positions2 <- match(t(newvars), names(wide.data))
		varorder <- seq_along(wide.data)
		varorder[positions1] <- positions2
		wide.data <- wide.data[varorder]
	}
	wide.data
}
