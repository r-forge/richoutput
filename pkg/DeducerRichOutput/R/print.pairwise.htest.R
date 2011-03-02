print.pairwise.htest <- function (x, ...) 
{
    code = "</pre>\n"
	code = paste(code,"<h3>Pairwise comparisons using", x$method,"</h3>\n")
    code = paste(code,"<h3>data: ", x$data.name, "</h3>\n")
    pp <- gsub("<","&lt;",format.pval(x$p.value, digits=3, eps=.001, na.form = "-"))
    attributes(pp) <- attributes(x$p.value)
    code = paste(code,h.df(pp),"\n")
    code = paste(code,"<p><i>p</i>-value adjustment method:", x$p.adjust.method,"</p>\n")
	code = paste(code,"<pre>\n")
	cat(code)
}
