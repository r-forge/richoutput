print.Anova <- function (x, ...) 
{
    code = "</pre>"
    heading <- attr(x, "heading")
    if (!is.null(heading)) 
        code = paste(code, "<h1>", heading, "</h1>\n")
    attr(x, "heading") <- NULL
    res <- format.data.frame(x, ...)
    nas <- is.na(x)
    res[] <- sapply(seq_len(ncol(res)), function(i) {
        x <- as.character(res[[i]])
        x[nas[, i]] <- ""
        x
    })
    code = paste(code, h.df(res, rowcolors = TRUE), "\n")
    code = paste(code, "<pre>\n")
    cat(code)
    invisible(x)
}

print.anova <- function (x, digits = max(getOption("digits") - 2, 3), signif.stars = getOption("show.signif.stars"),
...)
{
code = "</pre>"
if (!is.null(heading <- attr(x, "heading")))
heading <- paste(heading, collapse = "<br/> ")
code = paste(code,"<h1>",heading,"</h1>")
nc <- dim(x)[2L]
if (is.null(cn <- colnames(x)))
stop("'anova' object must have colnames")
has.P <- grepl("^(P|Pr)\\(", cn[nc])
zap.i <- 1L:(if (has.P)
nc - 1
else nc)
i <- which(substr(cn, 2, 7) == " value")
i <- c(i, which(!is.na(match(cn, c("F", "Cp", "Chisq")))))
if (length(i))
zap.i <- zap.i[!(zap.i %in% i)]
tst.i <- i
if (length(i <- grep("Df$", cn)))
zap.i <- zap.i[!(zap.i %in% i)]
code = paste(code,h.printCoefmat(x, digits = digits, signif.stars = signif.stars,
has.Pvalue = has.P, P.values = has.P, cs.ind = NULL,
zap.ind = zap.i, tst.ind = tst.i, na.print = "", ...))
code = paste(code,"<br/><hr><pre>\n")
cat(code)
invisible(x)
}