\name{print.eff}
\alias{print.eff}
\title{
Prints objects of class eff for HTML display
}
\description{
Over-rides the print method for eff objects to improve their display in HTML
}
\usage{
print.eff(x, type = c("response", "link"), ...)
}
\arguments{
  \item{x}{
An object of class \code{eff}
}
  \item{type}{
for linear and generalized linear models, if \dQuote{response} (the default), effects are printed or the vertical axis is labelled on the scale of the response variable; if \dQuote{link}, effects are printed or the vertical axis labelled on the scale of the linear predictor. For polytomous logit models, this argument takes either \dQuote{probability} or \dQuote{logit}, with the former as the default
}
  \item{\dots}{
additional arguments passed to print method
}
}

\value{
Invisibly returns the \code{eff} object. This function also generates a length-1 character vector containing the HTML code to display the effects as a table.
}

\author{
Bill Altermatt
}
\seealso{
\code{summary.eff}
}