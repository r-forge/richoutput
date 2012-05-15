\name{withConditions}
\alias{withConditions}
\title{
A function to capture warnings and errors for HTML output
}
\description{
Evaluates an R expression using \code{withCallingHandlers}. If any warnings are returned, they are attached to the value of the expression as attributes.
}
\usage{
withConditions(expr)
}

\arguments{
  \item{expr}{
Any R expression.
}
}
\details{
The function \code{\link{unique}} is used to remove duplicate warnings so that only one copy of each warning is printed.
}
\value{
The evaluated expression, with any warnings attached to the value as attributes.
}
\author{
Bill Altermatt
}

