% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expected_CV_new.R
\name{expected_CV}
\alias{expected_CV}
\title{expected_CV}
\usage{
expected_CV(strata, errors, alloc)
}
\arguments{
\item{strata}{name of the dataframe containing information in the sampling strata.}

\item{errors}{name of the dataframe}

\item{alloc}{vector containing the allocation of sampling units.}
}
\value{
a dataframe containing the maximum expected coefficients of variation in each domain level for each target variable
}
\description{
Function to report the expected coefficients of variation for target variables Ys in a 'strata' dataset 
given an allocation 'alloc' and the current set of precision constraints
}
\examples{
load("./data/sample.RData")
target_vars <- c("active","inactive","unemployed","income_hh")
strata <- R2BEAT:::prepareInputToAllocation_beat.1st(samp_frame = samp,
                                                     ID = "id_hh",
                                                     stratum = "stratum_label",
                                                     dom = "region",
                                                     target = target_vars)
strata$CENS <- as.numeric(strata$CENS)
strata$COST <- as.numeric(strata$COST)
strata$CENS <- 0
cv <- as.data.frame(list(DOM = c("DOM1","DOM2"),
                         CV1 = c(0.05,0.10),
                         CV2 = c(0.05,0.10),
                         CV3 = c(0.05,0.10),
                         CV4 = c(0.05,0.10)))
allocation <- beat.1st(strata,cv)

alloc <- allocation$alloc$ALLOC[-nrow(allocation$alloc)]
exp_cv <- expected_CV(strata,cv,alloc)
exp_cv

}
