\name{reshape.long}
\alias{reshape.long}
\title{
  Reshape from Wide to Long Format
}
\description{
Reshape data frames from wide to long format.
}
\usage{
reshape.long <- function(data, varying.list, idvar = "id",
	ids = rownames(data), within.name = "time",
	within.levels = c("colnames","integers"), drop=NULL)
}
\arguments{
  \item{data}{A data frame in wide format.}
  \item{varying.list}{A named list of character vectors. Each vector of this
  	list will contain the names of the variables in \code{data} that
  	correspond to a single variable in the long format, and the name of
  	the vector will be the name of that new variable.}
  \item{idvar}{Name of the variable in \code{data} that identifies each
  	individual, or if that variable does not exist, the name of a newly
  	created variable that will contain that information in long format
  	(assuming that each row of \code{data} is a different individual).}
  \item{ids}{Values to use for a newly created \code{idvar} variable in long
  	format.}
  \item{within.name}{Character string with the name of the within-subjects
  	factor, that will be created in long format for differentiating
  	multiple records from the same individual.}
  \item{within.levels}{What will be the levels of the within-subjects factor
  	(see \emph{Details}).}
  \item{drop}{Variables of \code{data} that will be dropped in long format.}
}
\details{
This is a wrapper of \code{\link{stats::reshape}} with \code{direction="long"}.
It admits duplicated values in \code{idvar}, and the default values of
\code{ids} and \code{times} are different. The argument \code{times} of
\code{reshape} is defined according to the value of \code{within.levels}:
\code{"colnames"} means that \code{times} will be the names of the first set of
variables defined in \code{varying.list}; for \code{"integers"}, they will be a
sequence of integers (as the default value in \code{reshape}).
}
\value{
Reshaped data frame.
}

