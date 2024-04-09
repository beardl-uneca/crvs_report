


t3.10 <- dth_data |>
  filter(doryr == 2022, sex != "not stated") |>
  group_by(age_grp_wide, sex) |>
  summarise(reg_deaths = n()) |>
  rename(age_grp = age_grp_wide)

 t3.10_all <- t3.10  |>
   mutate(sex = "total") |>
   group_by(age_grp, sex) |>
   summarise(reg_deaths = sum(reg_deaths))

 t3.10 <- rbind(t3.10_all, t3.10)
 
d_est_prop <- dth_est  |>
  filter(year == 2022 ) |>
  group_by(age_grp) |>
  summarise(female = sum(female), male = sum(male)) |>
  pivot_longer(cols = c(female, male) , names_to = "sex", values_to = "est_count")

d_est_prop_all <- d_est_prop |>
  mutate(sex = "total") |>
  group_by(age_grp, sex) |>
  summarise(est_count = sum(est_count))

d_est_prop <- rbind(d_est_prop_all, d_est_prop)

t3.10 <- merge(t3.10 , d_est_prop, by.x = c("age_grp", "sex"), by.y = c("age_grp","sex"), all.x = TRUE) |>
  mutate(completeness = round_excel((reg_deaths/est_count),2)) |>
  mutate(adjusted = floor((reg_deaths/ completeness))) |>
  select(-c(est_count)) |>
  pivot_wider(names_from = sex, values_from = c(reg_deaths, completeness, adjusted))