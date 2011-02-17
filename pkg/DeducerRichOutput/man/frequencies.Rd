\name{frequencies}
\alias{frequencies}
\title{
Frequency Tables
}
\description{
Over-rides the \code{frequencies} function in package Deducer to capture warning messages.
}
\usage{
frequencies(data, r.digits = 1)
}

\arguments{
  \item{data}{
A \code{data.frame} containing the variables on which to run frequencies
}
  \item{r.digits}{
how many digits should the percentages be rounded to
}
}
\details{
Just like the \code{frequencies} function in package Deducer except it is wrapped in the \code{\link{withConditions}} function to capture warning messages.
}
\value{
Returns a list of freq.table objects. One for each variable in data.
}
\author{
Bill Altermatt
}
