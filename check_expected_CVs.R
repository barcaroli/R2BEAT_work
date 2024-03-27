devtools::install_github("barcaroli/R2BEAT_work")
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

strata$alloc <- allocation$alloc$ALLOC[-nrow(allocation$alloc)]
exp_cv <- expected_CV(strata,"alloc",cv)
exp_cv
# DOM      cv(Y1)     cv(Y2)     cv(Y3)     cv(Y4)
# 1 DOM1 0.009645186 0.02812719 0.04723967 0.01425832
# 2 DOM2 0.026345422 0.06389087 0.10059817 0.02869631
# 3 DOM2 0.009344995 0.03310534 0.10132011 0.01666350
# 4 DOM2 0.052671236 0.09173203 0.06981259 0.03804857
beat.1cv(strata,cv,allocation$alloc$ALLOC[-nrow(allocation$alloc)])
#    TYPE DOMAIN/VAR PLANNED_CV  ACTUAL_CV
# 1  DOM1       1/V1        0.05    0.0097
# 2  DOM1       1/V2        0.05    0.0290
# 3  DOM1       1/V3        0.05    0.0497
# 4  DOM1       1/V4        0.05    0.0145
# 5  DOM2  center/V1        0.10    0.0095
# 6  DOM2  center/V2        0.10    0.0336
# 7  DOM2  center/V3        0.10    0.0999
# 8  DOM2  center/V4        0.10    0.0177
# 9  DOM2   north/V1        0.10    0.0265
# 10 DOM2   north/V2        0.10    0.0645
# 11 DOM2   north/V3        0.10    0.0995
# 12 DOM2   north/V4        0.10    0.0295
# 13 DOM2   south/V1        0.10    0.0522
# 14 DOM2   south/V2        0.10    0.0919
# 15 DOM2   south/V3        0.10    0.0688
# 16 DOM2   south/V4        0.10    0.0377

