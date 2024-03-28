

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


