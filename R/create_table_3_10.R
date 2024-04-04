t3.10 <- dth_data |>
  filter(doryr == 2022, sex != "not stated") |>
  group_by(age_grp_wide, sex) |>
  summarise(reg_deaths = n()) 

pop_props <- pops |>
  select(sex, population_2022, age) |>

         year = 2022) |>
  group_by(sex, age_grp_wide, year) |>
  summarise(total = sum(population_2022)) |>
  arrange(age_grp_wide) |>
  pivot_wider(names_from = sex, values_from = total)

f_total <- sum(pop_props$`F`)
m_total <- sum(pop_props$`M`)

pop_props <- pop_props |>
  mutate(female_props = `F`/f_total*100,
         male_props = `M`/m_total*100) |>
  select(-c(`F`, `M`))

d_est_prop<- dth_est |>
  filter(year == 2022) |>
  group_by(year) |>
  summarise(ftotal = sum(female), mtotal = sum(male))

d_est_prop <- merge(pop_props, d_est_prop, by = "year", all.x = TRUE) |>
  mutate(f_prop = floor(ftotal/100*female_props),
         m_prop = floor(mtotal/100*male_props))

  
