#' Title
#'
#' @param data 
#'
#' @return
#' @export
#'
#' @examples
create_t6.2 <- function(data){
output <- data |>
  filter(!substr(fic10und,1,1) %in% c("", "U") & sex %in% c("male", "female")) |>
  group_by(doryr, substr(fic10und,1,3)) |>
  summarise(total = n()) |>
  arrange(doryr) |>
  rename(causecd = `substr(fic10und, 1, 3)`)  

output<- left_join(output, cause, by = c("causecd" = "code")) |>
  group_by(doryr, description)|>
  summarise(total = sum(total)) |>
  group_by(doryr) |>
  slice_max(order_by = total, n = 10, with_ties = FALSE) |>
  mutate(rank = rank(-total)) |>
  pivot_wider(id_cols = rank, names_from = doryr, values_from = description)

return(output)
}

