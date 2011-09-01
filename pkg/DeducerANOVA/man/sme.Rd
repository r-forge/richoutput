\name{sme}
\alias{sme}
\title{
Compute Simple Main Effects for a 2-way Factorial Design
}
\description{
sme computes t-tests between all possible pairs of levels of one factor at each level of a second factor
}
\usage{
sme(data, dv, test.var, is.within = FALSE, at.var = NULL, var.equal=FALSE,p.adjust.method = "holm")
}
\arguments{
  \item{data}{
The data.frame to be analyzed.
}
  \item{dv}{
A dot object such as .(helping).  The dependent (response) variable.
}
  \item{test.var}{
A dot object such as .(time.pressure).  This is the factor whose levels will be arranged into all possible pairs and compared using a t-test.
}
  \item{is.within}{
Logical value indicating whether test.var is a within-subjects factor, in which case dependent t-tests will be used.
}
  \item{at.var}{
A dot object such as .(messag).  The second factor in the design.  The t-tests on levels of test.var will be conducted AT each level of at.var.
}
  \item{var.equal}{
Logical value indicating whether the variances within the cells of the factorial design are assumed to be equal. This argument is passed to the t.test function.
}
  \item{p.adjust.method}{
A method for computing adjusted p-values.  The default is 'holm'.  See help(p.adjust) for the available options.
}
}
\value{
A data.frame consisting of 7 columns. 
The first column provides the levels of the at.var.  
The second and third columns show the two levels of test.var that will be compared.
The fourth column reports the t statistic.
The fifth column reports the degrees of freedom.
The sixth column reports the unadjusted p-value of the t statistic.
The seventh column reports the p-value adjusted for multiple comparisons. The name of this column reflects the adjustment method.
The data.frame is also assigned attributes that name the data, test.var, at.var, and p.adjust.method.
}
\author{
Bill Altermatt
}
\seealso{
\code{\link{p.adjust}}, \code{\link{t.test}}
}
\examples{
data(Adler)
ad1 <- sme(Adler,.(rating),.(instruction),at.var=.(expectation))
ad1
ad2 <- sme(Adler,.(rating),.(expectation),at.var=.(instruction))
ad2
attributes(ad2)
}
