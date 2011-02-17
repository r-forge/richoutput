revData <- function(data, variables = NULL, reversed = NULL, 
	max = NULL)
{
	vars <- eval(substitute(variables), data, parent.frame())
	revs <- eval(substitute(reversed), data, parent.frame())		
	if (length(revs) > 0) {
		variablesR = as.numeric(max) + 1 - revs
		revname <- paste(names(variablesR),".rev",sep="")
		names(variablesR) <- revname
		}
	if ((length(revs) > 0) && (length(vars) > 0)) df = cbind(vars,variablesR)
	else if (length(revs) > 0) df = variablesR
	else df = vars
	results <- list("data" = df)
	if (length(revs) > 0) results[["reversed"]] <- variablesR
	return(results)
}
