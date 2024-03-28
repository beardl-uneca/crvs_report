create_t3.2_t3.3 <- function(data, occ_var, topic = NA){
  colMax <- function(data) sapply(data, max, na.rm = TRUE)
  if(topic == "births"){
    output <- data |>
      filter(is.na(sbind) & !doryr %in% c("", "2023") & {{occ_var}} %in% c((max({{occ_var}},
                                                                                na.rm = TRUE)-5):max({{occ_var}}, na.rm = TRUE))) |>  
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
  }else if(topic == "deaths"){
    output <- data |>
      filter(!doryr %in% c("", "2023") & {{occ_var}} %in% c((max({{occ_var}},
                                                                 na.rm = TRUE)-5):max({{occ_var}}, na.rm = TRUE))) |>  
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
  }
  return(output)
}
