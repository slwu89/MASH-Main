% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MBITES-Energetics.R
\name{mbites_pSugarBout}
\alias{mbites_pSugarBout}
\title{MBITES-Generic: Probability to Queue Sugar Bout due to Energy Reserves for \code{\link{MosquitoFemale}}}
\usage{
mbites_pSugarBout()
}
\description{
Probability to queue sugar bout as function of energy reserves given by \deqn{ \frac{2+S.sb}{1+S.sb}-\frac{e^{S.sa\times energy}}{S.sb+e^{S.sa\times energy}} }
\itemize{
\item This method is bound to \code{MosquitoFemale$pSugarBout()}.
}
}
