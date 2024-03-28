create_t3.4_to_3.7 <- function(data, est_data, by_var, topic) {
  by_var <- enquo(by_var)
  by_var_name <- quo_name(by_var)
  
  max_value <- data %>% pull(!!by_var) %>% max(na.rm = TRUE)
  
  counts <- data |>
    filter((!!by_var) %in% c((max_value - 5):max_value) &
             if (topic == "births") is.na(sbind) else TRUE) |>
    group_by(!!by_var, sex) |>
    summarise(total = n()) 
  
  ests <- est_data |>
    pivot_longer(cols = c("male", "female"), names_to = "sex", values_to = "count" ) |>
    group_by(year, sex) |>
    summarise(total_est = sum(count))
  
  output <- merge(counts, ests, by.x = c(by_var_name, "sex"), by.y = c("year", "sex"), all.x = TRUE)
  
  output <- output |>
    mutate(completeness = round((total / total_est) * 100, 2)) |>
    pivot_wider(names_from = sex, values_from = c(total, total_est, completeness))
  
  return(output)
}

# Corrected function call
t3.4 <- create_t3.4_to_3.7(bth_data, bth_est, dobyr, topic = "births")
t3.6 <- create_t3.4_to_3.7(dth_data, dth_est, dodyr, topic = "deaths")

