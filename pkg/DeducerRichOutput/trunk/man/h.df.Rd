\name{h.df}
\alias{h.df}
\title{
HTML Table of a data.frame
}
\description{
Transforms an R data.frame object into code for an HTML table.
}
\usage{
h.df(a, rowcolors = FALSE, digits = 3, nsmall = 2, row.names = TRUE, 
	row.header = "")
}
\arguments{
  \item{a}{
A \code{data.frame} or another object such as a \code{matrix} that can be cast as a \code{data.frame}.
}
  \item{rowcolors}{
Boolean value indicating whether alternate rows should be shaded light blue to facilitate reading. Default is FALSE.
}
  \item{digits}{
From the description for \code{format}: \dQuote{how many significant digits are to be used for numeric and complex \code{x}.} The default is 3, but as the documentation for \code{format} indicates, \dQuote{This is a suggestion: enough decimal places will be used so that the smallest (in magnitude) number has this many significant digits, and also to satisfy \code{nsmall}.}
}
  \item{nsmall}{
From the description for \code{format}: \dQuote{the minimum number of digits to the right of the decimal point in formatting real/complex numbers in non-scientific formats. Allowed values are 0 <= \code{nsmall} <= 20.} The default is 2.
}
  \item{row.names}{
Boolean value indicating whether the data frame includes row names. Default is TRUE.
}
  \item{row.header}{
Label to be placed above the row names, such as \dQuote{variables}. Default is \dQuote{}.
}
}

\value{
Returns a character vector of HTML code that begins with \dQuote{<TABLE>} and ends with \dQuote{/TABLE}. The elements of the HTML code are the elements of the data.frame, including the row and column names if they exist.
}

\author{
Bill Altermatt
}
