model.details <- function(data, dv, wid, between=NULL, within=NULL, type=3)
{
	header <- as.data.frame(matrix(nrow=6,ncol=2))
	header[,1] <- c("Data:","Dependent variable:","Subject ID:","Between-subjects factor(s):","Within-subjects factor(s):",
		"SS Type:")
	header[,2] <- c(data, as.character(dv), as.character(wid),
		if(is.null(between)) "N/A" else paste(between,collapse=", "), 
		if(is.null(within)) "N/A" else paste(within,collapse=", "),
		type)
	return(header)
	}
