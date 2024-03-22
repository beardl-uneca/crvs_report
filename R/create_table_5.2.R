
t5.2a <- dth_data |>
  filter(doryr == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, ruind) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col")

t5.2b <- dth_data |>
  filter(doryr == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, rgn) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col")

t5.2a2 <- dth_est |>
  filter(doryr == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, ruind) |>
  summarise(total = sum(count)) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col")