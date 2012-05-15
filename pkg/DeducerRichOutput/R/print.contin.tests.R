print.contin.tests <- function (x, digits = 3, table.name, strata.name = NULL, ...)
{
#	arguments <- as.list(match.call()[-1])
#	if(!is.null(arguments$strata.name)) strata.name <- arguments$strata.name
#	if(!is.null(arguments$table.name)) table.name <- arguments$table.name
#	if(!is.null(arguments$digits)) test.digits <- digits else test.digits = 3
	test.digits = digits
	tests <- x
	matrix.list <- contin.tests.to.table(tests, test.digits, ...)
	code = "</pre><H1>Contingency Table Tests</H1>"
	ncols = dim(matrix.list[[1]])[2]+1
	code = paste(code,"<H3>", 
		 if("Mantel-Haenszel" %in% names(tests)) "Cross-Strata ",
		"Tests for ",table.name,
		if(!is.null(strata.name)) paste(" across levels of ",strata.name),
		"</H3>",sep="")
	for (strat in 1:length(matrix.list)) { # for each level of strata
		code = paste(code,"<TABLE cellspacing = -1>",sep="")
		tab = matrix.list[[strat]]
		if (length(matrix.list) > 1) code = paste(code,"<tr><th class = \"section\" colspan = ",ncols,">Stratum: ",strata.name," = ",names(matrix.list)[strat],"</th></tr>",sep="")
		x = tab
		if (!is.null(dimnames(x))) {
			rowlabels = dimnames(x)[[1]]
			collabels = dimnames(x)[[2]]
			} else {
				rowlabels = NULL
				collabels = NULL
				}
		if (!is.null(names(dimnames(x)))) {
			rowname = names(dimnames(x))[1]
			colname = names(dimnames(x))[2]
			} else {
				rowname = "&nbsp;"
				colname = NULL
				}
		rows = dim(x)[1]
		cols = dim(x)[2]
		firstcol = !is.null(rowname) || !is.null(rowlabels)
		if (!is.null(colname)) {
			code = paste(code, "<tr>",sep="")
			if (firstcol) code = paste(code,"<td>Test</td>",sep="")
			code = paste(code,"<td colspan=",cols,">",colname,"</td></tr>",sep="")
			}
		if (!is.null(collabels)) {
			code = paste(code,"<tr>",sep="")
			if (firstcol) code = paste(code, "<th>",rowname,"</th>",sep="")
			for (column in collabels) {
				code = paste(code,"<th>",column,"</th>",sep="")
				}
			code = paste(code,"</tr>",sep="")
			}
		for (rw in 1:rows) {
			if (rw %% 2 == 0) rowshading = "d1" else rowshading = "d0"
			code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
			if (!is.null(rowlabels)) code = paste(code,"<td>",rowlabels[rw],"</td>",sep="")
			for (co in 1:cols) {
				code = paste(code,"<td>",x[rw,co],"</td>",sep="")
				}
			code = paste(code,"</tr>",sep="")
			}
		code = paste(code,"</TABLE>",sep="")
		# Look for warning messages and add them to the code:
		if (!is.null(attr(x,"warnings"))) {
			warn = paste(attr(x,"warnings"),collapse="") 
			code = paste(code,warn,sep="")
			}
		code = paste(code,"<br>",sep="")
	}
	code = paste(code,"<pre>",sep="")


if("Mantel-Haenszel" %in% names(tests)) ti = "[cross.strata.tests] " else ti = "[contin.table tests] "
ti = paste(ti,if(!is.null(table.name)) table.name, if(length(matrix.list) > 1) paste(" across ",strata.name))
results = code
Rdate = date()
#h(ti, results)
cat(code)
# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
#return(code)	
}
		

		
	
		
