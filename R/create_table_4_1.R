# Births summary table

t4.1 <- data_birth |>
  filter(Birth_Outcome == "Alive") |>
  group_by(Sex, Registration_year) |>
  rename(Indicator = Sex) |>
  summarise(Total = n()) |>   
  pivot_wider(names_from = c(Indicator), values_from = Total) |>
  mutate(Total = Male + Female,
         Ratio = round((Male/Female),2))

population <- 120000000

reg_births <- reg_births |>
  mutate(cbr = round((Total/population)*1000, 2)) |>
  t() |>
  row_to_names(1)

reg_births <- as.data.frame(reg_births)
reg_births <- tibble::rownames_to_column(reg_births,"Indicator")

tfr <- data_birth |>
  filter(Mother_Age %in% c(15:49))

