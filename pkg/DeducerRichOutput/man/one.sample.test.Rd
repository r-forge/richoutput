\name{one.sample.test}
\alias{one.sample.test}
\title{
Minor modification to Deducer's one.sample.test to facilitate HTML display
}
\description{
Runs one.sample.test through \code{\link{withConditions}} and adds attributes to the result for outcome variable names, name of the test, and a header for the output.
}
\usage{
one.sample.test(variables, data = NULL, test = t.test, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{variables}{
A variable or dataframe of variables
}
  \item{data}{
The data frame in which variables is evaluated
}
  \item{test}{
A function whose first argument is the sample to be tested, and whose result is an object of class \code{htest}.
}
  \item{\dots}{
further arguments for func
}
}

\value{
A multi.test object, representing a table of the results of test applied to each of the variables. Added to this table are a set of attributes providing information about any warnings, the names of the outcome variables, the name of the test, and a header for the HTML output.
}
\references{
See the documentation for \code{Deducer::one.sample.test} for more information.
}
\author{
Bill Altermatt
}
