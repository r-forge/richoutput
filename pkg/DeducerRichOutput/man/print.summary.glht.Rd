\name{print.summary.glht}
\alias{print.summary.glht}

\title{
Print summary output of objects of class glht
}
\description{
Over-rides the print.summary.glht method of package \sQuote{multcomp} to format for HTML display.
}
\usage{
\method{print}{summary.glht}(x, digits = max(3, getOption("digits") - 3), ...)
}
\arguments{
  \item{x}{
Object of class \sQuote{glht}, General Linear Hypothesis Tests
}
  \item{digits}{
Number of significant digits to print
}
  \item{\dots}{
Additional methods passed to print
}
}
\value{
Creates a character vector of length 1 containing HTML code to display the results of a \code{summary} function called on an object of class \sQuote{glht}. Prints the vector to the display using a \code{cat} function.
}
\author{
Bill Altermatt
}
