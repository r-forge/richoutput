\name{alpha.item}
\alias{alpha.item}
\title{
Alpha-if-item-deleted
}
\description{
Computes Cronbach's alpha, alpha if item deleted, and loading on the first principal component for a set of variables in a dataset
}
\usage{
alpha.item(dat)
}
\arguments{
  \item{dat}{
A data.frame.
}
}
\value{
A character vector of HTML code that reports Cronbach's alpha for the set of items and a table with the following information for each item:
\item{alpha}{Cronbach's alpha of the scale with that item removed
}
\item{PC1}{Loading on the first principal component. Useful for spotting items that need to be reverse-scored.
}
}
\author{
Bill Altermatt
}
\note{
Alpha calculations are based on code for computing reliability from John Fox's R Commander
}

