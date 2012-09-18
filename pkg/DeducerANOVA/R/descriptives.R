## Function for calculating descriptive statistics from ANOVA designs
## Note:  dv, between, and within should be dot objects.
## Example:  descriptives(Adler, .(rating), .(instruction,expectation))

descriptives <- function(data,dv,between = NULL,within = NULL)
	{
		temp = idata.frame(cbind(data,ezDV = data[,names(data) == as.character(dv)]))
		descrip <- ddply(temp,structure(as.list(c(between,within)),class = 'quoted')
					,function(x){
						N = length(x$ezDV)
						Mean = mean(x$ezDV)
						SD = sd(x$ezDV)
						LL = Mean-(qt(0.975,N)*SD/sqrt(N))
						UL = Mean+(qt(0.975,N)*SD/sqrt(N))
						return(c(N = N, Mean = Mean, SD = SD, "95%CI LL" = LL, "95%CI UL" = UL))
						}
					)
	return(descrip)
	}