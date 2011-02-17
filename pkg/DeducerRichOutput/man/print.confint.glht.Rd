\name{print.confint.glht}
\alias{print.confint.glht}
\title{
Print confint.glht objects in HTML
}
\description{
Over-rides the print.confint.glht method in package multcomp to format the output for HTML display.
}
\usage{
\method{print}{confint.glht}(x, digits = max(3, getOption("digits") - 3), ...)
}
\arguments{
  \item{x}{
An object of class \dQuote{confint.glht}
}
  \item{digits}{
Number of significant digits to print.
}
  \item{\dots}{
Additional commands passed to print method.
}
}

\value{
A character vector of length 1 containing the code to render the confint.glht object in HTML.
}
\author{
Bill Altermatt
}
