#' Creates Tables 3.2 or 3.3
#'
#' @param data dataframe being used
#' @param occ_var dobyr or dodyr
#'
#' @return table 3.2 or 3.3
#' @export
#'
#' @examples t3.2 <- create_t3.2(bth_data, occ_var = dobyr)
#' 
create_t3.2_t3.3 <- function(data, occ_var){
  output <- data |>
    filter(!doryr %in% c("", "2023") & is.na(sbind)) |>  
    group_by(doryr, {{occ_var}}) |>
    summarise(Total = n()) 
  
  output2 <- output %>%
    group_by(doryr) %>%
    summarise(total = sum(Total))
  
  # Merge total live births back into the original dataframe
  output <- output %>%
    left_join(output2, by = c("doryr" = "doryr")) %>%
    mutate(Percentage := round_excel((Total/ total) * 100, 2)) %>%
    select(-c(total, Total)) |>
    pivot_wider(names_from = {{occ_var}}, values_from = Percentage, values_fill = 0)
  
  return(output)
}


