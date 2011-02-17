h.df <- function (a, rowcolors = FALSE, digits = 3, nsmall = 2, row.names = TRUE, 
	row.header = "") 
{
	x = as.data.frame(a, row.names = row.names(a))
	x = format(x,nsmall=nsmall,digits=digits)
	titles = names(x)
	titles = sub("&","&amp;",titles)
	titles = gsub("<","&lt;",titles)
	titles = gsub(">","&gt;",titles)
	cols = length(x)
	rows = dim(x)[1]
	# if all(row.names(x) == as.character(1:nrow(x))), then the row names are just
	# increasing integers, not meaningful names.
	# Problem: in lht, the increasing integer row names are used to refer to particular models.
#	named.rows = row.names && !all(row.names(x) == as.character(1:nrow(x)))
	named.rows = row.names
	code = "<TABLE cellspacing=-1><tr>"
	if (named.rows) code = paste(code,"<th valign=\"bottom\">",row.header,"</th>",sep="")
	for (i in 1:cols) {
		code=paste(code,"<th valign=\"bottom\">",titles[i],"</th>",sep="")
		}
	code = paste(code,"</tr>",sep="")
	
	for (j in 1:rows) {
		if (j %% 2 == 0) rowshading = "d1" else rowshading = "d0"
		if (rowcolors) code = paste(code,"<tr class = \"",rowshading,"\">",sep="") 
		else code = paste(code,"<tr>",sep="")
		if (named.rows) code = paste(code,"<td>",row.names(x)[j],"</td>",sep="")			
		for (i in 1:cols) {
			tableRow=paste("<td>",x[[i]][[j]],"</td>",sep="")
			code=paste(code,tableRow,sep="")
		}
		code = paste(code,"</tr>",sep="")
	}
	code = paste(code,"</TABLE>",sep="")
	return(code)
	}
