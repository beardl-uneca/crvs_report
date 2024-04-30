library(janitor)
library(dplyr)
library(tidyr)
library(lubridate)
library(crvsreportpackage)
library(ggplot2)

print("Reading in Births data")
bth_data <- read.csv("./data/anon_bth_data.csv") |>
  clean_names() |>
  select(agebm, birthwgt, bthimar, dob, dor, esttypeb, gestatn, multbth, multtype, rgn, rgnpob, ru11ind, ru11indpob, sbind, sex_orig)

print("Reading in Deaths data")
dth_data <- read.csv("./data/anon_dth_data.csv") |>
  select(agec, agecunit, ageinyrs, cestrss, cestrssr, dod, dor, dec_stat_dob, esttyped, icd10u,
         icd10uf, i10p001, i10pf001, rgn, rgnpod, ru11ind, ru11indpod, relation, sex_orig)

print("Reading in Birth Estimates data")
bth_est <- read.csv("./data/new_births_est.csv") |>
  filter(!year %in% 2023 )

print("Reading in Death Estimates data")
dth_est <- read.csv("./data/new_deaths_est.csv") |>
  mutate(age_grp = case_when(
    age_grp_85 %in% c("01-04","Under 1") ~ "0-4",
    age_grp_85 %in% c("05-09", "10-14", "15-19", "20-24") ~ "5-24",
    age_grp_85 %in% c("25-29", "30-34", "35-39", "40-44", "45-49", "50-54",
                      "55-59", "60-64", "65-69", "70-74") ~ "25-74",
    age_grp_85 %in% c("75-79", "80-84", "85 and over") ~ "75+", 
    TRUE ~ "check")) |>
  filter(!year %in% 2023 ) 


print("Deriving variables in Births data")
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
           ruindpob = case_when(
             ru11indpob %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
             ru11indpob %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
             TRUE ~ "not stated"),             
           rgn = ifelse(is.na(rgn) | rgn == "", "not stated", rgn),
           reg_delay_days = ifelse(!is.na(dor) & !is.na(dob),
                                   floor(interval(lubridate::ymd(dob),
                                                  lubridate::ymd(dor))/days()), NA),
           usual_res_plocc = case_when(
             rgn == rgnpob ~ "Same as place of occurrence",
             rgnpob == "not stated" ~ "Not stated", 
             rgn != rgnpob ~ "Other location"),
           pob = case_when(
             esttypeb == 1 ~ "hospital",
             esttypeb %in% c(2, 3) ~ "hospital",
             esttypeb %in% c(4, 5, 7) ~ "other",
             esttypeb == 6 ~ "home",
             TRUE ~ "unknown"),
           bthwgt_grp = cut(birthwgt, 
                            breaks = c(0, 500, seq(1000, 4000, 500), 9000, Inf),
                            right = F,
                            labels = c("<500", "500-999", "1,000-1,499",	"1,500-1,999", "2,000-2,499",	
                                       "2,500-2,999",	"3,000-3,499", "3,500-3,999",	"4,000+", "not stated")),
           gest_grp = cut(gestatn, 
                            breaks = c(0,20, 22, 28, 32, 36, 37, 42, 99, Inf),
                            right = F,
                            labels = c("<20", "20-21", "22-27",	"28-31", "32-35",	
                                       "36",	"37-41", "42+", "not stated"))) |>
  mutate(timeliness = case_when(
    reg_delay_days < 30 ~ "Current",
    reg_delay_days %in% c(30:100) ~ "Late", 
    reg_delay_days > 100 ~ "Delayed",
    TRUE ~ "check"),
    fert_age_grp = ifelse(is.na(fert_age_grp), "unknown", fert_age_grp),
    attend = sample(1:5, size = n(), replace = TRUE, prob = seq(1, 0.1, length.out = 5)))
    
bth_data$gest_grp[is.na(bth_data$gestatn)] <- "not stated"

