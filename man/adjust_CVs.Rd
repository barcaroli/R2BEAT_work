% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adjust_CVs.R
\name{adjust_CVs}
\alias{adjust_CVs}
\title{adjustCVs}
\usage{
adjust_CVs(target_size, strata, errors)
}
\arguments{
\item{target_size}{desired sample size.}

\item{strata}{the 'strata' dataset.}

\item{errors}{the 'errors' dataset containing the current precision constraints.}
}
\value{
the new 'errors' dataset containing the changed precision constraints
}
\description{
Function to increase or decrease the precision constraints in order to obtain the desired sample size
}
\examples{
data(beat.example)
errors
a <- beat.1st(strata,errors)
sum(a$alloc$ALLOC[-nrow(a$alloc)])
errors_new <- adjust_CVs(9000,strata,errors)
errors_new
}
