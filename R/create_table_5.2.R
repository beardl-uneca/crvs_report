create_t5.2 <- function(data, date_var, data_year){
outputa <- dth_data |>
  #filter({{date_var}} == data_year & substr(rgn,1,1) %in% c("E","W")) |>
  filter(dodyr == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, ruind) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col") |>
  rename(area = ruind)

outputb <- dth_data |>
  filter(dodyr == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, rgn) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col")|>
  rename(area = rgn)

output <- rbind(outputa, outputb)

return(output)
}


t5.2 <- create_t5.2(dth_data, dodyr, 2022)

t5.2a2 <- dth_est |>
  filter(year == 2022 & substr(rgn,1,1) %in% c("E","W")) |>
  group_by(sex_orig, ruind) |>
  summarise(total = sum(count)) |>
  pivot_wider(names_from = sex_orig, values_from = total, values_fill = 0) |>
  adorn_totals("col")