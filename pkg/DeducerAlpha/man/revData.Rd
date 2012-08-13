\name{revData}
\alias{revData}
\title{
Reverse-score data
}
\description{
Given a dataset with some variables designated for reverse-scoring and a maximum value for those variables, this function returns a list that includes the dataset with those variables reverse-scored.
}
\usage{
revData(data, variables = NULL, reversed = NULL, max = NULL)
}
\arguments{
  \item{data}{
A data.frame containing the variables in both \code{variables} and \code{reversed}
}
  \item{variables}{
Variables to be retained in the dataset but that do not need to be reverse-scored
}
  \item{reversed}{
Variables to be reverse-scored
}
  \item{max}{
The maximum possible value for \code{reversed}. If the variables in \code{reversed} range from 1 to 7, \code{max} would be 7. Note that all the items must share the same maximum value.
}
}
\details{
Multi-item psychological measures frequently include items that are phrased in 
the reverse of other items. For example, a scale measuring optimism might ask
participants to respond to statements using a 1-7 scale ranging from 1 (strongly
disagree) to 7 (strongly agree) and include both the statement "I expect my
future to be better than my past" (in which case higher values indicate higher
levels of optimism) and the statement "My best days are behind me" (in which case
higher values indicate lower levels of optimism). Simply averaging the responses
to these two statements together would lead to a non-sensical measure of
optimism.  Instead, it is necessary to reverse-score the items that are phrased
in the reverse so that all the items are on a common scale.  Reverse-scoring is
performed using the following formula:  reversed(x) = max(x) + 1 - x.  Using the 
example above, in which the maximum value is 7, the formula becomes:  reversed(x) =
 7 + 1 - x, or reversed(x) = 8 - x.  If the response to the second item above 
was a 1, reverse-scoring the second item would transform the 1 into a 7:  
reversed(1) = 8 - 1 = 7.  Note that this function assumes that all the items
in \code{reversed} share a common scale, such as from 1 to 7.  

}
\value{
A list consisting of:
\item{data}{A data.frame consisting of \code{variables} and reverse-scored
versions of the variables in \code{reversed}, whose variable names have been
appended with \dQuote{.rev}.
}
\item{reversed}{If there are any items in \code{reversed}, a data.frame 
consisting of reverse-scored versions of the variables in \code{reversed},
whose variable names have been appended with \dQuote{.rev}
}

}
\author{
Bill Altermatt
}
