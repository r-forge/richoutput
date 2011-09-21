\name{makeMeanDialog}
\alias{makeMeanDialog}
\alias{meanDialog}
\title{
Make the Dialog to Compute the Mean of a Set of Items
}
\description{
Uses the widgets in package Deducer to create an rJava dialog that permits
the user to select variables in a dataset that will be used to compute the
mean of those variables and add the resulting variable to the dataset.
}
\usage{
makeMeanDialog()
}
\details{
Includes a facility for reverse-scoring variables, saving those reverse-scored
variables as part of the dataset, and computing the Cronbach alpha reliability
of the new mean (as well as the alpha-if-item-deleted value for each variable).
}
\value{
The interactive Java-based dialog
}
\author{
Bill Altermatt
}

\seealso{
\code{\link{alpha.item}}, \code{\link{newMean}}, \code{\link{revData}}, 
}
