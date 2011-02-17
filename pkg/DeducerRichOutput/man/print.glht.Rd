\name{print.glht}
\alias{print.glht}
\title{
Print objects of class glht
}
\description{
Over-rides the print method in package multcomp to print objects of class \dQuote{glht} in HTML.
}
\usage{
\method{print}{glht}(x, digits = max(3, getOption("digits") - 3), ...)
}
\arguments{
  \item{x}{
Object of class \dQuote{glht}
}
  \item{digits}{
Number of significant digits to print.
}
  \item{\dots}{
Additional arguments passed to print method.
}
}
\details{
\code{glht} stands for General Linear Hypothesis Test.
}
\value{
Creates a character vector of length 1 containing HTML code for displaying glht objects. This vector is printed via a \code{cat} command.
}

\author{
Bill Altermatt
}


\seealso{
\code{\link[multcomp]{glht}}
}
