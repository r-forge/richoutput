\name{print.contingency.tables}
\alias{print.contingency.tables}

\title{
Prints objects of class contingency.tables for HTML display
}
\description{
Over-rides the print.contingency.tables function in package Deducer to render contingency.tables objects in HTML
}
\usage{
\method{print}{contingency.tables}(tables, digits = 3, prop.r = TRUE, prop.c = TRUE, prop.t = TRUE, expected.n = FALSE, no.tables = FALSE, ...)
}
\arguments{
  \item{tables}{
Object of class \dQuote{contingency.tables}
}
  \item{digits}{
Number of significant digits to print.
}
  \item{prop.r}{
Logical indicating whether the proportion of row totals should be displayed in each cell.
}
  \item{prop.c}{
Logical indicating whether the proportion of column totals should be displayed in each cell.
}
  \item{prop.t}{
Logical indicating whether the proportion of the grand total should be displayed in each cell.
}
  \item{expected.n}{
Logical indicating whether the expected values, given the row and column totals, should be displayed in each cell.
}
  \item{no.tables}{
Logical indicating that no contingency table should be printed.
}
  \item{\dots}{
Additional commands passed to print function.
}
}
\value{
\code{print.contingency.tables} simply calls a \code{print} method for each of the \code{contin.tables} contained within the \code{contingency.tables} object.
}

\author{
Bill Altermatt
}
