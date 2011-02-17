\name{two.sample.test}
\alias{two.sample.test}

\title{
Over-rides two.sample.test in package Deducer for HTML display
}
\description{
Formats the results of a two-sample test such as a t-test for display in HTML.
}
\usage{
two.sample.test(formula, data = NULL, test = t.test, ...)
}
\arguments{
  \item{formula}{
A formula, the left hand side of which indicated the outcomes, and the right hand side of which contains the factor
}
  \item{data}{
A \code{data.frame}
}
  \item{test}{
A function whose first two arguments are the two-samples to be tested, and whose result is an object of class htest.
}
  \item{\dots}{
further arguments for test
}
}
\details{
This function adds several attributes to the resulting multi.test object from package Deducer's \code{two.sample.test}: the name of the factor, the labels for the factor levels, the name of the outcome variable, and a header giving the output the title \dQuote{Comparison of Two Independent Samples}. It also uses \code{\link{withConditions}} to catch warnings, remove duplicate warnings, and display them at the bottom of the output.
}
\value{
A multi.test object, representing a table of the results of test applied to each of the variables.
}
\author{
Bill Altermatt
}

\seealso{
\code{\link[Deducer]{two.sample.test}}
}

