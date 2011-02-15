pairedT <- function(data, first, second)
{
	var1 <- eval(substitute(first), data, parent.frame())
	var2 <- eval(substitute(second), data, parent.frame())
	dif <- var1 - var2
	dat <- as.data.frame(cbind(var1,var2,dif))

	result <- as.data.frame(matrix(NA, ncol = 6, nrow = 1))
	colnames(result) <- c("Difference", "95% CI LL", "95% CI UL","t","df","p")
	pair <- t.test(x = var1,y = var2, var.equal = FALSE, paired = TRUE)
	if (pair$p.value < .001) pair$p.value = "&lt; .001"
	result[1,1] <- pair$estimate
	result[1,2] <- pair$conf.int[[1]]
	result[1,3] <- pair$conf.int[[2]]
	result[1,4] <- pair$statistic
	result[1,5] <- pair$parameter
	result[1,6] <- pair$p.value
	code = "</pre>\n"
	code = paste(code,"<h1>Paired t-test</h1>\n")
	code = paste(code,"<h3>Equal variances not assumed (Welch-Satterthwaite df)</h3>\n")
	code = paste(code,h.df(result),"\n")
	code = paste(code,"<p class=\"b\">Notes:</p>\n",sep="")
	code = paste(code,"<div>HA: ",pair$alternative,"</div>",sep="")
	code = paste(code,"<div>H0: ", attr(pair$null.value, "names"), " = ", pair$null.value,"</div>",sep="")
	code = paste(code,"<pre>\n")
	cat(code)

	new.ti = paste(names(dat)[1],"-",names(dat)[2])

	dev.new()
	g <- ggplot() +
		geom_histogram(aes(x = dif),data=dat,alpha = 0.5,binwidth = 1.0,width = 1.0) +
		geom_vline(xintercept = 0.0) +
		geom_vline(colour = "red",xintercept = pair$estimate[[1]]) +
		geom_rect(aes_string(xmin = pair$conf.int[[1]],xmax = pair$conf.int[[2]],ymin = 0,ymax = max(table(dat$dif))),colour = 'red',fill = 'red',alpha = 0.3) +
		scale_x_continuous(name = new.ti) +
		opts(title = 'Distribution of Differences, with Mean and 95% CI')
		
	print(g)
			
	ti <- paste("[paired t-test] ",names(dat)[1]," - ",names(dat)[2],sep="")
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
	
}
