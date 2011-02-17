\name{contin.tests.to.table}
\alias{contin.tests.to.table}
\title{
Make an HTML table of contingency test results
}
\description{
Over-rides the contin.tests.to.table function in package Deducer to facilitate HTML rendering
}
\usage{
contin.tests.to.table(tests, test.digits = 3, ...)
}
\arguments{
  \item{tests}{
n object of class \dQuote{contin.tests}, usually 
placed in results[[i]]$tests, where \dQuote{results} is the list object produced
by contingency.tables and i is a combination of one row variable and
one column variable.
}
  \item{test.digits}{
The number of digits to round to
}
  \item{\dots}{
other parameters
}
}
\details{
This function creates a list of matrices, in which the list 
elements correspond to the different strata levels. Each matrix displays 
all the test information for a particular stratum.	It also captures any warnings
using the \code{\link{withConditions}} function.
}
\value{
A nice table
}
\author{
Bill Altermatt
}

