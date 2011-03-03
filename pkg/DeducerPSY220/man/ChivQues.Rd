\name{ChivQues}
\alias{ChivQues}
\docType{data}
\title{
Chivalry (and other gender-role beliefs) Questionnaire Data
}
\description{
Mean responses to 5 gender-role questionnaire measures.
}
\usage{data(ChivQues)}
\format{
  A data frame with 411 observations on the following 7 variables.
  \describe{
    \item{\code{SUBJ}}{Unique subject identification number}
    \item{\code{CHIV}}{Score on a measure of chivalry, the belief that men should protect and provide for women.}
    \item{\code{MVIRT}}{Score on a measure of the belief that women are more \dQuote{morally virtuous} (less inclined to vice) than men are.}
    \item{\code{SVIRT}}{Score on a measure of the belief that women are more \dQuote{sexually virtuous} (less inclined to lust) than men are.}
    \item{\code{AWS}}{Score on the Attitudes toward Women Scale, in which high scores indicate more traditional gender roles and low scores indicate more progressive gender roles.}
    \item{\code{AGENCY}}{Score on a measure of the belief that women are less competent and suited to positions of authority than men are.}
    \item{\code{Gender}}{a factor with levels \code{Male} \code{Female}}
  }
}
\details{
All responses were made on a 1-7 scale with 1 = strongly disagree and 7 = strongly agree.
}
\source{
Altermatt, T. W. (2001). Chivalry: The relation between a cultural script and stereotypes about women. (Doctoral Dissertation). Available online at http://vault.hanover.edu/~altermattw/research/assets/AltermattDissertation.pdf
}

\examples{
data(ChivQues)
}
\keyword{datasets}
