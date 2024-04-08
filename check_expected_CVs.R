#devtools::install_github("barcaroli/R2BEAT_work")
# load packages----
library(R2BEAT)


# Definiamo la working directory-----
setwd("S:/Cartelle personali/Funzioni_R_R2BEAT/corretti")
getwd()

#load functions----
source("beat.1CV.R")
source("expected_CV.R")
source("aggrStrata.R")
source("beat.1st_new.R")
source("S:/Cartelle personali/Funzioni_R_R2BEAT/prepareInputToAllocation_beat.1st.R")
load("S:/Cartelle personali/Funzioni_R_R2BEAT/sample.RData")
target_vars <- c("active","inactive","unemployed","income_hh")
strata <- prepareInputToAllocation_beat.1st(samp_frame = samp,
                                                     ID = "id_hh",
                                                     stratum = "stratum_label",
                                                     dom = "region",
                                                     target = target_vars)
#R2BEAT:::prepareInputToAllocation_beat.1st
#strata$CENS <- as.numeric(strata$CENS)
#strata$COST <- as.numeric(strata$COST)
#strata$CENS <- 0
cv <- as.data.frame(list(DOM = c("DOM1","DOM2"),
                         CV1 = c(0.05,0.10),
                         CV2 = c(0.05,0.10),
                         CV3 = c(0.05,0.10),
                         CV4 = c(0.05,0.10)))
allocation <- beat.1st(strata,cv)

strata$alloc <- allocation$alloc$ALLOC[-nrow(allocation$alloc)]
exp_cv <- expected_CV(strata,"alloc",cv)
exp_cv
# DOM      cv(Y1)     cv(Y2)     cv(Y3)     cv(Y4)
# 1 DOM1 0.009645186 0.02812719 0.04723967 0.01425832
# 2 DOM2 0.026345422 0.06389087 0.10059817 0.02869631
# 3 DOM2 0.009344995 0.03310534 0.10132011 0.01666350
# 4 DOM2 0.052671236 0.09173203 0.06981259 0.03804857
beat.1cv(strata,cv,allocation$alloc$ALLOC[-nrow(allocation$alloc)])

# TYPE DOMAIN/VAR PLANNED_CV    ACTUAL_CV
# 1  DOM1       1/V1        0.05 0.009645186
# 2  DOM1       1/V2        0.05 0.028127185
# 3  DOM1       1/V3        0.05 0.047239674
# 4  DOM1       1/V4        0.05 0.014258325
# 5  DOM2  center/V1        0.10 0.009344995
# 6  DOM2  center/V2        0.10 0.033105340
# 7  DOM2  center/V3        0.10 0.101320107
# 8  DOM2  center/V4        0.10 0.016663497
# 9  DOM2   north/V1        0.10 0.026345422
# 10 DOM2   north/V2        0.10 0.063890870
# 11 DOM2   north/V3        0.10 0.100598171
# 12 DOM2   north/V4        0.10 0.028696307
# 13 DOM2   south/V1        0.10 0.052671236
# 14 DOM2   south/V2        0.10 0.091732032
# 15 DOM2   south/V3        0.10 0.069812588
# 16 DOM2   south/V4        0.10 0.038048570

allocation$sensitivity
#     Type Dom Var Planned CV   Actual CV Sensitivity 10%
# 2  DOM1   1  V1       0.05 0.009645186               1
# 3  DOM1   1  V2       0.05 0.028127185               1
# 4  DOM1   1  V3       0.05 0.047239674             108
# 5  DOM1   1  V4       0.05 0.014258325               1
# 6  DOM2   1  V1       0.10 0.009344995               0
# 7  DOM2   1  V2       0.10 0.033105340               1
# 8  DOM2   1  V3       0.10 0.101320107             430
# 9  DOM2   1  V4       0.10 0.016663497               1
# 10 DOM2   2  V1       0.10 0.026345422               1
# 11 DOM2   2  V2       0.10 0.063890870               1
# 12 DOM2   2  V3       0.10 0.100598171              82
# 13 DOM2   2  V4       0.10 0.028696307               1
# 14 DOM2   3  V1       0.10 0.052671236               1
# 15 DOM2   3  V2       0.10 0.091732032               1
# 16 DOM2   3  V3       0.10 0.069812588               1
# 17 DOM2   3  V4       0.10 0.038048570               1



