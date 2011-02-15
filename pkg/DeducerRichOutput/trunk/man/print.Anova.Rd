\name{print.anova}
\alias{print.anova}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
print.anova(x, digits = max(getOption("digits") - 2, 3), signif.stars = getOption("show.signif.stars"), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{digits}{
%%     ~~Describe \code{digits} here~~
}
  \item{signif.stars}{
%%     ~~Describe \code{signif.stars} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x, digits = max(getOption("digits") - 2, 3), signif.stars = getOption("show.signif.stars"),
...)
{
code = "</pre>"
if (!is.null(heading <- attr(x, "heading")))
heading <- paste(heading, collapse = "<br/> ")
code = paste(code,"<h1>",heading,"</h1>")
nc <- dim(x)[2L]
if (is.null(cn <- colnames(x)))
stop("'anova' object must have colnames")
has.P <- grepl("^(P|Pr)\\(", cn[nc])
zap.i <- 1L:(if (has.P)
nc - 1
else nc)
i <- which(substr(cn, 2, 7) == " value")
i <- c(i, which(!is.na(match(cn, c("F", "Cp", "Chisq")))))
if (length(i))
zap.i <- zap.i[!(zap.i \%in\% i)]
tst.i <- i
if (length(i <- grep("Df$", cn)))
zap.i <- zap.i[!(zap.i \%in\% i)]
code = paste(code,h.printCoefmat(x, digits = digits, signif.stars = signif.stars,
has.Pvalue = has.P, P.values = has.P, cs.ind = NULL,
zap.ind = zap.i, tst.ind = tst.i, na.print = "", ...))
code = paste(code,"<br/><hr><pre>\n")
cat(code)
invisible(x)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
