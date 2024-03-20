#' creates Tables 4.5, 4.5 and 4.6
#'
#' @param data the dataframe being used
#' @param year the year od the data needed
#' @param by_var the variable the data is being grouped by
#' @param rural_urban if this is no then no rural/urban split is used. Else specify "rural" or "urban"
#'
#' @return tabulated data
#' @export
#'
#' @examples t4.4 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = multbth, rural_urban = "no" )
#' t4.5 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = bthimar, rural_urban = "urban" )
#' t4.6 <- create_t4.4_5_6(bth_data, year = 2022 , by_var = bthimar, rural_urban = "rural" )
#' 
create_t4.4_5_6 <- function(data, year = 2022 , by_var = multbth, rural_urban = "no") {
  if(rural_urban == "no"){
  output <- data |>
    filter(doryr == year & is.na(sbind)) |>
    group_by(fert_age_grp, {{by_var}}) |>
    mutate({{by_var}} := ifelse(is.na({{by_var}}), 0, {{by_var}}),
           fert_age_grp := ifelse(is.na(fert_age_grp), "Not Stated", fert_age_grp)) |>
    summarise(Total = n()) |>
    pivot_wider(names_from = {{by_var}}, values_from = Total, values_fill = 0) |>
    adorn_totals(c("col","row"))
  
  output <- output[c(9, 1:8, 10),]
  return(output)
  } else {
    output <- data |>
      filter(doryr == year & is.na(sbind) & ruind == rural_urban) |>
      group_by(fert_age_grp, {{by_var}}) |>
      mutate({{by_var}} := ifelse(is.na({{by_var}}), 0, {{by_var}}),
             fert_age_grp := ifelse(is.na(fert_age_grp), "Not Stated", fert_age_grp)) |>
      summarise(Total = n()) |>
      pivot_wider(names_from = {{by_var}}, values_from = Total, values_fill = 0 ) |>
      adorn_totals(c("col","row"))
    
    output <- output[c(9, 1:8, 10),]
    return(output)
}
}

