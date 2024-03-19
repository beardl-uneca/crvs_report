
#' create Table 3.1 data
#'
#' @param data dataframe being used
#' @param prev_year the previous data year
#' @param curr_year the current data year
#'
#' @return Table 3.1
#' @export
#'
#' @examples
create_t3_1 <- function(data, prev_year, curr_year) {
  output <- data |>
    filter(REGYR %in% c(prev_year, curr_year)) |>
    group_by(Birth_Registration_Type, REGYR) |>
    summarise(TOTAL = n()) |>
    pivot_wider(names_from = REGYR, values_from = TOTAL) |>
    adorn_totals("row")
}

