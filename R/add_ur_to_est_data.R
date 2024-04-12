create_est_data <- function(topic = "births"){
if(topic == "births"){
output <- bth_data |>
  group_by(fert_age_grp, sex, dobyr, ruind, ruindpob, rgn, rgnpob) |>
  summarise(count = n()) |>
  rename(year = dobyr)
} else {
  output <- dth_data |>  
    group_by(age_grp_85, sex, dodyr, ruind, ruindpod, rgn, rgnpod) |>
    summarise(count = n()) |>
    rename(year = dodyr)
}
  
  output <- output |> 
    mutate(count2 = case_when(
      count < 5 ~ count,
      count %in% c(5:10) ~ ceiling(count/10) * 10,
      count %in% c(10:24) ~ ceiling(count/25) * 25, 
      count %in% c(25:49) ~ ceiling(count/50) * 50,
      count %in% c(50:99) ~ ceiling(count/100) * 100,
      count %in% c(100:249) ~ ceiling(count/250) * 250,
      count %in% c(250:499) ~ ceiling(count/500) * 500,    
      count %in% c(500:999) ~ ceiling(count/1000) * 1000,
      count %in% c(1000:1499) ~ ceiling(count/1500) * 1500,
      count %in% c(1500:1999) ~ ceiling(count/2000) * 2000,
      count %in% c(2000:2499) ~ ceiling(count/2500) * 2500,
      count %in% c(2500:2999) ~ ceiling(count/3000) * 3000,     
      count %in% c(3000:3499) ~ ceiling(count/3500) * 3500,
      count %in% c(3500:3999) ~ ceiling(count/4000) * 4000,     
      count %in% c(4000:4499) ~ ceiling(count/4500) * 4500,      
      count %in% c(4500:4999) ~ ceiling(count/5000) * 5000,     
      count %in% c(5000:5499) ~ ceiling(count/5500) * 5500,
      count %in% c(5500:5999) ~ ceiling(count/6000) * 6000,     
      count %in% c(6000:6499) ~ ceiling(count/6500) * 6500,      
      count %in% c(6500:6999) ~ ceiling(count/7000) * 7000,       
      count %in% c(7000:7499) ~ ceiling(count/7500) * 7500,      
      count %in% c(7500:7999) ~ ceiling(count/8000) * 8000,     
      count %in% c(8000:8499) ~ ceiling(count/8500) * 8500,
      count %in% c(8500:8999) ~ ceiling(count/9000) * 9000,     
      count %in% c(9000:9499) ~ ceiling(count/9500) * 9500,      
      count %in% c(9500:9999) ~ ceiling(count/10000) * 10000, 
      count %in% c(10000:14999) ~ ceiling(count/15000) * 15000,       
      count %in% c(15000:19999) ~ ceiling(count/20000) * 20000, 
      count %in% c(20000:24999) ~ ceiling(count/25000) * 25000,       
      count %in% c(25000:29999) ~ ceiling(count/30000) * 30000))|>
    select(-count) |>
    rename(count = count2) |>
    pivot_wider(names_from = sex, values_from = count, values_fill = 0) |>
    mutate(total = male + female + `not stated`)
  
 write.csv(output, paste0("./data/new_",topic,"_est.csv"), row.names = FALSE)
  
return(output)
}

data <- create_est_data(topic = "births")
data <- create_est_data(topic = "deaths")






