print.contingency.tables <- function (x, digits = 3, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, 
    expected.n = FALSE, no.tables = FALSE, ...) 
{
	if(!is.null(attr(x,"strata.name"))) strataName <- attr(x,"strata.name")
 	for (i in 1:length(x)) {
		tableName <- names(x)[[i]]
        print(x[[i]], digits, prop.r, prop.c, prop.t, expected.n, 
            no.tables = no.tables, strata.name = strataName, table.name = tableName, ...)
    }
}
