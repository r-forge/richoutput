\name{GoodSamaritan}
\alias{GoodSamaritan}
\docType{data}
\title{
Simulation of Darley and Batson's (1973) Good Samaritan Experiment
}
\description{
Level of helping given by seminary students in three levels of time pressure and two levels of message topic.
}
\usage{data(GoodSamaritan)}
\format{
  A data frame with 40 observations on the following 3 variables.
  \describe{
    \item{\code{messag}}{factor indicating whether seminary student subject was on their way to deliver speech on the parable of the Good Samaritan or on jobs for seminary graduates}
    \item{\code{time.pressure}}{factor indicating degree of time pressure, either low, medium, or high}
    \item{\code{helping}}{Integer between 0 and 5 indicating degree of helping, with higher values indicating more helping.}
    \item{\code{subj}}{Subject identification number, an integer from 1 to 40.}
  }
}
\details{
After the first part of a study in which they were participating, seminary students were told that they needed to next walk to another building to give a short speech. The time pressure to get to the other building and the content of the speech were manipulated. The content of the speech was either on the topic of the jobs for which seminary students were well-suited, or on the parable of the Good Samaritan from the Christian New Testament. That parable centers around a man who is beaten and robbed, neglected by several passersby, and then helped by a member of a stigmatized outgroup: a Samaritan.  Time pressure was manipulated by telling subjects either that they had plenty of time (low), that the assistant was ready for them (medium), or that they were late (high).
These data are simulated based on the means reported in Darley and Batson's article.  They reflect the general pattern of results and the statistical conclusions but are not the actual data nor do they reproduce the means obtained by Darley and Batson.
}
\source{
Darley, J., & Batson, C. D. (1973). "From Jerusalem to Jericho": A study of situational and dispositional variables in helping behavior. Journal of Personality and Social Psychology, 27, 100-108.
}

\examples{
data(GoodSamaritan)
}
\keyword{datasets}
