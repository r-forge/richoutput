print.contin.table <- function (x, digits = 3, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, 
    expected.n = FALSE, residuals = FALSE, std.residuals = FALSE, 
    adj.residuals = FALSE, no.tables = FALSE, strata.name, table.name, ...) 
{
	# Note: x is the 2nd level of the results of contingency.tables:  results[[i]]
    tab <- x
	nsmall = 2
	f <- function(x) {format(x,nsmall=nsmall,digits=digits)}
	optionRowsN = sum(c(prop.r, prop.c, prop.t, expected.n, residuals, std.residuals, 
		adj.residuals), na.rm = TRUE)
	code = "</pre>"
#	if (!is.null(attr(tab,"strata.name"))) strata.name = attr(tab,"strata.name")
#		else strata.name = NULL
	RowName <- names(dimnames(tab[[1]]$table))[1] 
    ColName <- names(dimnames(tab[[1]]$table))[2] 
	if (!no.tables) {
		code = paste(code,"<H1>Contingency Tables</H1>")
		code = paste(code,"<H3>", RowName, " by ", ColName,
			if(!is.null(strata.name)) paste(" across levels of ",strata.name),
			"</H3>",sep="")   
		}
    s.tables = sum(sapply(tab, function(x) class(x) == "single.table")) # num of contin.table elements
	for (index in 1:s.tables) {
        if (no.tables) next
	    t <- tab[[index]]$table
	    RS <- tab[[index]]$row.sums
	    CS <- tab[[index]]$col.sums
	    CPR <- tab[[index]]$row.prop
	    CPC <- tab[[index]]$col.prop
	    CPT <- tab[[index]]$total.prop
	    GT <- tab[[index]]$total
	    expected <- tab[[index]]$expected
		residual <- f((t - expected))
	    ASR <- (t - expected)/sqrt(expected * ((1 - RS/GT) %*% 
	        t(1 - CS/GT)))
	    StdR <- f((t - expected)/sqrt(expected))

		RowLabels = dimnames(t)[[1]] 
		ColLabels = dimnames(t)[[2]] 
		nrows = dim(t)[1]
		ncols = dim(t)[2]		
		code = paste(code,"<TABLE cellspacing = -1>")
		if (names(tab)[index] != "No Strata") 
            { 
			strata.level = names(tab)[index] 
			code = paste(code,"<tr><th class = \"section\" colspan = ",ncols+3,">Stratum: ",if(!is.null(strata.name)) strata.name," = ",strata.level,"</th></tr> ",sep="")			
			}			
		code = paste(code,"<tr><th colspan = 2>&nbsp;</th><th colspan = ",ncols,">",ColName,"</th><th>&nbsp;</th></tr> ",sep="")
		code = paste(code,"<tr><th colspan = 2>",RowName,"</th>",sep="")
			for (column in ColLabels) {
				code = paste(code,"<th>",column,"</th>",sep="")
				}
			code = paste(code,"<th>Row Total</th></tr> ",sep="")
		for (rw in 1:nrows) {
			if (rw %% 2 == 0) rowshading = "d0" else rowshading = "d1"
			code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
			code = paste(code,"<td align = \"center\" rowspan = ",optionRowsN+1,">",RowLabels[rw],"</td>",sep="")
			code = paste(code,"<td>Count</td>",sep="")
			for (co in 1:ncols) {
				code = paste(code,"<td>",t[rw,co],"</td>",sep="")
				}
			code = paste(code,"<td>",RS[rw],"</td></tr> ",sep="")
			if (prop.r) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Row %</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(CPR[rw,co]*100),"%</td>",sep="")
					}
				code = paste(code,"<td>",f(100 * RS[rw]/GT),"%</td></tr> ",sep="")
				}
			if (prop.c) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Column %</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(CPC[rw,co]*100),"%</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")
				}
			if (prop.t) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Total %</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(CPT[rw,co]*100),"%</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")
				}
			if (expected.n) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Expected</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(expected[rw,co]),"</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")	
				}
			if (residuals) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Residual</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(residual[rw,co]),"</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")	
				}
			if (adj.residuals) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Adj Resid</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(ASR[rw,co]),"</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")	
				}
			if (std.residuals) {
				code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
				code = paste(code,"<td>Std Resid</td>",sep="")
				for (co in 1:ncols) {
					code = paste(code,"<td>",f(StdR[rw,co]),"</td>",sep="")
					}
				code = paste(code,"<td>&nbsp;</td></tr> ",sep="")	
				}
			}
		code = paste(code,"<tr><th colspan = 2>Column Total</th>",sep="")
		for (co in 1:ncols) {
			code = paste(code,"<td>",CS[co],"</td>",sep="")
			}
		code = paste(code,"<td><b>",GT,"</b></td></tr> ",sep="")
		if (prop.c) {
			code = paste(code,"<tr><th colspan = 2>Column %</th>",sep="")
			for (co in 1:ncols) {
				code = paste(code,"<td>",f(CS[co]/GT*100),"%</td>",sep="")
				}
			code = paste(code,"<td>&nbsp;</td></tr> ",sep="")
			}
		code = paste(code,"</TABLE><br>",sep="")		
		}
	ti = paste("[contin.table] ",RowName," by ",ColName,
		if (!is.null(strata.name)) " by ",strata.name,sep="")
	code = paste(code,"<pre>",sep="")
	results = code
	cat(results)
	# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
	# Now print out any tests that might be present:
	if (length(tab) > s.tables) {
		for (t in (s.tables + 1):length(tab)) {
			print(tab[[t]],digits=digits,strata.name=strata.name,table.name=table.name,...)
		}
	}
}
	
	
		
