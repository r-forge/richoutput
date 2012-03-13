\name{cab}
\alias{cab}
\docType{data}
\title{
Data from Cooke, Adams, and Buchanan's (2011) study of the effect of race and crime on sentencing
}
\description{
Respondents to an online survey read descriptions of 6 crimes. For each crime, they were asked to rate the likelihood that each of three names committed the crime (1 = least likely, 6 = most likely) where the names were manipulated to suggest race.
}
\usage{data(cab)}
\format{
  A data frame with 32 observations on the following 31 variables.
  \describe{
    \item{\code{Age}}{a numeric vector}
    \item{\code{Ethnicity}}{a factor with levels \code{Caucasian} \code{HIspanic} \code{African American} \code{Other}}
    \item{\code{Gender}}{a factor with levels \code{Male} \code{Female}}
    \item{\code{PC1}}{Property crime (investment fraud) by Caucasian (Wilbur Franks), version 1}
    \item{\code{PA1}}{Property crime (investment fraud) by African American (Tyrone Jones), version 1}
    \item{\code{PH1}}{Property crime (investment fraud) by Hispanic (Eduardo Flores), version 1}
    \item{\code{DH1}}{Drug crime (possession of illegal drugs) by Hispanic (Roberto Ortiz), version 1}
    \item{\code{DC1}}{Drug crime (possession of illegal drugs) by Caucasian (Ian Williams), version 1}
    \item{\code{DA1}}{Drug crime (possession of illegal drugs) by African American (Lamar Wardell), version 1}
    \item{\code{VA1}}{Violent crime (aggravated assault with a deadly weapon) by African American (Rashan Smith), version 1}
    \item{\code{VC1}}{Violent crime (aggravated assault with a deadly weapon) by Caucasian (Greg Adams), version 1}
    \item{\code{VH1}}{Violent crime (aggravated assault with a deadly weapon) by Hispanic (Mario Mendoza), version 1}
    \item{\code{VC2}}{Violent crime (sexual battery of the first degree) by Caucasian (Brandon Walters), version 2}
    \item{\code{VH2}}{Violent crime (sexual battery of the first degree) by Hispanic (Esteban Dominguez), version 2}
    \item{\code{VA2}}{Violent crime (sexual battery of the first degree) by African American (Malik Bryant), version 2}
    \item{\code{PA2}}{Property crime (burglary) by African American (Dion Carter) version 2}
    \item{\code{PC2}}{Property crime (burglary) by Caucasian (Gary Robertson), version 2}
    \item{\code{PH2}}{Property crime (burglary) by Hispanic (Arturo Guitierrez), version 2}
    \item{\code{DH2}}{Drug crime (selling illegal drugs) by Hispanic (Cesar de la Cruz), version 2}
    \item{\code{DC2}}{Drug crime (selling illegal drugs) by Caucasian (Paul Reynolds}
    \item{\code{DA2}}{Drug crime (selling illegal drugs) by African American (Marcellus Hudson)}
    \item{\code{PC}}{The average of PC1 and PC2}
    \item{\code{PA}}{The average of PA1 and PA2}
    \item{\code{PH}}{The average of PH1 and PH2}
    \item{\code{DC}}{The average of DC1 and DC2}
    \item{\code{DA}}{The average of DA1 and DA2}
    \item{\code{DH}}{The average of DH1 and DH2}
    \item{\code{VC}}{The average of VC1 and VC2}
    \item{\code{VA}}{The average of VA1 and VA2}
    \item{\code{VH}}{The average of VH1 and VH2}
    \item{\code{subj}}{Subject identification numbers, integers 1 to 32}
  }
}
\details{
This study was conducted as part of a course project in the winter 2011 semester of 
social psychology at Hanover College. Ally Cooke, Angie Adams, and Raquel Buchanan 
investigated the interaction of race of defendant and type of crime on respondents' perceptions
of how likely each defendant was to have committed the crime. Thirty-two respondents to 
an online survey were presented with a crime category (e.g., "found guilty of investment fraud" and 
rated the likelihood that each of three defendants committed the crime, where 1 = least likely
and 6 = most likely. The crime categories were Property, Drug, and Violent, and the names of 
the defendants were manipulated to suggest race (Caucasian, African-American, and Hispanic).
The design was a 3 (race: Caucasian, Hispanic, African-American) by 3 (crime: Drug, Property,
Violent) completely within-subjects design.
}

\examples{
data(cab)
library(reshape)
cab2 <- melt(data = cab
, measure.vars = c("PC", "PA", "PH", "DC", "DA", "DH", "VC", "VA", "VH"),
, variable_name = "cond"
, na.rm = TRUE
)

names(cab2)[names(cab2)=="value"]<-"sentence"
cab2[c("crime")] <- recode.variables(cab2[c("cond")] , "'PC' -> 'P';'PA' -> 'P';'PH' -> 'P';'DC' -> 'D';'DH' -> 'D';'DA' -> 'D';'VC' -> 'V';'VA' -> 'V';'VH' -> 'V';")
cab2[c("race")] <- recode.variables(cab2[c("cond")] , "'PC' -> 'C';'DC' -> 'C';'VC' -> 'C';'PA' -> 'A';'DA' -> 'A';'VA' -> 'A';'PH' -> 'H';'DH' -> 'H';'VH' -> 'H';")

}
\keyword{datasets}
