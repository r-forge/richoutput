# Simple Main Effects





sme <- function(data,dv, test.var, is.within=FALSE, at.var=NULL, var.equal=FALSE, p.adjust.method="holm") {
	y <- data[,match(dv,names(data))]
	tv <- data[,match(test.var,names(data))]

	comparisons <- t(combn(levels(tv),2))
	if(!is.null(at.var)) {
		av <- data[,match(at.var,names(data))]
		at.rep <- rep(levels(av),each=nrow(comparisons))
		level.m <- cbind(at.rep,comparisons[,1],comparisons[,2])
		av = as.character(av)
		} else {
			level.m <- cbind(comparisons[,1],comparisons[,2])
			}
	c.df <- as.data.frame(level.m, stringsAsFactors=FALSE)
	names(c.df) <- c(if(!is.null(at.var)) as.character(at.var),"i","j")
	tv = as.character(tv)
	if(!is.null(at.var)) {
		tfun3 <- function(i,j,k) t.test(y[tv==i & av==k],y[tv==j & av==k],paired=is.within,var.equal=var.equal)
		tmat <- mapply(tfun3,c.df$i,c.df$j,c.df[[as.character(at.var)]])
		} else{
			tfun2 <- function(i,j) t.test(y[tv==i],y[tv==j],paired=is.within,var.equal=var.equal)
			tmat <- mapply(tfun2,c.df$i,c.df$j)
			}
	c.df$t <- tmat[1,]
	c.df$df <- tmat[2,]
	c.df$p <- tmat[3,]
	c.df$p.adjust <- p.adjust(c.df$p,method=p.adjust.method)
	names(c.df)[length(c.df)] <- paste("p.",p.adjust.method,sep="")
	attr(c.df,"data") <- as.character(substitute(data))
	attr(c.df,"test.var") <- as.character(test.var)
	if(!is.null(at.var)) attr(c.df,"at.var") <- as.character(at.var)
	attr(c.df,"p.adjust.method") <- p.adjust.method
	return(c.df)
	}

	


