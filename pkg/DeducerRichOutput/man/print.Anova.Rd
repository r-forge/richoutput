\name{print.anova}
\alias{print.anova}
\alias{print.Anova}

\title{
Print anova or Anova results in HTML
}
\description{
Over-rides the print methods of objects of class anova or Anova for display in HTML
}
\usage{
\method{print}{anova}(x, digits = max(getOption("digits") - 2, 3), signif.stars = getOption("show.signif.stars"), ...)
}
\arguments{
  \item{x}{
Object of class anova
}
  \item{digits}{
Number of significant digits to display
}
  \item{signif.stars}{
Logical indicating whether stars should be printed to flag p-values at conventional levels of statistical significance.
}
  \item{\dots}{
Additional arguments passed to print method.
}
}
\value{
These functions generate a character vector of length 1 consisting of HTML code for displaying the results of Anova or anova. The vector is displayed using a \code{cat} function and the original object is returned invisibly.
}
\author{
Bill Altermatt
}
