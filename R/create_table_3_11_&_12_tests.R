
t3.11 <- bth_data |>
  filter(doryr == 2022) |>
  group_by(fert_age_grp) |>
  mutate(fert_age_grp = ifelse(is.na(fert_age_grp), "unknown", fert_age_grp)) |>
  summarise(total = n()) |>
  mutate(grand_total = sum(total)) |>
  mutate(proportion = round_excel((total/grand_total)*100, 2)) 


t3.11 <- t3.11 %>%
  mutate(ukn = filter(., fert_age_grp == 'unknown') %>% select(total)) |>
  mutate(adj_total = total + floor((ukn/100)*proportion)) |>
  select(-c(grand_total, ukn))


write.csv(t3.11, "./t311.csv", row.names = FALSE)

names(t6.12)
