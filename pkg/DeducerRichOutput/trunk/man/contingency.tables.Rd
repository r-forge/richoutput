\name{contingency.tables}
\alias{contingency.tables}
\title{
Contingency Tables
}
\description{
Over-rides \code{contingency.tables} in package Deducer to format for HTML
}
\usage{
contingency.tables(row.vars, col.vars, stratum.var, data = NULL, missing.include = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{row.vars}{
A variable or data frame evaluated in data
}
  \item{col.vars}{
A variable or data frame evaluated in data
}
  \item{stratum.var}{
A variable evaluated in data
}
  \item{data}{
A data.frame
}
  \item{missing.include}{
A logical indicating whether a missing category should be included in the table
}
}
\details{
Extends \code{contingency.tables} in package Deducer by capturing the row, column, and strata names.
}
\value{
A list with class \dQuote{contingency.tables.} Each element of the list is a single contingency table of class \dQuote{contin.table} corresponding to each combination of elements of \code{row.vars} and \code{col.vars} stratified by stratum.var.
}
\author{
Bill Altermatt
}

