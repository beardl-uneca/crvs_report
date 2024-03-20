
#' Calculates Table 5.5 Deaths by place of occurrence and site of occurrence
#'
#' @param data dataframe being used
#' @param datayear year of data
#'
#' @return table 5.5
#' @export
#'
#' @examples t5_5 <- t5_5(data, datayear = 2021)
#' 
#' 
create_t5_5a <- function(data, datayear = 2021){  
  output <- data |>
    filter(REGYR == datayear) |>
    group_by(URIND, ESTTYPED) |>
    summarise(Total = n()) |>
    pivot_wider(names_from = ESTTYPED, values_from = Total, values_fill = 0) |>
    adorn_totals(c("col", "row")) |>
    mutate(URIND = case_when(
      URIND == "Total" ~ "All deaths",
      TRUE ~ URIND)) |> 
    rename(`Place of occurrence` = URIND, `Total number of deaths` = Total) |>
    select(`Place of occurrence`, Hospital,	`Other Institution`,	Home,
           Other,	`Not Stated`, `Total number of deaths`)
  
  return(output)
}
create_t5_5b <- function(data, datayear = 2021){
  output <- data |>
    filter(REGYR == datayear) |>
    group_by(GORPOD, ESTTYPED) |>
    summarise(Total = n()) |>
    pivot_wider(names_from = ESTTYPED, values_from = Total, values_fill = 0) |>
    adorn_totals(c("col", "row")) |>
    mutate(GORPOD = ifelse(is.na(GORPOD), "Not Stated", GORPOD)) |> 
    rename(`Place of occurrence` = GORPOD, `Total number of deaths` = Total) |>
    select(`Place of occurrence`, Hospital,	`Other Institution`,	Home,
           Other,	`Not Stated`, `Total number of deaths`)
  return(output)
}


