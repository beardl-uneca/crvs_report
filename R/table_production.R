

chapter3_tables <- loadWorkbook("./templates/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.1, sheet = "Table 3.1", startCol = 2, startRow = 3)
  mergeCells(chapter3_tables, sheet = "Table 3.1", cols = 2, rows = 2:3)
  yearvector <- (max_value - 5): (max_value - 1)
  # Merge appropriate cells
  start <- 3 # Column C in Excel terms
  for(i in 1 : length(yearvector)) {
    mergeCells(chapter3_tables, sheet = "Table 3.1", cols = start:(start + 1), rows = 2)
    writeData(chapter3_tables, sheet = "Table 3.1", yearvector[i], startCol = start, startRow = 2)
    writeData(chapter3_tables, sheet = "Table 3.1", "Live births", startCol = start, startRow = 3)
    writeData(chapter3_tables, sheet = "Table 3.1", "Deaths", startCol = start + 1, startRow = 3)
   start <- start + 2
  }
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.2, sheet = "Table 3.2", startCol = 2, startRow = 3)
  mergeCells(chapter3_tables, sheet = "Table 3.2", cols = 2, rows = 2:3)
  mergeCells(chapter3_tables, sheet = "Table 3.2", cols = 3:(ncol(t3.2) + 1), rows = 2)
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.3, sheet = "Table 3.3", startCol = 2, startRow = 3)
  mergeCells(chapter3_tables, sheet = "Table 3.3", cols = 2, rows = 2:3)
  mergeCells(chapter3_tables, sheet = "Table 3.3", cols = 3:(ncol(t3.2) + 1), rows = 2)
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.4, sheet = "Table 3.4", startCol = 2, startRow = 4, colNames = FALSE)
  mergeCells(chapter3_tables, sheet = "Table 3.4", cols = 2, rows = 2:3)
  mergeCells(chapter3_tables, sheet = "Table 3.4", cols = 3:5, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.4", cols = 6:8, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.4", cols = 9:11, rows = 2)  
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)


chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.5, sheet = "Table 3.5", startCol = 2, startRow = 4, colNames = FALSE)
  mergeCells(chapter3_tables, sheet = "Table 3.5", cols = 2, rows = 2:3)
  mergeCells(chapter3_tables, sheet = "Table 3.5", cols = 3:5, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.5", cols = 6:8, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.5", cols = 9:11, rows = 2)  
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
  writeData(chapter3_tables, t3.6, sheet = "Table 3.6", startCol = 2, startRow = 4, colNames = FALSE)
  mergeCells(chapter3_tables, sheet = "Table 3.6", cols = 2, rows = 2:3)
  mergeCells(chapter3_tables, sheet = "Table 3.6", cols = 3:5, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.6", cols = 6:8, rows = 2)
  mergeCells(chapter3_tables, sheet = "Table 3.6", cols = 9:11, rows = 2)  
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

chapter3_tables <- loadWorkbook("./outputs/excel/chapter3.xlsx", xlsxFile = NULL)
writeData(chapter3_tables, t3.7, sheet = "Table 3.7", startCol = 2, startRow = 4, colNames = FALSE)
mergeCells(chapter3_tables, sheet = "Table 3.7", cols = 2, rows = 2:3)
mergeCells(chapter3_tables, sheet = "Table 3.7", cols = 3:5, rows = 2)
mergeCells(chapter3_tables, sheet = "Table 3.7", cols = 6:8, rows = 2)
mergeCells(chapter3_tables, sheet = "Table 3.7", cols = 9:11, rows = 2)  
saveWorkbook(chapter3_tables,"./outputs/excel/chapter3.xlsx", overwrite = T)

