
#' Calculates Tables 5.6 and 5.7 Deaths by age and sex of decedent, Urban/Rural
#'
#' @param data dataframe being used
#' @param ur_filter 1 = Urban, 2 = Rural
#' @param datayear year of data
#'
#' @return Table 5.6 & 5.7
#' @export
#'
#' @examples t5_6 <- t5_67(data, ur_filter = "Urban", datayear = 2021)
#' t5_7 <- t5_67(data, ur_filter = "Rural", datayear = 2021)
#' 
t5_67 <- function(data, ur_filter, datayear = 2021){
  output <- data |>
    filter(URIND == ur_filter & REGYR == datayear) |>
    group_by(SEX, AGEGROUP_5_YEAR) |>
    summarise(COUNT = n()) |>
    pivot_wider(names_from = SEX, values_from = COUNT, values_fill = 0) |>
    arrange(AGEGROUP_5_YEAR) |>
    adorn_totals(c("col", "row")) |>
    rename(`Age of decedent (years)` = AGEGROUP_5_YEAR,
           `Total number of deaths` = Total) |>
    select(`Age of decedent (years)`, Male, Female, `Total number of deaths`) 
  
  return(output)
}

t5_67_new_row <- c(`Age of decedent (years)` = "Not Stated",
                   Male  =  0,
                   Female = 0,
                   `Not Stated ` = 0,            
                   `Total number of deaths` = 0 )
