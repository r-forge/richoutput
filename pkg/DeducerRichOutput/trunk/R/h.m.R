h.m <- function (x, digits=3, nsmall=2) # Matrix to HTML table
{
	x = as.matrix(x)
	x = format(x,nsmall=nsmall,digits=digits)
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
	code = "<TABLE cellspacing=-1>"
	firstcol = !is.null(rowname) || !is.null(rowlabels)
	if (!is.null(colname)) {
		code = paste(code, "<tr>",sep="")
		if (firstcol) code = paste(code,"<th>&nbsp;</th>",sep="")
		code = paste(code,"<th colspan=",cols,">",colname,"</th></tr>",sep="")
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
		code = paste(code,"<tr>",sep="")
		if (!is.null(rowlabels)) code = paste(code,"<th>",rowlabels[rw],"</th>",sep="")
		for (co in 1:cols) {
			code = paste(code,"<td>",x[rw,co],"</td>",sep="")
			}
		code = paste(code,"</tr>",sep="")
		}
	code = paste(code,"</TABLE>",sep="")
	return(code)
	}
