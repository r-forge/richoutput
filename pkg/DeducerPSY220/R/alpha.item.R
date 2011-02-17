# based on code from John Fox's R Commander

 alpha.item <- function(dat) 
 {
	S <- cov(na.omit(dat))
	s <- sqrt(diag(S))
	if ((!is.numeric(S)) || !is.matrix(S) || (nrow(S) != ncol(S))
		|| any(abs(S - t(S)) > max(abs(S))*1e-10) || nrow(S) < 2)
		stop("argument must be a square, symmetric, numeric covariance matrix")
		# making sure that the covariance matrix is square, symmetric, and numeric
	k <- dim(S)[1] #number of rows (equal to number of variables)
	if (k < 3) 
	   {
		warning("there are fewer than 3 items in the scale")
		return(invisible(NULL))
	   }
		S <- cov(na.omit(dat))
	reliab <- function(S)
	  { #S is a covariance matrix and R is a correlation matrix
		k <- dim(S)[1]
		ones <- rep(1, k) # a vector of 1's of length equal to number of variables
		v <- as.vector(ones %*% S %*% ones) #generates a single number
		reliab <- (k/(k - 1)) * (1 - (1/v)*sum(diag(S)))
		reliab
	  }
	
	# Creating an alpha-if-item-deleted matrix
	alpha <- matrix(0, k, 1) #creates a matrix of dimensions k rows and 1 column, made of zeroes
	for (i in 1:k) 
		{
		alpha[i, 1] <- reliab(S[-i, -i]) #computes the reliability omitting each item
		}
	variable <- rownames(S)

	
	pc <- princomp(na.omit(dat)) #principal components analysis of a set of items
	PC1 <- pc$loadings[,1] #loadings on first principal component	
	item.deleted <- data.frame(alpha,PC1)
	o <- order(alpha,decreasing=T)
	item.deleted <- item.deleted[o,]	
	results <- list("total" = reliab(S), "item.deleted" = item.deleted)
	code = "</pre><h2>Reliability</h2>\n"
	code = paste(code,"<p><b>Cronbach's alpha = </b>",formatC(results$total, digits = 5),"</p>\n",sep="")
	code = paste(code,"<h3>Alpha if item deleted</h3\n",sep="")
	code = paste(code,h.df(results$item.deleted, rowcolors=TRUE),"\n",sep="")
	code = paste(code,"<p>Note: <i>N</i> = ",dim(na.omit(dat))[1],". ", dim(dat)[1] - dim(na.omit(dat))[1], " cases removed for missing data</p>\n",sep="")
	code = paste(code,"<pre>\n",sep="")
	return(code)

 }
