print.htest <- function (x, digits = 4, quote = TRUE, prefix = "", ...) {
code = "</pre>"
# Main title
	if (!is.null(x$method)) 	
		code=paste(code,"<h1>",x$method,"</h1>",sep="")

# Data name
	if (!is.null(x$data.name)) {
			d1 <- unlist(strsplit(x$data.name," and "))
			d2 <- strsplit(d1,"\\$")
			d3 <- sapply(d2,"[[",2)
			code = paste(code,"<h3>",d2[[1]][[1]],": <i>",d3[1],"</i> and <i>",d3[2],"</i></h3>\n",sep="")
		}
	
result <- as.data.frame(matrix(NA, ncol = 1, nrow = 5))
colnames(result)=""
	
# estimate
	if (!is.null(x$estimate)) {
		rownames(result)[1] <- attributes(x$estimate)
		result[1,1] <- format(x$estimate,digits=digits)
		}

# confidence level
	if (!is.null(x$conf.int)) {
		conf.lev <- 100*as.numeric(attributes(x$conf.int))
		rownames(result)[2] <- paste(conf.lev,"% CI",sep="")
		result[2,1] <- paste("(",paste(format(x$conf.int, digits=digits), collapse=","),")",sep="")
		}

# statistic
	if (!is.null(x$statistic)) {
		rownames(result)[3] <- attributes(x$statistic)
		result[3,1] <- format(x$statistic, digits=digits)
		}

# parameter
	if(!is.null(x$parameter)) {
		rownames(result)[4] <- attributes(x$parameter)
		result[4,1] <- x$parameter
		}
# p-value
	if(!is.null(x$p.value)) {
		rownames(result)[5] <- "p-value"
		if (x$p.value < .001) fp <- "&lt; .001"
		else fp <- format(x$p.value, digits = digits)
		result[5,1] <- fp		
		}		

	code = paste(code,h.df(result, rowcolors = TRUE),sep="")
	
# Null hypothesis

	if (!is.null(x$alternative) || !is.null(x$null.value))
		{
		code = paste(code,"<p class=\"b\">Notes:</p>",sep="")
		if (is.character(x$alternative)) {
			code = paste(code,"<div>HA: ",x$alternative,"</div>",sep="")
			}
	    if (!is.null(x$null.value)) { 
	        code = paste(code,"<div>H0: ", attributes(x$null.value), " = ", x$null.value,"</div>",sep="")
			}
		}

# Title:
	ti <- paste(x$method)

# closing pre tag
	code = paste(code,"<pre>",sep="")
		
	results <- code
	
	cat(results)	
	
# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
}
