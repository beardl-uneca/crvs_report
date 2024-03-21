library(janitor)
library(tidyr)
library(lubridate)

bth_data <- read.csv("D:/anon_bth_data.csv")

bth_data <- clean_names(bth_data)

bth_data <- bth_data |>
    mutate(agebm_grp = derive_age_groups(as.numeric(substr(agebm, 1, 2)),
                                         start_age = 5, max_band = 95,
                                         step_size = 5, under_1 = TRUE),
           fert_age_grp = derive_age_groups(as.numeric(substr(agebm, 1, 2)),
                                            start_age = 15, max_band = 45,
                                            step_size = 5, under_1 = FALSE),
           dobyr = substr(dob, 1, 4),
           doryr = substr(dor, 1, 4),
           ruind = case_when(
             ru11ind %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
             ru11ind %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
             TRUE ~ "not stated")
    )



t4.4 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = multbth, rural_urban = "no" )
t4.5 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = bthimar, rural_urban = "urban" )
t4.6 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = bthimar, rural_urban = "rural" )
