
t3.4 <- bth_data |>
  filter(!doryr %in% c("", "2023") & is.na(sbind)) |>
  group_by(doryr, sex) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex, values_from = total, values_fill = 0) |>
  adorn_totals("col")

t3.4 <- cbind(t3.4, bth_est[,c(2:4)])
t3.4 <- t3.4 |>
  mutate(male_comp = round_excel((`1`/males)*100, 2),
         female_comp = round_excel((`2`/females)*100, 2),
         total_comp = round_excel((Total/total)*100, 2))



