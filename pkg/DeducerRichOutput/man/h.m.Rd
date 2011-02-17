\name{h.m}
\alias{h.m}

\title{
Format matrix into HTML table
}
\description{
Translates an R matrix into an HTML table.
}
\usage{
h.m(x, digits = 3, nsmall = 2)
}

\arguments{
  \item{x}{
A matrix
}
  \item{digits}{
Number of significant digits to be used in \code{format}
}
  \item{nsmall}{
The minimum number of digits to the right of the decimal point in formatting real/complex numbers in non-scientific formats.
}
}
\details{
Converts any matrix rownames or colnames into row and column headers in the table.
}

\value{
A character vector of length 1 containing code for an HTML table.
}
\author{
Bill Altermatt
}
