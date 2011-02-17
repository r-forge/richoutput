\name{print.contin.tests}
\alias{print.contin.tests}

\title{
Print objects of class contin.tests in HTML format
}
\description{
Over-rides the print.contin.tests command in package Deducer to format contin.tests objects for HTML display, mostly by putting them in HTML tables.
}
\usage{
\method{print}{contin.tests}(tests, test.digits = 3, ...)
}
\arguments{
  \item{tests}{
Object of class contin.tests.
}
  \item{test.digits}{
Number of significant digits to be displayed in table.
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
