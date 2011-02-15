\name{add.cross.strata.test}
\alias{add.cross.strata.test}
\title{Adds a cross strata test to contingency table output}
\description{
Over-rides add.cross.strata.test() function in package Deducer to facilitate HTML output
}
\usage{
add.cross.strata.test( tables, name, htests, types = c("asymptotic", "monte.carlo", "exact"))
}
\arguments{
\item{tables}{An object of class contingency.tables}
\item{name}{The name of the hypothesis test}
\item{htests}{A function or list of functions which take a three dimensional array as it's argument and returns an object of class \code{htest}}
\item{types}{A character vector with the same number of items as htests, indicating what type of test was done}
}
\details{
Adds two features to the \code{add.cross.strata.test} function in package Deducer: 1. Recovers the name of the strata and 2. Captures warnings using \code{\link{withConditions}}.
}
\value{
A \code{contingency.tables} object identical to \code{tables}, but with the test applied to each table
}
\seealso{ 
\code{\link{add.mantel.haenszel}}, \code{\link{add.test}}, \code{\link{print.contin.tests}}, \code{\link{withConditions}}
}
\author{Bill Altermatt}
