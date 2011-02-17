imputeData <- function(data, variables, idvars = NULL, label, m = 5)
{
	vars <- eval(substitute(variables), data, parent.frame())
	a.out <- amelia(data, m = m, p2s = 0, idvars = idvars)
	imputedData <- a.out$imputations
	mat <- matrix(ncol = sum(a.out$missMatrix), nrow = m)
	for (i in 1:m) {
		mat[i,] <- as.numeric(a.out$imputations[[i]][a.out$missMatrix])
		}
	meanMiss <- apply(mat,2,mean)
	data[a.out$missMatrix] <- meanMiss
	missingRate <- round(colMeans(a.out$missMatrix)*100,2)
	code = "</pre>"
	code = paste(code,"<p><b>Cases after listwise deletion: </b>", sum(rowSums(a.out$missMatrix) == 0), "</p>\n",sep="")
	code = paste(code,"<p><b>Cases after imputation: </b>", nrow(na.omit(a.out$imputations[[1]])), "</p>\n", sep="")
	code = paste(code,"<h2>Percentage of missing data in each variable</h2>\n",sep="")
	code = paste(code,h.m(missingRate),"\n<pre>",sep="")
	results <- list("data" = data, "code" = code)
	return(results)
}
