print.eff <- function (x, type = c("response", "link"), ...) 
{
	code = "</pre>"
	code = paste(code, "<h2>",gsub(":", "*", x$term), "effect</h2>")
    type <- match.arg(type)
    if (type == "response") 
        x$fit <- x$transformation$inverse(x$fit)
    table <- array(x$fit, dim = sapply(x$variables, function(x) length(x$levels)), 
        dimnames = lapply(x$variables, function(x) x$levels))
	code = paste(code,h.m(table))
    if (x$discrepancy > 0.001) 
        code = paste(code,"<p>Warning: There is an average discrepancy of", 
            round(x$discrepancy, 3), "percent in the 'safe' predictions for effect", 
            x$term, "</p>"))
	code = paste(code,"<pre>")
	cat(code)
    invisible(x)
}