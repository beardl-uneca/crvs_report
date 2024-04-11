library(stringr)

div_data16 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl16d",
                               variables = c("agedaw_yp", "agedah_op", "dom", "doda")) |>
  mutate(year = 2016)

div_data17 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl17d",
                               variables = c("agedaw_yp", "agedah_op", "dom", "doda")) |>
  mutate(year = 2017)

div_data18 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl18d",
                             variables = c("agedaw_yp", "agedah_op", "dom", "doda")) |>
  mutate(year = 2018)

div_data19 <- sql_data_import(server = "SQL-SVC-L-07\\LEO", database = "Legal_partnerships.dbo.annl19d",
                             variables = c("agedaw_yp", "agedah_op", "dom", "doda")) |>
  mutate(year = 2019)




div_data <- rbind(div_data16, div_data17, div_data18, div_data19)

rm(div_data16, div_data17, div_data18, div_data19, div_data20)




write.csv(div_data, "D:/repos/crvs_report/data/divorces.csv", row.names = FALSE)
