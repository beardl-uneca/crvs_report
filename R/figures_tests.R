
f4.1 <- bth_data |>
  filter(is.na(sbind) & dobyr %in% c((max(dobyr, na.rm = TRUE) - 4):max(dobyr, na.rm = TRUE) - 1)) |>
  group_by(dobyr) |>
  summarise(count = n())


ggplot(f4.1) +
  geom_line(aes(x = dobyr, y = count, group = 1), color = 'blue', size = 1) +
  labs(x = "Year", y = "Number of live births", title = "Registered live births, England & wales, 2018 to 2022") +
  scale_y_continuous(breaks = c(seq(600000, 660000, 5000)),labels=function(x) format(x, big.mark = ",", scientific = FALSE))

                                


f4.2 <- bth_data |>
  filter(is.na(sbind) & dobyr %in% c((max(dobyr, na.rm = TRUE) - 4):max(dobyr, na.rm = TRUE) - 1)) |>
  group_by(dobyr, fert_age_grp) |>
  summarise(count = n())

f4.2b <- bth_data |>
  filter(is.na(sbind) & dobyr %in% c((max(dobyr, na.rm = TRUE) - 4):max(dobyr, na.rm = TRUE) - 1)) |>
  group_by(dobyr) |>
  summarise(count_all = n())


f4.2 <-merge(f4.2, f4.2b, by = "dobyr", all.x = TRUE) |>
  mutate(proportions = round_excel((count/count_all)*100,0)) |>
  select(-c(count, count_all)) |>
  rename(year = dobyr)

level_order <- c("Under 15", "15-19","20-24", "25-29", "30-34", "35-39", "40-44", "45 and over")
  
ggplot(f4.2) +
  geom_line(aes(x = factor(fert_age_grp, level = level_order), y = proportions, group = year, color = year), size = 1) +
  labs(x = "Mother's age (years)",
       y = "Proportion of births (%)",
       title = "Live births by age of mother, England & wales, 2018 to 2022")+
  scale_y_continuous(breaks = c(seq(600000, 660000, 5000)),labels=function(x) format(x, big.mark = ",", scientific = FALSE)) +
  theme(legend.position = "bottom")
