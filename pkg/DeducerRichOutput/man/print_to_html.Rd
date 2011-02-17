\name{print_to_html}
\alias{print_to_html}
\title{
Print object to HTML
}
\description{
Creates the code necessary to display many R objects as HTML tables in DeducerRichOutput.
}
\usage{
print_to_html(x, ...)
}

\arguments{
  \item{x}{
An R Object to be submitted to the \code{xtable} function.
}
  \item{\dots}{
Additional arguments passed to xtable.
}
}
\value{
Creates a character vector of length 1 consisting of HTML code for displaying simple R objects, especially matrices or data.frames, as HTML tables. To have the code display properly in DeducerRichOutput, the code is wrapped in an HTML \sQuote{PRE} tag with the closing tag first and the opening tag last.
}
\author{
Ian Fellows
}