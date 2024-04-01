output <- dth_data |>
  filter(!substr(fic10und,1,1) %in% c("", "U") & sex %in% c("male", "female")) |>
  group_by(doryr, substr(fic10und,1,3)) |>
  summarise(total = n()) |>
  arrange(doryr) |>
  rename(causecd = `substr(fic10und, 1, 3)`)  
  

output <- left_join(output, cause, by = c("causecd" = "code")) |>
  group_by(doryr, description)|>
  summarise(total = sum(total)) |>
  group_by(doryr) |>
  slice_max(order_by = total, n = 10, with_ties = FALSE) |>
  mutate(rank = rank(-total)) |>
  pivot_wider(id_cols = rank, names_from = doryr, values_from = description)



output <- dth_data |>
  filter(doryr == 2022 & !substr(fic10und,1,1) %in% c("", "U") & sex == "male") |>
  group_by(substr(fic10und,1,3)) |>
  summarise(total = n()) |>
  rename(causecd = `substr(fic10und, 1, 3)`)  

total_deaths <- sum(output$total)
other_deaths_sum <- sum(output$total[!(output$group %in% c("R00:R99", output$group))])

output <- left_join(output, cause, by = c("causecd" = "code")) |>
  group_by(group, description) |>
  summarise(total = sum(total)) |>
  arrange(desc(total)) |>
  mutate(rank = row_number(),
         proportion = round_excel(total/sum(total_deaths)*100,2)) |>
  head(10) |>
  select(rank, group, description, total, proportion)




# Append a row with the sum of other deaths
other_deaths_row <- data.frame(group = "Other",
                               description = "Other groups",
                               total = other_deaths_sum,
                               rank = NA,
                               proportion = other_deaths_sum / total_deaths)
  
  write.csv(output, "./output.csv", row.names = FALSE)
  