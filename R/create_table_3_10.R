


t3.10 <- dth_data |>
  filter(doryr == 2022, sex != "not stated") |>
  group_by(age_grp_wide, sex) |>
  summarise(reg_deaths = n()) 

d_est_prop<- dth_est |>
  filter(year == 2022) |>
  group_by(year) |>
  summarise(ftotal = sum(female), mtotal = sum(male))

d_est_prop <- merge(pop_props, d_est_prop, by = "year", all.x = TRUE) |>
  mutate(f_prop = floor(ftotal/100*female_props),
         m_prop = floor(mtotal/100*male_props))

  
