\name{print.multi.test}
\alias{print.multi.test}
\title{
Print multi.test object in HTML
}
\description{
Over-rides the print method in package Deducer to format objects of class \dQuote{multi.test} for HTML display.
}
\usage{
\method{print}{multi.test}(x, ...)
}

\arguments{
  \item{x}{
Object of class \dQuote{multi.test}
}
  \item{\dots}{
Additional arguments passed to the print method.
}
}
\value{
This function generates a character vector of length 1 containing HTML code for displaying a multi.test object. The vector is printed via a \code{cat} method.
}

\author{
Bill Altermatt
}
