\name{print.cor.matrix}
\alias{print.cor.matrix}

\title{
Prints correlation matrices in HTML
}
\description{
Over-rides the print.cor.matrix method in package Deducer to render the correlation matrix in HTML.
}
\usage{
\method{print}{cor.matrix}(x, digits = 3, N = TRUE, CI = TRUE, stat = TRUE, p.value = TRUE, ...)
}
\arguments{
  \item{x}{
Object of class \code{cor.matrix}
}
  \item{digits}{
Number of significant digits
}
  \item{N}{
Logical indicating whether the number of observations should be printed.
}
  \item{CI}{
Logical indicating whether the confidence interval for the correlation coefficient should be printed.
}
  \item{stat}{
Logical indicating whether the test statistic used for significance testing should be printed.
}
  \item{p.value}{
Logical indicating whether the p-value should be printed.
}
  \item{\dots}{
Additional commands passed to the print method.
}
}

\value{
Uses the \code{cat} function to display a character vector of length 1 containing the code to render a correlation matrix in HTML.
}
\author{
Bill Altermatt
}
