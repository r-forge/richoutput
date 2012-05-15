\name{print.freq.table}
\alias{print.freq.table}

\title{
Print frequency tables in HTML
}
\description{
Over-rides the print.freq.table function in package Deducer to format output for HTML
}
\usage{
\method{print}{freq.table}(x, ...)
}
\arguments{
  \item{x}{
An object of class \dQuote{freq.table}, such as that produced by \code{frequencies} in package Deducer.
}
  \item{\dots}{
Additional commands to be passed to the print method.
}
}

\value{
Produces a character vector of length 1 containing HTML code to display a frequency table as produced from the \code{frequency} function. This is printed to the output console using a \code{cat} command.
}

\author{
Bill Altermatt
}

