library(stringr)

marr_data16 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl16m",
                               variables = c("agebs", "agegs", "marconbt", "marcongt", "marcong", "marconb","pcdrg" )) |>
  mutate(year = 2016)

marr_data17 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl17m",
                               variables = c("agebs", "agegs", "marconbt", "marcongt", "marcong", "marconb", "pcdrg" )) |>
  mutate(year = 2017)

marr_data18 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl18m",
                             variables = c("agebs", "agegs", "marconbt", "marcongt", "marcong", "marconb", "pcdrg" )) |>
  mutate(year = 2018)

marr_data19 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl19m",
                             variables = c("agebs", "agegs", "marconbt", "marcongt", "marcong", "marconb", "pcdrg" )) |>
  mutate(year = 2019)

marr_data20 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl20m",
                             variables = c("agebs", "agegs", "marconbt", "marcongt", "marcong", "marconb", "pcdrg" )) |>
  mutate(year = 2020)


ref_data <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "reference.dbo.nspl24feb",
                            variables = c("pcd",  "gor", "ru11ind"))


marr_data <- rbind(marr_data16, marr_data17, marr_data18, marr_data19, marr_data20) |>
  mutate(pcdrg = gsub(" ", "", pcdrg))

rm(marr_data16, marr_data17, marr_data18, marr_data19, marr_data20)

ref_data <- ref_data |>
  mutate(pcd = gsub(" ", "", pcd))

marr_data <- merge(marr_data, ref_data, by.x = "pcdrg", by.y = "pcd", all.x = TRUE) |>
  mutate(ruind = case_when(
    ru11ind %in% c("A1", "B1", "C1", "C2", "1":"3") ~ "urban",
    ru11ind %in% c("D1", "D2", "E1", "E2", "F1", "F2","4":"8" ) ~ "rural",
    TRUE ~ "not stated")) |>
  select(-pcdrg)




write.csv(marr_data, "D:/repos/crvs_report/data/marriages.csv", row.names = FALSE)
