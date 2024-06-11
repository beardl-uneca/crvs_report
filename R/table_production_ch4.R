

chapter4_tables <- loadWorkbook("./templates/chapter4.xlsx", xlsxFile = NULL)
writeData(chapter4_tables, t4.1, sheet = "Table 4.1", startCol = 2, startRow = 3)
mergeCells(chapter4_tables, sheet = "Table 4.1", cols = 2, rows = 2:3)
max_value <- bth_data %>% pull(dobyr) %>% max(na.rm = TRUE)
yearvector <- (max_value - 5): (max_value - 1)
# Merge appropriate cells
start <- 3 # Column C in Excel terms
for(i in 1 : length(yearvector)) {

  writeData(chapter4_tables, sheet = "Table 4.1", yearvector[i], startCol = start, startRow = 2)
  start <- start + 1
}
saveWorkbook(chapter4_tables,"./outputs/excel/chapter4.xlsx", overwrite = T)