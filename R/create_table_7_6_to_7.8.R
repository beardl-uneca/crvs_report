t7.6 <- div_data |>
  filter(year == 2019) |>
  group_by(age_w, age_h) |>
  summarise(total = n()) |>
  pivot_wider(names_from = age_w, values_from = total, values_fill = 0) |>
  adorn_totals(c("row", "col"))


t7.7 <- div_data |>
  filter(year == 2019) |>
  group_by(dur_grp, age_h) |>
  summarise(total = n()) |>
  pivot_wider(names_from = age_h, values_from = total, values_fill = 0) |>
  adorn_totals(c("row", "col"))

t7.8 <- div_data |>
  filter(year == 2019) |>
  group_by(dur_grp, age_w) |>
  summarise(total = n()) |>
  pivot_wider(names_from = age_w, values_from = total, values_fill = 0) |>
  adorn_totals(c("row", "col"))