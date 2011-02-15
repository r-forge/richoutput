print.cor.matrix <- function (x, digits = 3, N = TRUE, CI = TRUE, stat = TRUE, p.value = TRUE, 
    ...) 
# x is a list object where the top level elements are the variables, 
# the second-level elements are the "with" variables, and 
# the third-level elements are the statistics generated for each pair of variables
{
	if (is.null(attr(x[[1]][[1]],"N"))) N = FALSE
    if (is.null(x[[1]][[1]]$conf.int)) CI = FALSE
	if (is.null(x[[1]][[1]]$statistic)) stat = FALSE
	if (is.null(x[[1]][[1]]$p.value)) p.value = FALSE
	if (is.null(x[[1]][[1]]$parameter)) param = FALSE else param = TRUE
	
    n1 <- length(x) # number of variables
    n2 <- length(x[[1]]) # number of "with" variables
	num.stats <- sum(N, CI, stat, p.value)+1
	nsmall = 2
	f <- function(x) {formatC(x,digits=digits, format="f")}

	code = "</pre><H1>Correlation</H1>"
	code = paste(code,"<H3>",x[[1]][[1]]$method,"</H3>",sep="")

    r.names <- names(x[[1]]) # names of the "with" variables
    c.names <- names(x) # names of the variables

	code = paste(code,"<TABLE cellspacing = -1> ",sep="")

# column headers
	code = paste(code,"<tr>",sep="")
	header = paste("<th>",c.names,"</th>",collapse="")
	code = paste(code,"<th colspan = 2>&nbsp;</th>",header,"</tr> ",sep="")
	
# iterating over rows
    for (rw in 1:n2) { 	
		if (rw %% 2 == 0) rowshading = "d1" else rowshading = "d0"
		code = paste(code,"<tr class = \"",rowshading,"\">",sep="")
	# row variable label
		code = paste(code,"<td rowspan = ",num.stats,">",r.names[rw],"</td>",sep="")
	# correlation r values
		code = paste(code,"<td>",names(x[[1]][[rw]]$estimate),"</td>",sep="")
		for (co in 1:n1) {
			if (c.names[[co]] == r.names[[rw]]) code = paste(code,"<td rowspan = ",num.stats,">&nbsp;</td>",sep="")
			else code = paste(code,"<td style = \"font-size:",100+round((abs(x[[co]][[rw]]$estimate) - 0.3)*40),"%\">",f(x[[co]][[rw]]$estimate),"</td>",sep="")
		}
		code = paste(code,"</tr>",sep="")
	# CI
		if (CI) {
			code = paste(code,"<tr class = \"",rowshading,"\"><td><i>",
				attr(x[[1]][[rw]]$conf.int,"conf.level")*100,
				"% CI</i></td>",sep="")
			for (co in 1:n1) {
				if (c.names[[co]] != r.names[[rw]]) code = paste(code,"<td>[", 
					f(x[[co]][[rw]]$conf.int[1]),", ", f(x[[co]][[rw]]$conf.int[2]),
					"]</td>",sep="")
			}
			code = paste(code,"</tr>",sep="")
		}
	# N
		if (N) {
			code = paste(code,"<tr class = \"",rowshading,"\"><td><i>N</i></td>",sep="")
			for (co in 1:n1) {
				if (c.names[[co]] != r.names[[rw]]) code = paste(code,"<td>",attr(x[[co]][[rw]],"N"),"</td>",sep="")
			}
			code = paste(code,"</tr>",sep="")
		}
	# statistic(parameter)
		if (stat) {
			code = paste(code,"<tr class = \"",rowshading,"\"><td><i>",
				names(x[[1]][[rw]]$statistic),
				if (param) paste(" (",names(x[[1]][[rw]]$parameter),")",sep=""),
				"</i></td>",sep="")
			for (co in 1:n1) {
				if (c.names[[co]] != r.names[[rw]]) code = paste(code,"<td>",f(x[[co]][[rw]]$statistic),
					if (param) paste(" (",x[[co]][[rw]]$parameter,")",sep=""),
					"</td>",sep="")
			}			
			code = paste(code,"</tr>",sep="")
		}
	# p-value
		if (p.value) {
			code = paste(code,"<tr class = \"",rowshading,"\"><td><i>p-value*</i></td>",sep="")
			for (co in 1:n1) {
				if (c.names[[co]] != r.names[[rw]]) code = paste(code,"<td>",gsub("<","&lt;",format.pval(x[[co]][[rw]]$p.value, eps = 1/10^digits, digits = digits)),"</td>",sep="")
				}
			code = paste(code,"</tr>",sep="")
		}
	}
	code = paste(code,"</TABLE>",sep="")

# Adds some notes at the bottom
	if (p.value) {
		if (!is.null(x[[1]][[1]]$alternative)) {
			code = paste(code,"<p class=\"b\">Notes:</p>",sep="")
			if (!is.null(x[[1]][[1]]$null.value)) { 
		        code = paste(code,"<div>H0: ", names(x[[1]][[1]]$null.value), " = ", x[[1]][[1]]$null.value,"</div>",sep="")
				}
			code = paste(code,"<div>*HA: ",x[[1]][[1]]$alternative,"</div>",sep="")
		}
	}

# Look for warning messages and add them to the code:
	if (!is.null(attr(x,"warnings"))) 
		code = paste(code,attr(x,"warnings"),sep="")

	ti = paste("[corr] ",paste(c.names,collapse=", "), if (!all(r.names == c.names)) paste(" with ", 
		paste(r.names,collapse=", "), sep=""), sep="")
	code = paste(code, "<pre>",sep="")
	results = code
#	h(ti,results)
	cat(results)
	# A way to customize the titles:
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)
}
