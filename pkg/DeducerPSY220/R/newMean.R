newMean <- function(data, variables = NULL, reversed = NULL, 
	max = NULL, label)
{
	vars <- eval(substitute(variables), data, parent.frame())
	revs <- eval(substitute(reversed), data, parent.frame())
	df = revData(data,vars,revs,max)$data
	mean.na <- function(x) {
		mean(x, na.rm = TRUE)
		}
	avg <- apply(df, 1, mean.na) # note that any missing values will result in mean of NA
	avg.na <- apply(df, 1, mean)
	missing <- sum(is.na(avg.na))
	margin.na <- function(x) sum(is.na(x))
	missing.table <- d(table(apply(df,1,margin.na)))
	colnames(missing.table) = c("Number missing","Frequency")
	if (missing > 0) {
		code = "</pre>\n"
		code = paste(code,"<p><b>Warning: Missing Data</b></p>\n")
		code = paste(code,"<p>",missing," means based on incomplete data</p>\n")
		code = paste(code,"<p>Pattern of missing data:</p>\n")
		code = paste(code,h.df(missing.table, rowcolors = TRUE))
		cat(code)
		}
	return(avg)
}