print("Deriving variables in Deaths data")
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
         ruindpod = case_when(
           ru11indpod %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
           ru11indpod %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
           TRUE ~ "not stated"),
         reg_delay_days = ifelse(!is.na(dor) & !is.na(dod),
                                 floor(interval(lubridate::ymd(dod),
                                                lubridate::ymd(dor))/days()), NA),
         usual_res_plocc = case_when(
           rgn == rgnpod ~ "Same as place of occurrence",
           is.na(rgn) ~ "Not stated", 
           rgn != rgnpod ~ "Other location"),
         pod = case_when(
           cestrss == "H" ~ "home", 
           cestrss == "E" ~ "elsewhere",
           esttyped %in% c(1, 18, 99) ~ "hospital",
           esttyped %in% c(2:4, 7, 10, 14, 20:22, 32, 33) ~ "care home",
           esttyped %in% c(82, 83) ~ "elsewhere",
           is.na(esttyped) ~ "Not stated",
           TRUE ~ "other"))  |>
  mutate(timeliness = case_when(
    reg_delay_days < 30 ~ "Current",
    reg_delay_days %in% c(30:100) ~ "Late", 
    reg_delay_days > 100 ~ "Delayed",
    TRUE ~ "check"))


gc()

print("Reading in Population data")
pops <- read.csv("./data/population.csv")

print("Reading in Reference data")
nspl <- read.csv("./data/NSPL_FEB_2024_UK.csv") |>
  distinct(cty, laua, rgn)

pops <- merge(pops, nspl, by.x = "ladcode21", by.y = "laua", all.x = TRUE) |>
  mutate(age_grp_80 = derive_age_groups(age,
                                        start_age = 5, max_band = 80,
                                        step_size = 5, under_1 = TRUE),
         age_grp_wide = cut(age, 
                            breaks = c(0, 5, 25, 75, Inf),
                            right = F,
                            labels = c("00-04", "05-24", "25-74", "75+")),
         age_grp_50 = derive_age_groups(age,
                                        start_age = 15, max_band = 50,
                                        step_size = 5, under_1 = FALSE),
         fert_age_grp = ifelse(sex == "F",
                               derive_age_groups(as.numeric(substr(age, 1, 2)),
                                                 start_age = 15, max_band = 45,
                                                 step_size = 5, under_1 = FALSE),
                               NA))
rm(nspl)

print("Reading in Leading Cause lookup data")
cause <- read.csv("./data/causes.csv")

print("Reading in Marriages data")
marr_data <- read.csv("./data/marriages.csv") |>
  mutate(g_age_grp = derive_age_groups(agegs,
                                       start_age = 15, max_band = 75,
                                       step_size = 5, under_1 = FALSE),
         b_age_grp = derive_age_groups(agebs,
                                       start_age = 15, max_band = 75,
                                       step_size = 5, under_1 = FALSE),
         marcongt = case_when(
           marcong == 1 ~ "Single",
           marcong %in% c(2,3) ~ "Married",
           marcong %in% c(4,5) ~ "Widowed",
           marcong %in% c(7, 9) ~ "Other unions",
           marcong %in% c(6, 10) ~ "Separated",
           marcong %in% c(11, 12) ~ "Divorced",
         TRUE ~ "Not stated"),
         marconbt = case_when(
           marconb == 1 ~ "single",
           marconb %in% c(2,3) ~ "married",
           marconb %in% c(4,5) ~ "widowed",
           marconb %in% c(7, 9) ~ "other unions",
           marconb %in% c(6, 10) ~ "separated",
           marconb %in% c(11, 12) ~ "divorced",
           TRUE ~ "not stated"))

set.seed(12)

print("Reading in Divorces data")
div_data <- read.csv("./data/divorces.csv") |>
  mutate(dom = lubridate::ymd(dom), 
         doda = lubridate::ymd(doda),
         age_w = derive_age_groups(agedaw_yp,
                                       start_age = 15, max_band = 75,
                                       step_size = 5, under_1 = FALSE),
         age_h = derive_age_groups(agedah_op,
                                       start_age = 15, max_band = 75,
                                       step_size = 5, under_1 = FALSE)) |>
  mutate(durmarr = floor(interval(dom, doda )/years(1))) |>
  mutate(dur_grp = case_when(
    durmarr == 0 ~ "<1",
    durmarr %in% c(1:9) ~ as.character(durmarr),
    durmarr %in% c(10:14) ~ "10-14",
    durmarr %in% c(15:19) ~ "15-19",
    durmarr %in% c(20:24) ~ "20-24",
    durmarr %in% c(25:29) ~ "25-29",
    durmarr > 29 ~ "30+",
    TRUE ~ "not stated"))

r_count = nrow(div_data)
div_data <- div_data |>
  mutate(child = sample(c(0:9), replace = TRUE, size = r_count,
                       prob = c(0.4, 0.3, 0.1, 0.05, 0.05, 0.03, 0.02, 0.02, 0.02, 0.01)))
  
gc()

print("Import and derivations complete")
