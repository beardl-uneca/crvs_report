
#' Calculates Table 5.5 Deaths by place of occurrence and site of occurrence
#'
#' @param data dataframe being used
#' @param datayear year of data
#' @param year_var 
#'
#' @return table 5.5
#' @export
#'
#' @examples t5_5 <- t5_5(data, datayear = 2021)
#' 
#' 
create_t5_5a <- function(data, year_var = dodyr, datayear = 2022){  
  output <- dth_data |>
    filter(dodyr == 2022) |>
    group_by(ruind, esttyped) |>
    summarise(total = n()) |>
    pivot_wider(names_from = esttyped, values_from = total, values_fill = 0) |>
    adorn_totals(c("col", "row")) |>
    mutate(ruind = case_when(
      ruind == "Total" ~ "All deaths",
      TRUE ~ ruind)) |> 
    rename(`Place of occurrence` = ruind, `Total number of deaths` = Total) |>
    select(`Place of occurrence`, Hospital,	`Other Institution`,	Home,
           Other,	`Not Stated`, `Total number of deaths`)
  
  return(output)
}
create_t5_5b <- function(data, year_var = dodyr, datayear = 2022){
  output <- data |>
    filter({{year_var}} == datayear) |>
    group_by(rgnpod, esttyped) |>
    summarise(Total = n()) |>
    pivot_wider(names_from = esttyped, values_from = Total, values_fill = 0) |>
    adorn_totals(c("col", "row")) |>
    mutate(rgnpod = ifelse(is.na(rgnpod), "Not Stated", rgnpod)) |> 
    rename(`Place of occurrence` = rgnpod, `Total number of deaths` = Total) |>
    select(`Place of occurrence`, Hospital,	`Other Institution`,	Home,
           Other,	`Not Stated`, `Total number of deaths`)
  return(output)
}


