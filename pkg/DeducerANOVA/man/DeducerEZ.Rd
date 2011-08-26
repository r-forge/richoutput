\name{DeducerEZ}
\alias{DeducerEZ}
\title{
Implementation of some functions from package sQuote(ez) for Deducer
}
\description{
Deducer plug-in enabling the analysis of factorial ANOVA designs, 
including within-subjects and mixed designs. Includes functions for
reshaping within-subjects data from wide to long format.
}
\usage{
DeducerEZ(data, dv, wid, between = NULL, observed = NULL, within = NULL, type = 3, detailed = FALSE, descriptives = FALSE, x = NULL, split = NULL, x_lab = NULL, y_lab = NULL, split_lab = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
A data.frame containing the variables to be analyzed.
}
  \item{dv}{
The dependent variable.
}
  \item{wid}{
A unique identifier for each case or subject in the dataset. Will be converted to factor (with a warning).
}
  \item{between}{
A vector of between-subjects factors to be included in the model.
}
  \item{observed}{
A vector of observed (not manipulated) factors to be included in the model, distinguished only for calculations of generalized eta squared (see Bakeman, 2005).
}
  \item{within}{
A vector of within-subjects factors.  If data are in wide format (one row per subject), the data will need to be converted to long format, in which a new variable is added that identifies the level of the within-subjects factor for a particular observation.
}
  \item{type}{
Type of Sum of Squares, using the SAS sQuote(Type II) or sQuote(Type III) terminology. Type 3 is the default, and tests the effects of each factor by comparing the fit of a model with all the terms to the fit of a model with all the terms except the one being tested.  To provide results comparable to those produced by SPSS and SAS, DeducerEZ stipulates options(contrasts=c(contr.sum,contr.poly)).
}
  \item{detailed}{
Logical.  Should detailed output, including Sum of Squares for each factor, be provided?  Default is FALSE.
}
  \item{descriptives}{
Logical.  Should descriptive statistics for the model be provided, via ezStats()?  Default is FALSE.
}
  \item{x}{
Variable to be plotted along the x-axis.  If blank, no plot is generated.
}
  \item{split}{
Variable to be used in the legend.  Can be left blank to create a plot with just one factor.
}
  \item{x_lab}{
Character string used for the label of the x-axis.
}
  \item{y_lab}{
Character string used for the label of the y-axis.
}
  \item{split_lab}{
Character string used for the label of the legend.
}
}
\details{

}
\value{
Returns a list of data.frames.  
\item{Model Details }{ a summary of the model details.}
\item{ANOVA }  {The second is the results of the ANOVA, including SS if they are requested in sQuote(detailed).}
\item{Levene's test } {The third can be Levene's test for equality of variances if there are only between-subjects factors.}
\item{Descriptives } {If they are requested, the last item is descriptive statistics: N, mean, SD, and Fisher's Least Significant Difference. See documentation from ezANOVA on its interpretation.}
}
\references{
Bakeman, R. (2005). Recommended effect size statistics for repeated measures designs. Behavior Research Methods, 37 (3), 379-384.
}
\author{
Bill Altermatt
}

\seealso{
\code{\link{ezANOVA}}, \code{\link{ezStats}} 
}
\examples{

##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(data, dv, wid, between = NULL, observed = NULL,
within = NULL, type = 3, detailed = FALSE, descriptives = FALSE,
x = NULL, split = NULL, x_lab = NULL, y_lab = NULL, split_lab = NULL)
{
options(contrasts=c("contr.sum","contr.poly"))
to_return = list()
header <- as.data.frame(matrix(nrow=7,ncol=2))
header[,1] <- c("Data:","Dependent variable:","Subject ID:","Between-subjects factor(s):","Within-subjects factor(s):",
"Observed variable(s):","SS Type:")
header[,2] <- c(as.character(substitute(data)),as.character(dv), as.character(wid),
if(is.null(between)) "N/A" else paste(between,collapse=", "),
if(is.null(within)) "N/A" else paste(within,collapse=", "),
if(is.null(observed)) "N/A" else paste(observed,collapse=", "),
type)
names(header) <- c("Variable","Value")
to_return$'Model Details' <- header
vars <- as.character(c(wid,dv,between,within,observed))
data <- na.omit(data[,vars])

results <- withConditions(ezANOVA(
data = data
, dv = dv
, wid = wid
, within = within
, between = between
, observed = observed
, diff = NULL
, reverse_diff = FALSE
, type = type
, white.adjust = FALSE
, detailed = detailed
, return_aov = FALSE
))

to_return <- c(to_return,results)
#	if (!is.null(attr(results,"warnings")))	attr(to_return,"warnings") <- attr(results,"warnings")

if(descriptives) {
to_return$'Descriptive Statistics' <- withConditions(ezStats(
data = data
, dv = dv
, wid = wid
, within = within
, between = between # or could be a subset of between
, between_full = between
, diff = NULL
, reverse_diff = FALSE
)
)
  }

class(to_return) = "ez"

print(to_return)

# plot
# Is the x-axis variable one of the within-subjects factors? Still working on this.
xwithin = FALSE
if(!is.null(within)) if(as.character(x) \%in\% as.character(within)) xwithin = TRUE
if(!is.null(x)) {
gg2way(data = substitute(data), x = as.character(x), y = as.character(dv), xwithin = xwithin, split = as.character(split),
x_lab = x_lab, y_lab = y_lab, split_lab = split_lab)
  }

ti = paste("[ANOVA] ",as.character(dv), " ~ ", if(!is.null(between)) paste("btw(",paste(as.character(between),collapse="*"),")",sep=""),
if(!is.null(within)) paste("w/in(",paste(as.character(within),collapse="*"),")",sep=""),sep="")
record <- J("RichOutput.OutputController")$record
elem <- record$getActiveElement()
elem$setTitle(ti)

  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
