h.Tukey <- function (results, rowcolors = TRUE, digits = 2, nsmall = 2, row.names = FALSE, 
	row.header = "")
	{
	code=""
	for (j in 1:length(results)) {
		code = paste(code,"<h3>",names(results)[[j]],"</h3>",sep="")
		code = paste(code,h.d(as.data.frame(results[[j]]),row.names = TRUE))
		}
	return(code)
	}

h.d <- function(a, rowcolors = TRUE, digits = 3, nsmall = 2, row.names = FALSE, 
	row.header = "",code="")
	{
		if("p" %in% names(a)) {
			a[,"p"] <- format.pval(a[,"p"], digits = 3,eps = .001)
			a[,"p"] <- gsub("<","&lt;",a[,"p"])
			}		
		if("p adj" %in% names(a)) {
			a[,"p adj"] <- format.pval(a[,"p adj"], digits = 3,eps = .001)
			a[,"p adj"] <- gsub("<","&lt;",a[,"p adj"])
			}
		a <- format(a,digits=digits)
		titles = names(a)
		titles = sub("&","&amp;",titles)
		titles = gsub("<","&lt;",titles)
		titles = gsub(">","&gt;",titles)
		cols = length(a)
		rows = dim(a)[1]
		named.rows = row.names
		code = paste(code,"<TABLE cellspacing=-1><tr>",sep="")
		if (named.rows) code = paste(code,"<th valign=\"bottom\">",row.header,"</th>",sep="")
		for (i in 1:cols) {
			code=paste(code,"<th valign=\"bottom\">",titles[i],"</th>",sep="")
			}
		code = paste(code,"</tr>",sep="")
		
		for (j in 1:rows) {
			if (j %% 2 == 0) rowshading = "d1" else rowshading = "d0"
			if (rowcolors) code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
			else code = paste(code,"<tr>",sep="")
			if (named.rows) code = paste(code,"<td><b>",row.names(a)[j],"</b></td>",sep="")			
			for (i in 1:cols) {
				tableRow=paste("<td>",a[[i]][[j]],"</td>",sep="")
				code=paste(code,tableRow,sep="")
				}
			code = paste(code,"</tr>",sep="")
			}
		code = paste(code,"</TABLE>",sep="")
		if(!is.null(attr(a,"warnings"))) code = paste(code,attr(results[i],"warnings"))
		return(code)		
		}

h.results <- function (results, rowcolors = TRUE, digits = 2, nsmall = 2, row.names = FALSE, 
	row.header = "",code="") 
	{	
	for (i in 1:length(results)) {
		code = paste(code,"<h2>",names(results[i]),"</h2>",sep="")
		if(any(class(results[[i]])=="TukeyHSD")) {
			code <- paste(code,h.Tukey(results[[i]]),sep="")
		}
		else if(class(results[[i]])=="data.frame") {
			code <- paste(code,h.d(results[[i]]),sep="")
		}
	}
	return(code)
	}
