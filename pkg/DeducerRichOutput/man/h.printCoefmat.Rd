\name{h.printCoefmat}
\alias{h.printCoefmat}
\title{
Modifications of printCoefmat function for HTML output
}
\description{
Writes the printCoefmat \code{Cf} array into an HTML table and formats the p-value legend for HTML. 
}
\usage{
h.printCoefmat(x, digits = max(3, getOption("digits") - 2), signif.stars = getOption("show.signif.stars"), signif.legend = signif.stars, dig.tst = max(1, min(5, digits - 1)), cs.ind = 1:k, tst.ind = k + 1, zap.ind = integer(0), P.values = NULL, has.Pvalue = nc >= 4 && substr(colnames(x)[nc], 1, 3) == "Pr(", eps.Pvalue = .Machine$double.eps, na.print = "NA", ...)
}

\arguments{
  \item{x}{
a numeric matrix like object, to be printed.
}
  \item{digits}{
minimum number of significant digits to be used for most numbers.
}
  \item{signif.stars}{
logical; if \code{TRUE}, P-values are additionally encoded visually as \sQuote{significance stars} in order to help scanning of long coefficient tables. It defaults to the \code{show.signif.stars} slot of \code{\link{options}}.
}
  \item{signif.legend}{
logical; if \code{TRUE}, a legend for the \sQuote{significance stars} is printed provided \code{signif.stars=TRUE}.
}
  \item{dig.tst}{
minimum number of significant digits for the test statistics, see \code{tst.ind}.
}
  \item{cs.ind}{
indices (integer) of column numbers which are (like) coefficients and standard errors to be formatted together.
}
  \item{tst.ind}{
indices (integer) of column numbers for test statistics.
}
  \item{zap.ind}{
indices (integer) of column numbers which should be formatted by \code{\link{zapsmall}}, i.e., by \sQuote{zapping} values close to 0.
}
  \item{P.values}{
logical or NULL; if \code{TRUE}, the last column of \code{x} is formatted by \code{\link{format.pval}} as P values. If \code{P.values = NULL}, the default, it is set to \code{TRUE} only if options(\dQuote{show.coef.Pvalue}) is \code{TRUE} and x has at least 4 columns and the last column name of x starts with \dQuote{Pr(}.
}
  \item{has.Pvalue}{
logical; if \code{TRUE}, the last column of \code{x} contains P values; in that case, it is printed if and only if \code{P.values} (above) is true.
}
  \item{eps.Pvalue}{
number,..
}
  \item{na.print}{
a character string to code \code{NA} values in printed output.
}
  \item{\dots}{
further arguments for \code{\link{print}}.

}
}
\value{
Returns a character vector of HTML-formatted text. This vector consists of the code to render an HTML table of the \code{Cf} coefficients array and, if \code{signif.starts} and \code{signif.legend} are both true, it also includes the code for a legend describing the p-value symbols. 
}

\author{
Bill Altermatt
}

\seealso{
\code{\link{h.df}}
}
