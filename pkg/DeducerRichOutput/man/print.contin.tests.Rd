\name{print.contin.tests}
\alias{print.contin.tests}

\title{
Print objects of class contin.tests in HTML format
}
\description{
Over-rides the print.contin.tests command in package Deducer to format contin.tests objects for HTML display, mostly by putting them in HTML tables.
}
\usage{
\method{print}{contin.tests}(x, digits = 3, table.name, strata.name = NULL, ...)
}
\arguments{
  \item{x}{
Object of class contin.tests.
}
  \item{digits}{
Number of digits displayed in printout.
}
  \item{table.name}{
Name of the row and column variables, separated with the word by.
}
  \item{strata.name}{
Name of the stratification variable.
}
  \item{\dots}{
Additional commands to be passed to the print method.
}
}

\value{
Uses function \code{cat} to display a character vector of length 1 that contains the code to display the contin.tests object in HTML.
}
\author{
Bill Altermatt
}
