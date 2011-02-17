\name{cor.matrix}
\alias{cor.matrix}
\title{
Correlation Matrix
}
\description{
Over-rides the \code{cor.matrix} function in package Deducer to facilitate HTML rendering.
}
\usage{
cor.matrix(variables, with.variables, data = NULL, test = cor.test, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{variables}{
variables
}
  \item{with.variables}{
An optional set of variables to correlate with \code{variables}. If nothing is specified, all variables in\code{variables} are correlated with themselves.
}
  \item{data}{
A data.frame from which the variables and factor will be selected.
}
  \item{test}{
A function whose first two arguments are the variables upon which the correlation will be calculated, and whose result is an object of class dQuote{htest}.
}
  \item{\dots}{
further arguments for \code{test}.
}
}
\details{
Runs the \code{cor.matrix} function from package Deducer through the \code{\link{withConditions}} function to capture warning messages for HTML printing.
}
\value{
Returns an object of class \dQuote{cor.matrix}, which is a named list of named lists.  At the top level are list elements corresponding to each variable in the correlation matrix.  With n variables, there are n elements in the top list.  Each of those list elements is itself a list made up of n elements.  Each of those elements is an dQuote{htest} list object similar to the t-test list object.
}
\author{
Bill Altermatt
}
