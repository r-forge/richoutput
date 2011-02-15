\name{print.summary.eff}
\alias{print.summary.eff}
\title{
Print summary.eff objects for HTML display
}
\description{
Over-rides the print.summary.eff method to display the summary.eff objects in HTML.
}
\usage{
\method{print}{summary.eff}(x, ...)
}
\arguments{
  \item{x}{
An object of class \code{summary.eff}
}
  \item{\dots}{
Additional arguments passed to print method.
}
}
\value{
Invisibly returns the object. Displays the means and, if available, lower and upper 95% confidence intervals for the specified factors or factor combinations in a linear model.
}
\author{
Bill Altermatt
}
