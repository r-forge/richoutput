\name{descriptive.table}
\alias{descriptive.table}
\title{
Table of Descriptives
}
\description{
Extends the \code{descriptive.table} function in package Deducer to facilitate HTML output.
}
\usage{
descriptive.table(vars, strata, data, func.names = c("Mean", "St. Deviation", "Median", "25th Percentile", "75th Percentile", "Minimum", "Maximum", "Skew", "Kurtosis", "Valid N"), func.additional)
}
\arguments{
  \item{vars}{
A variable or data.frame containing variables on which to run descriptive statistics.
}
  \item{strata}{
A variable or data.frame containing variables on which to stratify
}
  \item{data}{
The data frame in which vars is evaluated
}
  \item{func.names}{
A character vector of built-in statistics
}
  \item{func.additional}{
A named list of functions. Each function should take a numeric vector as its argument, and return a single value
}
}
\details{
Over-rides the \code{descriptive.table} function in Deducer to produce HTML tables.
Warnings are captured using \code{\link{withConditions}} and printed at the bottom of the table. 
Tables are formatted differently depending upon whether any variables are selected as strata. If no variables are selected as strata, all the variables selected for descriptive statistics are presented in a single table. Otherwise, one table is used for each variable, with the levels of the strata variables presented in the leftmost columns.
}
\value{
Returns the HTML code to render HTML-formatted tables showing descriptive statistics for one set of variables stratified by another set of variables. 
}
\author{
Bill Altermatt
}
