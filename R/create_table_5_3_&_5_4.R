
#' Calculates Tables 5.3 & 5.4 
#' Deaths by place of occurrence and place of usual residence of decedent
#'
#' @param data dataframe being used
#' @param sex_filter 1 = Male, 2 = Female
#'
#' @return returns Table 5.3
#' @export
#'
#' @examples t5_3 <- t5_34(data, 1) 
#' t5_4 <- t5_34(data, 2) 
#' 
t5_34 <- function(data, sex_filter){
  output <- data |>
    filter(SEX == sex_filter) |>
    group_by(GORPOD, RES_OCC) |>
    summarise(COUNT = n()) |>
    pivot_wider(names_from = RES_OCC, values_from = COUNT, values_fill = 0) |>
    adorn_totals(c("col", "row"))
  
  return(output)
}
