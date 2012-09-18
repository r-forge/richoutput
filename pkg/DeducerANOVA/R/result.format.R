df.format <- function(a, digits = 3, nsmall = 2, row.names = FALSE, 
	row.header = "",code="")
	{
		if("p" %in% names(a)) {
			a[,"p"] <- format.pval(a[,"p"], digits = 3,eps = .001)
			}		
		if("p adj" %in% names(a)) {
			a[,"p adj"] <- format.pval(a[,"p adj"], digits = 3,eps = .001)
			}
		a <- format(a,digits=digits)
		return(a)
		}

Tukey.format <- function (TukeyList, digits = 2, nsmall = 2)
	{
	a <- TukeyList
	for (j in 1:length(TukeyList)) {
		a[[j]] <- df.format(as.data.frame(TukeyList[[j]]))
		}
	class(a) = "list"
	return(a)
	}


result.format <- function(result, rowcolors = TRUE, digits = 2, nsmall = 2)
	{
	if(any(class(result)=="TukeyHSD")) {
			a <- Tukey.format(result)
		}
	else {
		a <- df.format(result)
		}
	return(a)
	}

