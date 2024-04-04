

t3.1 <- create_t3.1(bth_data, dth_data)

t3.2 <- create_t3.2_t3.3(bth_data, occ_var = dobyr, topic = "births", tablename = "Table_3_2")

t3.3 <- create_t3.2_t3.3(dth_data, occ_var = dodyr, topic = "deaths", tablename = "Table_3_3")

t3.4 <- create_t3.4_to_3.7(bth_data, bth_est, dobyr, topic = "births", tablename = "Table_3_4")

t3.5 <- create_t3.5_and_3.7(bth_data, bth_est, dobyr, 2022, topic = "births", tablename = "Table_3_5")

t3.6 <- create_t3.4_to_3.7(bth_data, bth_est, dobyr, topic = "births", tablename = "Table_3_6")

t3.7 <- create_t3.5_and_3.7(dth_data, dth_est, dodyr, 2022, topic = "deaths", tablename = "Table_3_7")

t3.8 <- create_t3.8_t3.9(bth_data, bth_est, rgn, topic = "births", tablename = "Table_3_8")

t3.9 <- create_t3.8_t3.9(dth_data, dth_est, rgn, topic = "deaths", tablename = "Table_3_9")

t4.1 <- create_t4.1(bth_data, tablename = "Table_4_1")

t4.2 <- create_t4.2(bth_data, bth_est, data_year = 2022, tablename = "Table_4_2")

t4.3 <- create_t4.3(bth_data, dobyr, 2022)

t4.4 <- create_t4.4_5_6(bth_data, year = 2022, col_var = fert_age_grp, by_var = multbth, rural_urban = "no", tablename = "Table_4_4")

t4.5 <- create_t4.4_5_6(bth_data, year = 2022, col_var = fert_age_grp, by_var = marstat, rural_urban = "no", tablename = "Table_4_5")

t4.6 <- create_t4.4_5_6(bth_data, year = 2022, col_var = fert_age_grp, by_var = marstat, rural_urban = "no", tablename = "Table_4_6")

t5.3 <- create_t5.3_and_t5.4(dth_data, dodyr, 2022, sex_filter = "male", tablename = "Table_5_3")

t5.4 <- create_t5.3_and_t5.4(dth_data, dodyr, 2022, sex_filter = "female", tablename = "Table_5_4")



t6.1 <- create_t6.1(dth_data, dodyr, 2022)

t6.2 <- create_t6.2(dth_data, dodyr)

t6.3 <- create_t6.3_t6.4(dth_data, sex_value = "male")
t6.4 <- create_t6.3_t6.4(dth_data, sex_value = "female")

t6.5 <- create_t6.5_t6.10(dth_data, sex_value = c("male","female"), age_group = "<5")
t6.6 <- create_t6.5_t6.10(dth_data, sex_value = c("male","female"), age_group = "5-14")

t6.7 <- create_t6.5_t6.10(dth_data, sex_value = c("male"), age_group = "15-69")
t6.8 <- create_t6.5_t6.10(dth_data, sex_value = c("female"), age_group = "15-69")

t6.9 <- create_t6.5_t6.10(dth_data, sex_value = c("male"), age_group = "70+")
t6.10 <- create_t6.5_t6.10(dth_data, sex_value = c("female"), age_group = "70+")
