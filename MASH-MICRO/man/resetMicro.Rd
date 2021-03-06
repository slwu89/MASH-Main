% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Tile-Simulation.R
\name{resetMicro}
\alias{resetMicro}
\title{Reset Tile Between Runs}
\usage{
resetMicro(MosquitoPar, HumanPar, EL4P = FALSE, mating = FALSE,
  incrementID = TRUE)
}
\arguments{
\item{incrementID}{if \code{TRUE} increment the runID by one (do not use if manually setting the runID to keep track of parameters, for example, during Monte Carlo simulation or parameter sweeps)
\itemize{
\item This method is bound to \code{Tile$resetMicro}
}}
}
\description{
Reset Tile Between Runs
}
