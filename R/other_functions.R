#' Title
#'
#' @param data 
#' @param topic 
#'
#' @return
#' @export
#'
#' @examples
calculate_reg_delay <- function(data, topic = "deaths"){
  if(topic == "deaths"){
    output <- data |>
      mutate(REGDAYS <- ifelse(!is.na(DOR) & !is.na(DOD),
                               floor(interval(lubridate::ymd(DOD),
                                              lubridate::ymd(DOR))/days()), NA))
    return(output)
    
  } else if(topic == "births") {
    output <- data |>
      mutate(REGDAYS <- ifelse(!is.na(DOR) & !is.na(DOB),
                               floor(interval(lubridate::ymd(DOB),
                                              lubridate::ymd(DOR))/days()), NA))
    return(output)
  }
}

#' Title
#'
#' @param data 
#'
#' @return
#' @export
#'
#' @examples
create_timeliness <- function (data){
  output <- data |>
    mutate(TIMELINESS = case_when(
      REGDAYS < 8 ~ "Current",
      REGDAYS >= 8 & REGDAYS < 366 ~ "Late",
      TRUE ~ "Delayed"
    ))
}
