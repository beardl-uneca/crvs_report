create_t3.11_and_3.12 <- function(data, date_var, data_year, by_var, tablename = NA, topic = NA){

output <- data |>
  filter({{date_var}} == data_year & if (topic == "births") is.na(sbind) else TRUE) |>
  group_by({{by_var}}) |>
  summarise(total = n()) |>
  mutate(total = ifelse({{by_var}} == "unknown", 200, total))
  
all_out = sum(output$total)

output <- output |>
  mutate(total_count = all_out) |>
  mutate(proportion = round_excel((total/total_count), 2)) |>
  select(-total_count)

na_index <- (output[[quo_name(enquo(by_var))]]== "unknown")
total_na <- sum(output$total[na_index])

output <- output |>
  mutate(adjusted_total =  ifelse({{by_var}} != "unknown",
                                  floor(total + (proportion * total_na)),0))

return(output)
}


t3.11 <- create_t3.11_and_3.12(bth_data, dobyr, data_year = 2022, by_var = fert_age_grp, tablename = "Table_3_11", topic = "births")
t3.12 <- create_t3.11_and_3.12(dth_data, dodyr, data_year = 2022, by_var = age_grp_80, tablename = "Table_3_12", topic = "deaths")
#write.csv(t3.11, "./t311.csv", row.names = FALSE)
