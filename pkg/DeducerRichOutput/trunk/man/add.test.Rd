\name{add.test}
\alias{add.test}
\title{Apply a test to a Contingency Tables object}
\description{
Over-rides the \code{add.test} function in package Deducer to facilitate HTML output. 
}
\usage{
add.test(tables, name, htests, types = c("asymptotic", "monte.carlo", "exact"))
}
\arguments{
  \item{tables}{
An object of class contingency.tables
}
  \item{name}{
Name of the test
}
  \item{htests}{
A function or list of functions which take a matrix as its argument and returns an object of class \code{htest}
}
  \item{types}{
A character vector with the same number of items as \code{htests}, indicating what type of test was done
}
}
\details{
In package Deducer, \code{add.test} applies a supplied list of tests to all of the tables in the \code{tables} argument.
The \code{add.test} function in package DeducerRichOutput adds two features to that function: 1. recovering the names of the strata in a multi-strata contingency table and 2. capturing warning messages using \code{\link{withConditions}}
}
\value{
A \code{contingency.tables} object identical to \code{tables}, but with the test applied to each table.
}
\author{
Bill Altermatt
}

\seealso{
\code{\link{add.cross.strata.test}}, \code{\link{chi.squared.test}}, \code{\link{likelihood.test}}, 
\code{\link{fishers.exact.test}}, \code{\link{cor.test}}, \code{\link{kruskal.test}}, \code{\link{withConditions}}
}

