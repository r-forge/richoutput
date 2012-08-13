\name{newMean}
\alias{newMean}
\title{
Computes the Mean of a Set of Variables
}
\description{
Given a set of variables, some of which may need to be reverse-scored, this
function returns a column vector mean of those variables after reverse-scoring those so
designated.  
}
\usage{
newMean(data, variables = NULL, reversed = NULL, max = NULL, label)
}
\arguments{
  \item{data}{
A data.frame containing the variables in both \code{variables} and \code{reversed}
}
  \item{variables}{
Variables to be retained in the dataset but that do not need to be reverse-scored
}
  \item{reversed}{
Variables to be reverse-scored
}
  \item{max}{
The maximum possible value for \code{reversed}. If the variables in \code{reversed} range from 1 to 7, \code{max} would be 7. Note that all the items must share the same maximum value.
}
  \item{label}{
Name to be given to the new mean variable.
}
}
\value{
A named column vector equal to the mean of a combination of \code{variables} and
\code{reversed} after the latter have been reverse-scored.
}
\author{
Bill Altermatt
}

\seealso{
\code{\link{revData}}, \code{\link{apply}}
}
