#' Create Table 4.7
#'
#' @param data data frame being used
#' @param date_var occurrence data variable being used
#' @param data_year year of data
#' @param tablename name of the table being saved as a csv file
#'
#' @return data frames for tabulated versions of Table 4.7
#' @export
#'
#' @import dplyr
#' @import tidyr
#' @import janitor
#' @examples t4.7 <- create_table_4.7(bth_data, doby, 2022, tablename = "Table_4_7")
#' 
create_table_4.7 <- function(data, date_var, data_year = 2022, tablename = NA){
output <- bth_data |>
  filter({{date_var}} == data_year & is.na(sbind)) |>
  group_by(rgnpob, pob, sex) |>
  summarise(total = n()) |>
  pivot_wider(names_from = sex, values_from = total, values_fill = 0) |>
  adorn_totals("col")

outputall <- output |>
  group_by(pob) |>
  summarise(female = sum(female), male = sum(male), `not stated` = sum(`not stated`)) |>
  mutate(rgnpob = "all") |>
  select(rgnpob, pob, female, male, `not stated`) |>
  adorn_totals(c("row", "col"))

outputrgn <- output |>
  group_by(rgnpob) |>
  summarise(female = sum(female), male = sum(male), `not stated` = sum(`not stated`)) |>
  mutate(pob = "total") |>
  select(rgnpob, pob, female, male, `not stated`) |>
  adorn_totals("col")

output <- rbind(output, outputrgn) |>
  arrange(rgnpob)

output <- rbind(toutputall, output)

write.csv(output, paste0("./outputs/", tablename, ".csv"), row.names = FALSE)
return(output)
}
