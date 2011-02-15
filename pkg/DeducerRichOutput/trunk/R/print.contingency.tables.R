print.contingency.tables <- function (tables, digits = 3, prop.r = TRUE, prop.c = TRUE, prop.t = TRUE, 
    expected.n = FALSE, no.tables = FALSE, ...) 
{
    for (i in 1:length(tables)) {
        print(tables[[i]], digits, prop.r, prop.c, prop.t, expected.n, 
            no.tables = no.tables, ...)
    }
	
}
