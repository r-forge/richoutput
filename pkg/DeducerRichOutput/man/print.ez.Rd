\name{print.ez}
\alias{print.ez}
\title{
Prints objects of class 'ez' in HTML
}
\description{
Adds a header, transforms the data.frames into HTML tables, wraps it all in a <pre> tag.
}
\usage{
\method{print}{ez}(x, ...)
}
\arguments{
  \item{x}{
An object of class ez, output from the ez package.
}
  \item{\dots}{
Additional arguments passed to print method.
}
}
\value{
Character vector of HTML code suitable for display in HTML.
}

\author{
Bill Altermatt
}
