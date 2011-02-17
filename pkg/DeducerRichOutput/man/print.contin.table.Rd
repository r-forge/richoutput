\name{print.contin.table}
\alias{print.contin.table}

\title{
Print object of class contin.table in HTML
}
\description{
Over-rides the print.contin.table function in package Deducer to format a contin.table object for HTML display.
}
\usage{
\method{print}{contin.table}(x, digits = 3, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, expected.n = FALSE, residuals = FALSE, std.residuals = FALSE, adj.residuals = FALSE, no.tables = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
An object of class \dQuote{contin.table}
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
  \item{residuals}{
Logical indicating whether the residuals, defined as actual frequencies minus expected frequencies, should be printed in each cell.
}
  \item{std.residuals}{
Logical indicating whether standardized residuals, defined as residuals divided by the square root of the expected value, should be displayed in each cell.
}
  \item{adj.residuals}{
Logical indicating whether adjusted residuals should be displayed in each cell.
}
  \item{no.tables}{
Logical indicating that no contingency table should be printed.
}
  \item{\dots}{
Additional commands passed to print function.
}
}
\value{
A character vector of length 1 containing HTML-formatted text designed to display the contingency table.
}
\author{
Bill Altermatt
}
