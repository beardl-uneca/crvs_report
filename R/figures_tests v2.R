create_figure_4.1_and_5.1 <- function(data, date_var, topic = NA){
output<- data |>
  filter({{date_var}} %in% c((max({{date_var}}, na.rm = TRUE) - 4):max({{date_var}}, na.rm = TRUE) - 1) &
           if (topic == "live births") is.na(sbind) else TRUE) |>
  group_by({{date_var}}) |>
  dplyr::summarise(count = n())


max_count <- round_any(max(f4.1$count, na.rm = TRUE), 100000, ceiling)
min_count <- round_any(min(f4.1$count, na.rm = TRUE), 100000, floor)
                   
p <- ggplot(output) +
  geom_line(aes(x = {{date_var}}, y = count, group = 1), color = 'blue', size = 1) +
  labs(x = "Year", y = paste0("Number of ", topic), title = paste0("Registered ", topic, ", England & wales, 2018 to 2022")) +
  scale_y_continuous(breaks = c(seq(min_count, max_count, 10000)),labels=function(x) format(x, big.mark = ",", scientific = FALSE))


return(p)
}                               

create_figure_4.1(bth_data, dobyr, topic = "live births")
create_figure_4.1(dth_data, dodyr, topic = "deaths")

create_figure_4.2 <- function(data, by_var){

output <- data |>
  filter(is.na(sbind) & dobyr %in% c((max(dobyr, na.rm = TRUE) - 4):max(dobyr, na.rm = TRUE) - 1)) |>
  group_by(dobyr, {{by_var}}) |>
  dplyr::summarise(count = n())

outputb <- data |>
  filter(is.na(sbind) & dobyr %in% c((max(dobyr, na.rm = TRUE) - 4):max(dobyr, na.rm = TRUE) - 1)) |>
  group_by(dobyr) |>
  dplyr::summarise(count_all = n())


output <-merge(output, outputb, by = "dobyr", all.x = TRUE) |>
  mutate(proportions = round_excel((count/count_all)*100,0)) |>
  select(-c(count, count_all)) |>
  dplyr::rename(year = dobyr)


level_order <- c("Under 15", "15-19","20-24", "25-29", "30-34", "35-39", "40-44", "45 and over")
  
p <- ggplot(output) +
  geom_line(aes(x = factor({{by_var}}, level = level_order), y = proportions, group = year, color = year), size = 1) +
  labs(x = "Mother's age (years)",
       y = "Proportion of births (%)",
       title = "Live births by age of mother, England & wales, 2018 to 2022")+
  scale_y_continuous(breaks = c(seq(600000, 660000, 5000)),labels=function(x) format(x, big.mark = ",", scientific = FALSE)) +
  theme(legend.position = "bottom")

return(p)
}
create_figure_4.2(bth_data, fert_age_grp)





create_figure_4.22 <- function(data){
  
  output <- data |>
    dplyr::filter(is.na(sbind) & dobyr == 2022 & substr(rgn, 1, 1) %in% c("E", "W")) |>
    group_by(fert_age_grp, rgn) |>
    dplyr::summarise(count = n())
  
  outputb <- data |>
    dplyr::filter(is.na(sbind) & dobyr == 2022 & substr(rgn, 1, 1) %in% c("E", "W")) |>
    group_by(rgn) |>
    dplyr::summarise(count_all = n())
  
  
  output <-merge(output, outputb, by = "rgn", all.x = TRUE) |>
    mutate(proportions = round_excel((count/count_all)*100,0)) |>
    select(-c(count, count_all))
  
  
  level_order <- c("Under 15", "15-19","20-24", "25-29", "30-34", "35-39", "40-44", "45 and over")
  
  p <- ggplot(output) +
    geom_line(aes(x = factor(fert_age_grp, level = level_order), y = proportions, group = rgn, color = rgn), size = 1) +
    labs(x = "Mother's age (years)",
         y = "Proportion of births (%)",
         title = "Live births by age of mother, England & wales, 2018 to 2022")+
    scale_y_continuous(breaks = c(seq(600000, 660000, 5000)),labels=function(x) format(x, big.mark = ",", scientific = FALSE)) +
    theme(legend.position = "bottom")
  
  return(p)
}

create_figure_4.22(bth_data)


