library(janitor)
library(dplyr)
library(tidyr)
library(lubridate)
library(theusefulpackage)

bth_data <- read.csv("./data/anon_bth_data.csv") |>
  clean_names() |>
  select(agebm, birthwgt, bthimar, dob, dor, gestatn, multbth, multtype, rgn, rgnpob, ru11ind, sbind, sex_orig)

dth_data <- read.csv("./data/anon_dth_data.csv") |>
  select(agec, agecunit, ageinyrs, dod, dor, dec_stat_dob, icd10u,
         icd10uf, i10p001, i10pf001, rgn, rgnpod, ru11ind, relation, sex_orig)

bth_est <- read.csv("./data/rgn_bth_est.csv") |>
  filter(!year %in% 2023 ) |>
  mutate(total = male + female)

dth_est <- read.csv("./data/rgn_dth_est.csv") |>
  filter(!year %in% 2023 ) |>
  mutate(total = male + female)

bth_data <- bth_data |>
    mutate(agebm_grp = derive_age_groups(as.numeric(substr(agebm, 1, 2)),
                                         start_age = 5, max_band = 95,
                                         step_size = 5, under_1 = TRUE),
           fert_age_grp = derive_age_groups(as.numeric(substr(agebm, 1, 2)),
                                            start_age = 15, max_band = 45,
                                            step_size = 5, under_1 = FALSE),
           dobyr = as.numeric(substr(dob, 1, 4)),
           doryr = as.numeric(substr(dor, 1, 4)),
           sex = case_when(sex_orig == 1 ~ "male",
                           sex_orig == 2 ~ "female",
                           TRUE ~ "not stated"),
           ruind = case_when(
             ru11ind %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
             ru11ind %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
             TRUE ~ "not stated"),
           rgn = ifelse(is.na(rgn) | rgn == "", "not stated", rgn),
           reg_delay_days = ifelse(!is.na(dor) & !is.na(dob),
                                   floor(interval(lubridate::ymd(dob),
                                                  lubridate::ymd(dor))/days()), NA)) |>
  mutate(timeliness = case_when(
    reg_delay_days < 30 ~ "current",
    reg_delay_days %in% c(30:365) ~ "late", 
    reg_delay_days > 365 ~ "delayed",
    TRUE ~ "check"
  ))


dth_data <- dth_data |>
  mutate(age_grp_95 = derive_age_groups(ageinyrs,
                                        start_age = 5, max_band = 95,
                                        step_size = 5, under_1 = TRUE),
         age_grp_85 = derive_age_groups(ageinyrs,
                                        start_age = 5, max_band = 85,
                                        step_size = 5, under_1 = TRUE),
         age_grp_80 = derive_age_groups(ageinyrs,
                                        start_age = 5, max_band = 80,
                                        step_size = 5, under_1 = TRUE),
         age_grp_75 = derive_age_groups(ageinyrs,
                                        start_age = 5, max_band = 75,
                                        step_size = 5, under_1 = TRUE),
         age_grp_wide = cut(ageinyrs, 
                            breaks = c(0, 4, 24, 74, Inf),
                            right = F,
                            labels = c("0-4", "5-24", "25-74", "75+")),
         age_grp_lead = cut(ageinyrs, 
                            breaks = c(0, 4, 14, 70, Inf),
                            right = F,
                            labels = c("<5", "5-14", "15-69", "70+")),
         dodyr = as.numeric(substr(dod, 1, 4)),
         doryr = as.numeric(substr(dor, 1, 4)),
         dobyr = as.numeric(substr(dec_stat_dob, 1, 4)),
         fic10und = case_when(icd10uf != "" ~ icd10uf, 
                              icd10uf == "" ~ icd10u,
                              i10pf001 != "" ~ i10pf001,
                              i10pf001 == "" ~ i10p001),
         sex = case_when(sex_orig == 1 ~ "male",
                         sex_orig == 2 ~ "female",
                         TRUE ~ "not stated"),
         ruind = case_when(
           ru11ind %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
           ru11ind %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
           TRUE ~ "not stated"),
         reg_delay_days = ifelse(!is.na(dor) & !is.na(dod),
                                 floor(interval(lubridate::ymd(dod),
                                                lubridate::ymd(dor))/days()), NA))  |>
  mutate(timeliness = case_when(
    reg_delay_days < 30 ~ "current",
    reg_delay_days %in% c(30:365) ~ "late", 
    reg_delay_days > 365 ~ "delayed",
    TRUE ~ "check"
  ))


gc()

pops <- read.csv("./data/population.csv")
nspl <- read.csv("./data/NSPL21_FEB_2024_UK.csv") |>
  distinct(cty, laua, rgn)

pops <- merge(pops, nspl, by.x = "ladcode21", by.y = "laua", all.x = TRUE)
rm(nspl)

cause <- read.csv("./data/causes.csv")
gc()
# adjusted counts = registered count / completeness
