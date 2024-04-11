#' @title flag_cause
#'
#' @description Creates a flag variable based on supplied ICD codes.
#'
#' @param dataset The name of the dataframe being used.
#' @param code_pattern The code, or codes, you are searching for.
#' @param column_pattern The name, or partial name, of the column(s) being searched.
#' @param new_column_name The name the column will be called.
#'
#' @return A new column containing a 1 or 0 to flag the record.
#'
#' @examples data <- data %>% flag_cause("E85|E619", "FIC10MEN", "CHECK")
#'
#' @export
#'
flag_cause <- function(dataset, code_pattern, column_pattern, new_column_name) {

  dataset[new_column_name] <- apply(
    dplyr::select(dataset, dplyr::matches(column_pattern)), 1,
    function(row) {
      if (length(code_pattern) == 4 ) {
        as.integer(any(code_pattern %in% row))
      } else if (length(code_pattern) < 4) {
        as.integer(any(grepl(pattern = code_pattern, x = row)))
      }
    })

  return(dataset)
}
