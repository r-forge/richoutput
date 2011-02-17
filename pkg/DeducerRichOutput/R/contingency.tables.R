contingency.tables <- function (row.vars, col.vars, stratum.var, data = NULL, missing.include = FALSE) 
{
    arguments <- as.list(match.call()[-1])
    if (missing(row.vars) || missing(col.vars)) 
        stop("Please specify the row variables (row.vars), and column variables (col.vars)")
    row.vars <- eval(substitute(row.vars), data, parent.frame())
    col.vars <- eval(substitute(col.vars), data, parent.frame())
    if (length(dim(row.vars)) < 1.5) {
        row.vars <- as.data.frame(row.vars)
        names(row.vars) <- as.character(arguments$row.vars)
    }
    if (length(dim(col.vars)) < 1.5) {
        col.vars <- as.data.frame(col.vars)
        names(col.vars) <- as.character(arguments$col.vars)
    }
    if (!missing(stratum.var)) 
        stratum.var <- eval(substitute(stratum.var), data, parent.frame())		
    else stratum.var <- NULL
    vector.x <- FALSE
    num.row.vars <- dim(row.vars)[2]
    num.col.vars <- dim(col.vars)[2]
    single.table <- function(dat, dnn) {
        x <- dat[[1]]
        y <- dat[[2]]
        if (is.null(stratum.var)) 
            stratum.var <- rep("No Strata", length(x))
        if (length(x) != length(y)) 
            stop("all row.vars and col.vars must have the same length")
        if (missing.include) {
            x <- factor(x, exclude = c())
            y <- factor(y, exclude = c())
            strata <- factor(stratum.var, exclude = c())
        }
        else {
            x <- factor(x)
            y <- factor(y)
            strata <- factor(stratum.var)
        }
        lev <- levels(strata)
        table.list <- list()
        for (level in lev) {
            temp.x <- x[strata == level]
            temp.y <- y[strata == level]
            t <- table(temp.x, temp.y, dnn = dnn)
            RS <- rowSums(t)
            CS <- colSums(t)
            t <- t[RS > 0, CS > 0, drop = FALSE]
            RS <- rowSums(t)
            CS <- colSums(t)
            CPR <- prop.table(t, 1)
            CPC <- prop.table(t, 2)
            CPT <- prop.table(t)
            CST <- try(suppressWarnings(chisq.test(t, correct = FALSE)), 
                silent = TRUE)
            if (class(CST) != "htest") 
                CST <- list(expected = t * NA)
            GT <- sum(t)
            if (length(dim(x) == 2)) 
                TotalN <- GT
            else TotalN <- length(temp.x)
            table.list[[level]] <- list(table = t, row.sums = RS, 
                col.sums = CS, total = GT, row.prop = CPR, col.prop = CPC, 
                total.prop = CPT, expected = CST$expected)
            class(table.list[[level]]) <- "single.table"
# begin addition
			attr(table.list[[level]],"table") = paste(names(row.vars)[i], "by", names(col.vars)[j])
# end addition
        }
        class(table.list) <- "contin.table"
# begin addition
		if (!is.null(stratum.var)) attr(table.list,"strata.name") = arguments$stratum.var		
# end addition
        table.list
    }
    result <- list()
    count <- 1
    for (i in 1:num.row.vars) {
        for (j in 1:num.col.vars) {
            result[[paste(names(row.vars)[i], "by", names(col.vars)[j])]] <- single.table(data.frame(row.vars[, 
                i], col.vars[, j]), dnn = c(names(row.vars)[i], 
                names(col.vars)[j]))
            count <- count + 1
        }
    }
    class(result) <- "contingency.tables"
# begin addition
	attr(result,"rowNames") = paste(as.character(arguments$row.vars),collapse=", ")
	attr(result,"colNames") = paste(as.character(arguments$col.vars),collapse=", ")
	attr(result,"strata.name") = as.character(arguments$stratum.var)
# end addition
    result
}
