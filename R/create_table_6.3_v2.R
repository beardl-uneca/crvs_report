
output <- dth_data |>
  filter(doryr == 2022 & !substr(fic10und,1,1) %in% c("", "U") & sex == "male") |>
  group_by(substr(fic10und,1,3)) |>
  summarise(total = n()) |>
  rename(causecd = `substr(fic10und, 1, 3)`)  

total_deaths <- sum(output$total)

output <- left_join(output, cause, by = c("causecd" = "code")) |>
  group_by(group, description) |>
  summarise(total = sum(total)) 



  r99_dths <- output |>
    filter(group %in% c("R00:R99"))
  output <- output |>
    filter(!group == "R00:R99")
  
  
  output1 <- output |>
  arrange(desc(total)) |>
  head(10) |>
  mutate(rank = row_number(),
         proportion = round_excel(total/sum(total_deaths)*100,2)) |>
  select(rank, group, description, total, proportion)
  
  output2 <- output |>
    tail(nrow(output)-10) |>
    mutate(group = "-",
           description = "All other causes") |>
    group_by(group, description) |>
    summarise(total = sum(total)) |>
    mutate(proportion = round_excel(total/sum(total_deaths)*100,2))
    

outputtest <- rbind(output1, r99_dths, output2) |>
  adorn_totals("row") |>
  mutate(proportion = round_excel(total/sum(total_deaths)*100,2))

  
  write.csv(output, "./output.csv", row.names = FALSE)
  