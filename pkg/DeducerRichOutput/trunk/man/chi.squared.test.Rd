\name{chi.squared.test}
\alias{chi.squared.test}
\title{
Pearson's Chi-squared Test for Contingency Tables
}
\description{
Extends \code{chi.squared.test} in package Deducer by \code{warning} when expected cell frequences are less than 5.
}
\usage{
chi.squared.test(x, y = NULL, conservative = FALSE, cramers.v.conf = 0.95, simulate.p.value = FALSE, B = 10000)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A vector or a matrix
}
  \item{y}{
A vector that is ignored if x is a matrix and required if x is a vector
}
  \item{conservative}{
If FALSE, the usual chi-squared test is performed and if simulate.p.value=TRUE, the monte carlo mid p-value is returned. Otherwise, Yates' continuity correction is applied, and if simulate.p.value=TRUE the monte carlo conservative p-value is returned
}
  \item{cramers.v.conf}{
The confidence level for the confidence interval around the Cramer's V effect size
}
  \item{simulate.p.value}{
a logical indicating whether to compute p-values by monte carlo simulation
}
  \item{B}{
An integer specifying the number of replicates used in the monte carlo test
}
}
\value{
A list with class \dQuote{htest} containing the following components:
	\item{statistic}{
		the value the chi-squared test statistic.
		}
	\item{parameter}{
		the degrees of freedom of the approximate chi-squared distribution of the test statistic.
		}
	\item{p.value}{
		the p-value for the test.
		}
	\item{method}{
		a character string indicating the type of test performed, and whether Monte Carlo simulation or continuity correction was used.
		}
	\item{data.name}{
		a character string giving the name(s) of the data.
		}
	\item{observed}{
		the observed counts.
		}
	\item{expected}{
		the expected counts under the null hypothesis.
		}
	\item{residuals}{
		the Pearson residuals, (observed - expected) / sqrt(expected).
		}
	\item{estimate}{
		Cramer's V
		}
	\item{conf.int}{
		A confidence interval for Cramer's V
		}
}
\author{
Bill Altermatt
}