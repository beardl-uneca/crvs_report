

t3.1 <- create_t3.1(bth_data, dth_data)
write.csv(t3.1, "./outputs/Table_3_1.csv", row.names = FALSE)
rm(t3.1)

t3.2 <- create_t3.2_t3.3(bth_data, occ_var = dobyr, topic = "births")
write.csv(t3.2, "./outputs/Table_3_2.csv", row.names = FALSE)
rm(t3.2)

t3.3 <- create_t3.2_t3.3(dth_data, occ_var = dodyr, topic = "deaths")
write.csv(t3.3, "./outputs/Table_3_3.csv", row.names = FALSE)
rm(t3.3)

t3.4 <- create_t3.4_to_3.7(bth_data, bth_est, dobyr, topic = "births")
write.csv(t3.4, "./outputs/Table_3_4.csv", row.names = FALSE)
rm(t3.4)

t3.6 <- create_t3.4_to_3.7(dth_data, dth_est, dodyr, topic = "deaths")
write.csv(t3.6, "./outputs/Table_3_6.csv", row.names = FALSE)
rm(t3.6)

t6.1 <- create_t6.1(dth_data, 2022)

t6.2 <- create_t6.2(dth_data)

t6.3 <- create_t6.3_t6.4(dth_data, sex_value = "male")
t6.4 <- create_t6.3_t6.4(dth_data, sex_value = "female")

t6.5 <- create_t6.5_t6.10(dth_data, sex_value = c("male","female"), age_group = "<5")
t6.6 <- create_t6.5_t6.10(dth_data, sex_value = c("male","female"), age_group = "5-14")

t6.7 <- create_t6.5_t6.10(dth_data, sex_value = c("male"), age_group = "15-69")
t6.8 <- create_t6.5_t6.10(dth_data, sex_value = c("female"), age_group = "15-69")

t6.9 <- create_t6.5_t6.10(dth_data, sex_value = c("male"), age_group = "70+")
t6.10 <- create_t6.5_t6.10(dth_data, sex_value = c("female"), age_group = "70+")
