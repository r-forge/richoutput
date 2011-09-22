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
DeducerEZ(data, dv, wid, between = NULL, observed = NULL, within = NULL, type = 3, detailed = FALSE, descriptives = FALSE, Tukey = FALSE, x = NULL, split = NULL, x_lab = NULL, y_lab = NULL, split_lab = NULL, test.var = NULL, at.var = NULL, var.equal = FALSE, p.adjust.method = "holm")
}
\arguments{
  \item{data}{
A data.frame containing the variables to be analyzed.
}
  \item{dv}{
A dot object such as .(dv). The dependent variable.
}
  \item{wid}{
A dot object such as .(wid). A unique identifier for each case or subject in the dataset. Will be converted to factor (with a warning).
}
  \item{between}{
Dot object such as .(payment,courtesy).  A vector of between-subjects factors to be included in the model.
}
  \item{observed}{
Dot object such as .(status). A vector of observed (not manipulated) factors to be included in the model, distinguished only for calculations of generalized eta squared (see Bakeman, 2005).
}
  \item{within}{
Dot object such as .(time). A vector of within-subjects factors.  If data are in wide format (one row per subject), the data will need to be converted to long format, in which a new variable is added that identifies the level of the within-subjects factor for a particular observation.
}
  \item{type}{
Type of Sum of Squares, using the SAS sQuote(Type II) or sQuote(Type III) terminology. Type 3 is the default, and tests the effects of each factor by comparing the fit of a model with all the terms to the fit of a model with all the terms except the one being tested.  To provide results comparable to those produced by SPSS and SAS, DeducerEZ stipulates options(contrasts=c(contr.sum,contr.poly)).
}
  \item{detailed}{
Logical.  Should detailed output, including Sum of Squares for each factor, be provided?  Default is FALSE.
}
  \item{descriptives}{
Logical.  Should descriptive statistics for the model be provided? Default is FALSE.
}
  \item{Tukey}{
Logical.  If true, Tukey's Honestly Significant Difference for all possible pairs is computed on all between-subjects factors and interactions of between-subjects factors. This is accomplished by first constructing a linear model by crossing all between-subjects factors, calling aov on the lm, and then calling TukeyHSD on the aov.
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
  \item{test.var}{
Dot object such as .(payment) specifying the factor levels which will be compared (in pairs) using the sme (Simple Main Effects) function.
}
  \item{at.var}{
Dot object such as .(courtesy). Levels of test.var will be compared AT each level of at.var. Passed to the sme function.
}
  \item{var.equal}{
Logical value. Are the variances of the cells in the factorial design assumed to be equal? Default is FALSE. Passed to the sme function.
}
  \item{p.adjust.method}{
One of the character vector values of p.adjust.method. See help(p.adjust) for accepted values.
}
}
\value{
Returns a list of data.frames.  
\item{Model Details}{A summary of the model details.}
\item{ANOVA}{The second is the results of the ANOVA, including SS if they are requested in sQuote(detailed).}
\item{Levene's test}{The third can be Levene's test for equality of variances if there are only between-subjects factors.}
\item{Descriptives}{If they are requested, the last item is descriptive statistics: N, mean, SD.}
\item{Tests of Simple Main Effects}{Output from the sme (Simple Main Effects) function. See help(sme) for details.}
}
\references{
Bakeman, R. (2005). Recommended effect size statistics for repeated measures designs. Behavior Research Methods, 37 (3), 379-384.
}
\author{
Bill Altermatt
}
\seealso{
\code{\link{sme)}}
}
