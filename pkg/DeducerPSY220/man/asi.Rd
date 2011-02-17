\name{asi}
\alias{asi}
\docType{data}
\title{
Ambivalent Sexism Inventory (ASI)
}
\description{
Responses from 261 undergraduates to Glick and Fiske's (1996) Ambivalent Sexism Inventory. Collected during the fall 1998 and spring 1999 semesters at the University of Illinois at Urbana-Champaign. The response scale ranged from 1 to 7 with 1 indicating \dQuote{Strongly Disagree} and 7 indicating \dQuote{Strongly Agree}.
}
\usage{data(asi)}
\format{
  A data frame with 261 observations on the following 25 variables.
  \describe{
    \item{\code{Subj}}{A factor providing a unique identification number for each subject}
    \item{\code{Age}}{Respondent's age in years}
    \item{\code{bss01}}{No matter how accomplished he is, a man is not truly complete as a person unless he has the love of a woman.}
    \item{\code{bss02}}{In a disaster, women ought not necessarily to be rescued before men.}
    \item{\code{bss03}}{People are often truly happy in life without being romantically involved with a member of the other sex.}
    \item{\code{bss04}}{Many women have a quality of purity that few men possess.}
    \item{\code{bss05}}{Women should be cherished and protected by men.}
    \item{\code{bss06}}{Every man ought to have a woman whom he adores.}
    \item{\code{bss07}}{Men are complete without women.}
    \item{\code{bss08}}{A good woman should be set on a pedestal by her man.}
    \item{\code{bss09}}{Women, compared to men, tend to have a superior moral sensibility.}
    \item{\code{bss10}}{Men should be willing to sacrifice their own well being in order to provide financially for the women in their lives.}
    \item{\code{bss11}}{Women, as compared to men, tend to have a more refined sense of culture and good taste.}
    \item{\code{hss01}}{Women are too easily offended.}
    \item{\code{hss02}}{Many women are actually seeking special favors, such as hiring policies that favor them over men, under the guise of asking for \dQuote{equality}.}
    \item{\code{hss03}}{Feminists are making entirely reasonable demands of men.}
    \item{\code{hss04}}{Most women fail to appreciate fully all that men do for them.}
    \item{\code{hss05}}{When women lose to men in fair competition, they typically complain about being discriminated against.}
    \item{\code{hss06}}{Feminists are not seeking for women to have more power than men.}
    \item{\code{hss07}}{Most women interpret innocent remarks or acts as being sexist.}
    \item{\code{hss08}}{Once a woman gets a man to commit to her, she usually tries to put him on a tight leash.}
    \item{\code{hss09}}{There are actually very few women who get a kick out of teasing men by seeming sexually available and then refusing male advances.}
    \item{\code{hss10}}{Women exaggerate problems they have at work.}
    \item{\code{hss11}}{Women seek to gain power by getting control over men.}
    \item{\code{Sex}}{A factor representing sex of respondent, with levels \code{F} and \code{M}}
  }
}
\details{
BSS items 2, 3, and 7 are con-trait items, phrased in the reverse.  HSS items 3, 6, and 9 are also con-trait items.  These items should be reverse-scored before computing a mean.
}
\source{
Altermatt, T. W. (2001). Chivalry: The relation between a cultural script and stereotypes about women. (Doctoral Dissertation). Available online at http://vault.hanover.edu/~altermattw/research/assets/AltermattDissertation.pdf
}
\references{
Glick, P., & Fiske, S. (1996). The Ambivalent Sexism Inventory: Differentiating hostile 
and benevolent sexism. Journal of Personality and Social Psychology, 70, 491-512.
}
\examples{
data(asi)
}
\keyword{datasets}
