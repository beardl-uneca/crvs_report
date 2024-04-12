

t3.1 <- create_t3.1(bth_data, dth_data)

t3.2 <- create_t3.2_t3.3(data = bth_data, occ_var = dobyr,
                         topic = "births", tablename = "Table_3_2")

t3.3 <- create_t3.2_t3.3(data = dth_data, occ_var = dodyr,
                         topic = "deaths", tablename = "Table_3_3")

t3.4 <- create_t3.4_and_3.6(data = bth_data, bth_est, dobyr,
                           topic = "births", tablename = "Table_3_4")

t3.5 <- create_t3.5_and_3.7(data = bth_data, est_data = bth_est,
                            date_var = dobyr, data_year = 2022,
                            topic = "births", tablename = "Table_3_5")

t3.6 <- create_t3.4_and_3.6(data = bth_data, est_data = bth_est,
                           date_var = dobyr, data_year = 2022,
                           topic = "births", tablename = "Table_3_6")

t3.7 <- create_t3.5_and_3.7(data = dth_data, est_data = dth_est,
                            date_var = dodyr, data_year = 2022,
                            topic = "deaths", tablename = "Table_3_7")

t3.8 <- create_t3.8_and_t3.9(data = bth_data, est_data = bth_est,
                             date_var = dobyr, data_year = 2022, by_var = rgn,
                             topic = "births", tablename = "Table_3_8")

t3.9 <- create_t3.8_and_t3.9(data = dth_data, est_data = dth_est,
                             date_var = dodyr, data_year = 2022, by_var = rgn,
                             topic = "deaths", tablename = "Table_3_9")

t3.10 <- create_t3.10(data = dth_data, date_var = dodyr, data_year = 2022,
                      tablename = "Table_3_10")

t3.11 <- create_t3.11_and_3.12(data = bth_data, date_var = dobyr,
                               data_year = 2022, by_var = fert_age_grp,
                               tablename = "Table_3_11", topic = "births")

t3.12 <- create_t3.11_and_3.12(dth_data, dodyr, data_year = 2022,
                               by_var = age_grp_80, tablename = "Table_3_12",
                               topic = "deaths")

t4.1 <- create_t4.1(data = bth_data, date_var = dobyr, tablename = "Table_4_1")

t4.2 <- create_t4.2(data = bth_data, est_data = bth_est, date_var = dobyr,
                    data_year = 2022, tablename = "Table_4_2")

t4.3 <- create_t4.3(data = bth_data, dobyr, 2022)

t4.4 <- create_t4.4_to_4_6(data = bth_data, year = 2022, col_var = fert_age_grp,
                           by_var = multbth, rural_urban = "no",
                           tablename = "Table_4_4")

t4.5 <- create_t4.4_to_4_6(data = bth_data, year = 2022, col_var = fert_age_grp,
                           by_var = bthimar, rural_urban = "urban",
                           tablename = "Table_4_5")

t4.6 <- create_t4.4_to_4_6(data = bth_data, year = 2022, col_var = fert_age_grp,
                           by_var = bthimar, rural_urban = "rural",
                           tablename = "Table_4_6")

t4.7 <- create_t4.7(data = bth_data, date_var = dobyr, data_year = 2022,
                    tablename = "Table_4_7")

t4.8 <- create_t4.8(data = bth_data, bth_est, dobyr, data_year = 2022,
                    by_var = rgn, tablename = "Table_4_8")


t4.9 <- create_table_4_9_and_4_10(data = bth_data, est_data = bth_est, data_year = 2022,
                                  ruindicator = "urban", tablename = "Table_4_9")

t4.10 <- create_table_4_9_and_4_10(data = bth_data, est_data = bth_est, data_year = 2022,
                                   ruindicator = "rural", tablename = "Table_4_10")

#### t5.1 <- create_t5.1(data = dth_data, tablename = "Table_5_1") ####

t5.3 <- create_t5.3_and_t5.4(data = dth_data, dodyr, 2022, sex_filter = "male",
                             tablename = "Table_5_3")

t5.4 <- create_t5.3_and_t5.4(data = dth_data, dodyr, 2022, sex_filter = "female",
                             tablename = "Table_5_4")

t5.5 <- create_t5_5(data = dth_data, date_var = dodyr, data_year = 2022,
                     tablename = "Table_5_5")

t5.6 <- create_t5.6_and_t5.7(data = dth_data, ru_filter = "urban",
                             date_var = dodyr, datayear = 2022,
                             tablename = "Table_5_6")

t5.7 <- create_t5.6_and_t5.7(data = dth_data, ru_filter = "rural",
                             date_var = dodyr, datayear = 2022,
                             tablename = "Table_5_7")

t5.11 <- create_t5.11(data = bth_data, date_var = dobyr,
                      tablename = "Table_5_11")

t5.12 <- create_t5.12(data = bth_data, date_var = dobyr, data_year = 2022,
                      tablename = "Table_5_12")

t6.1 <- create_t6.1(data = dth_data, date_var = dodyr, data_year = 2022)

t6.2 <- create_t6.2(data = dth_data, date_var = dodyr)

t6.3 <- create_t6.3_t6.4(data = dth_data, sex_value = "male")

t6.4 <- create_t6.3_t6.4(data = dth_data, sex_value = "female")

t6.5 <- create_t6.5_t6.10(data = dth_data, sex_value = c("male","female"),
                          age_group = "<5")

t6.6 <- create_t6.5_t6.10(data = dth_data, sex_value = c("male","female"),
                          age_group = "5-14")

t6.7 <- create_t6.5_t6.10(data = dth_data, sex_value = c("male"),
                          age_group = "15-69")

t6.8 <- create_t6.5_t6.10(data = dth_data, sex_value = c("female"),
                          age_group = "15-69")

t6.9 <- create_t6.5_t6.10(data = dth_data, sex_value = c("male"),
                          age_group = "70+")

t6.10 <- create_t6.5_t6.10(data = dth_data, sex_value = c("female"),
                           age_group = "70+")

t7.2 <- create_t7.2_and_7.3(data = marr_data, data_year = 2020,
                            ruindicator = "urban", tablename = "Table_7_1")

t7.3 <- create_t7.2_and_7.3(data = marr_data, data_year = 2020,
                            ruindicator = "rural", tablename = "Table_7_2")

t7.4 <- create_table_7.4_and_7.5(data = marr_data, data_year = 2020,
                                 groombride = "groom", tablename = "Table_7_4")

t7.5 <- create_table_7.4_and_7.5(data = marr_data, data_year = 2020,
                                 groombride = "bride", tablename = "Table_7_5")

t7.6 <- create_t7.6_to_7.9(data = div_data, data_year = 2019,
                           group_var = "age_w", by_var = "age_h",
                           tablename = "Table_7_6")

t7.7 <- create_t7.6_to_7.9(data = div_data, data_year = 2019,
                           group_var = "age_h", by_var = "dur_grp",
                           tablename = "Table_7_7")

t7.8 <- create_t7.6_to_7.9(data = div_data, data_year = 2019,
                           group_var = "age_w", by_var = "dur_grp",
                           tablename = "Table_7_8")

t7.9 <- create_t7.6_to_7.9(data = div_data, data_year = 2019,
                           group_var = "child", by_var = "dur_grp",
                           tablename = "Table_7_9")

t8.1 <- create_t8.1(tablename = "Table _8_1")

t8.2 <- create_t8.2(data_year = 2022, tablename = "Table_8_2")
