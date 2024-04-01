create_t3.1 <- function(births_data, deaths_data){
  outputb <- births_data |>
    filter(is.na(sbind) & doryr != "" & !is.na(dob)) |>
    group_by(doryr, timeliness) |>
    summarise(total = n()) |>
    mutate(type = "Live births")
  outputd <- deaths_data |>
    filter(doryr != "" & !is.na(dod)) |>
    group_by(doryr, timeliness) |>
    summarise(total = n()) |>
    mutate(type = "Deaths")
  
  output <- rbind(outputb, outputd) |>
    pivot_wider(names_from = c(type, doryr), values_from = total, values_fill = 0) |>
    adorn_totals("row") 
  output <- output[c(1,3,2,4),c(1,2,8,3,9,4,10,5,11,6,12,7,13)]
  return(output)
}
