\name{outcome.labels}
\alias{outcome.labels}

\title{
Outcome variable label
}
\description{
Given a character vector of outcome variable names, this function returns a character vector of length 1 containing a brief summary of the first 2 and lists the number of other variables. Used to create titles for output elements in DeducerRichOutput.
}
\usage{
outcome.labels(outcomes)
}
\arguments{
  \item{outcomes}{
Character vector of outcome variable names.
}
}

\value{
Character vector of length 1 providing a summary of the first 2 outcome variables and the number of remaining outcome variables
}

\author{
Bill Altermatt
}
