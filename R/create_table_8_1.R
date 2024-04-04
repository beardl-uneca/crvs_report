t8.1b <- bth_data |>
  filter(is.na(sbind) & dobyr %in% c(2018:max(dobyr, na.rm = TRUE))) |>
  group_by(dobyr, sex) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex, values_from = total) |>
  adorn_totals("col")
colnames(t8.1b) <- c("Year_of_Occurrence", "Live_Births_Female", "Live_Births_Male", "NS", "Live_Biths_Total")

t8.1d <- dth_data |>
  filter(dodyr %in% c(2018:max(dodyr, na.rm = TRUE))) |>
  group_by(dodyr, sex) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex, values_from = total) |>
  adorn_totals("col")
colnames(t8.1d) <- c("Year_of_OccurrenceD", "Deaths_Female", "Deaths_Male", "NS",  "Deaths_Total")

t8.1i <- dth_data |>
  filter(ageinyrs < 5 & dodyr %in% c(2018:max(dodyr, na.rm = TRUE))) |>
  group_by(dodyr, sex) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex, values_from = total) |>
  adorn_totals("col")
colnames(t8.1i) <- c("Year_of_OccurrenceI", "Under5_Deaths_Female", "Under5_Deaths_Male", "NS",  "Under5_Deaths_Total")

t8.1 <- cbind(t8.1b, t8.1d, t8.1i) |>
  select(Year_of_Occurrence, Live_Births_Female, Live_Births_Male, Live_Biths_Total, Deaths_Female, Deaths_Male, Deaths_Total, Under5_Deaths_Female, Under5_Deaths_Male, Under5_Deaths_Total)
