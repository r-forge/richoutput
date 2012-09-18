h.result <- function(result, rowcolors = TRUE, digits = 2, nsmall = 2, row.names = FALSE, 
	row.header = "")
	{
	code=""
	if(any(class(result)=="TukeyHSD")) {
			code <- paste(code,h.Tukey(result),sep="")
			return(code)
		}
	else {
		a <- df.format(result)
		}
	return(a)
	}
