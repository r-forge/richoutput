\name{k.sample.test}
\alias{k.sample.test}
\title{
Modifications of Deducer's k.sample.test for HTML display
}
\description{
Adds factor name, factor levels, and outcome variable names to output, and makes other formatting changes in preparation for HTML display.
}
\usage{
k.sample.test(formula, data = NULL, test = oneway.test, ...)
}
\arguments{
  \item{formula}{
A formula, the left hand side of which indicated the outcomes, and the right hand side of which contains the factor
}
  \item{data}{
A data.frame
}
  \item{test}{
A function whose first argument is a formula with the outcome on the lhs and the factor on the rhs. The second argument should be the data to be used for the formula. The result of the function should be an object of class \code{htest}.
}
  \item{\dots}{
further arguments for func
}
}

\value{
A \code{multi.test} object, representing a table of the results of \code{func} applied to each of the variables.
}
\references{
http://ifellows.ucsd.edu/pmwiki/pmwiki.php?n=Main.K-SampleTest
}
\author{
Bill Altermatt
}




\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
