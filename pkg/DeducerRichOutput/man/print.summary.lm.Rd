\name{print.summary.lm}
\alias{print.summary.lm}

\title{
Prints summary information for lm objects in HTML format
}
\description{
Over-rides the print.summary.lm method to reformat the results for HTML display.
}
\usage{
\method{print}{summary.lm}(x, digits = max(3, getOption("digits") - 3), symbolic.cor = x$symbolic.cor, signif.stars = getOption("show.signif.stars"), ...)
}

\arguments{
  \item{x}{
Object of class \sQuote{lm}.
}
  \item{digits}{
a logical value indicating whether parameter correlations should be printed.
}
  \item{symbolic.cor}{
logical. If TRUE, print the correlations in a symbolic form (see symnum) rather than as numbers. Effective only if white.adjust is FALSE.
}
  \item{signif.stars}{
logical. If TRUE, flag p-values at several cutpoints (.001, .01, .05, .10) with symbols: ***, **, *, .
}
  \item{\dots}{
Additional parameters passed to print method.
}
}
\value{
This function generates a character vector of length 1 containing HTML code to display summary information on objects of class \sQuote{lm}. This vector is printed via a \code{cat} method.  The \code{lm} object is returned invisibly.
}
\author{
Bill Altermatt
}
