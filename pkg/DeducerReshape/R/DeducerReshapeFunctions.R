reshape.long <- function(data, varying.list, idvar = "id",
	ids = rownames(data), within.name = "time",
	within.levels = c("colnames","integers"), drop=NULL){
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
		"integers" = seq_along(varying.list[[1L]]))
	# Call reshape
	long.data <- reshape(data, varying = varying.list,
		v.names = names(varying.list), idvar = idvar, ids = ids,
		timevar = within.name, times = within.levels, drop = drop,
		direction = "long")
	# Move newly created idvar to the first column,
	# and remove it if adequate
	nc <- length(long.data)
	if (!(idvar %in% names(data))) long.data <- long.data[c(nc, 1:(nc-1L))]
	if (rmidvar) long.data <- long.data[2:nc]
	long.data
}

