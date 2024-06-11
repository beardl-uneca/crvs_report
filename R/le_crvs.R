library(data.table)
options(scipen = 999, digits = 10)

sc$mx <- sc$deaths/sc$pops
#if statement. similar to IF in excel: If age_grp_le is '1' then ax is '0.1' else ax is '0.5'
sc$ax <- ifelse (sc$age_grp_le == 1, 0.1, 0.5)

sc$int <- ifelse (sc$age_grp_le == 1, 1, 
                  ifelse (sc$age_grp_le == 2, 4, 
                          ifelse (sc$age_grp_le == 20, 2/sc$mx, 5)))

sc$qx <- ifelse (sc$age_grp_le == 20, 1, (sc$int * sc$mx)/(1 + sc$int *(1-sc$ax)*sc$mx))

#sc$int <- ifelse (sc$age_grp_le == 1, 1, 5)
#sc$int <- ifelse (sc$age_grp_le == 2, 4, sc$int)
#sc$int <- ifelse (sc$age_grp_le == 20, 2/sc$mx, sc$int)

#sc$qx <- (sc$int * sc$mx)/(1 + sc$int *(1-sc$ax)*sc$mx)
#sc$qx <- ifelse (sc$age_grp_le == 20, 1, sc$qx)

sc$px <- 1 - sc$qx
#setting up the counter for the loop. nice and easy as age_grp_le is 1 to 20.
i <- sc$age_grp_le
#if statement to initialise the variable lx
sc$lx <- ifelse(sc$age_grp_le == 1, 100000,0) #if age_grp_le = 1 then set to 100000, else 0
# the rest of the variable lx is populated using a loop and uses the SHIFT function. This allows you to use the 
# data in the line above. 
for (i in 1:20){sc$lx <-ifelse(sc$age_grp_le == 1,sc$lx, shift(sc$px, 1, type = "lag")*shift(sc$lx, 1, type = "lag"))}

sc <- sc[with(sc, order(sc$rgn, sc$sex,-sc$age_grp_le)), ]

sc$dx <- ifelse(sc$age_grp_le ==20, sc$lx, 0)
for (i in 1:20){sc$dx <-ifelse(sc$age_grp_le == 20,sc$lx, sc$lx-shift(sc$lx, 1, type = "lag"))}

sc$Lx <- ifelse(sc$age_grp_le ==20, sc$lx/sc$mx, 0)
for (i in 1:20){sc$Lx <-ifelse(sc$age_grp_le == 20,sc$Lx, sc$int*((shift(sc$lx, 1, type = "lag"))+(sc$ax*sc$dx)))}

sc$Tx <- ifelse(sc$age_grp_le ==20, sc$Lx, NA)
for (i in 1:20){sc$Tx <-ifelse(sc$age_grp_le == 20,sc$Tx, sc$Lx+shift(sc$Tx, 1, type = "lag"))}

sc<-sc[with(sc, order(sc$rgn, sc$sex,sc$age_grp_le)), ]

sc$ex<- sc$Tx/sc$lx

sc$varqx <- ifelse (sc$age_grp_le == 20, (4/(sc$deaths*(sc$mx^2))),(sc$int^2*sc$mx*(1-sc$ax*sc$int*sc$mx))/(sc$pops*(1+(1-sc$ax)*sc$int*sc$mx)^3))

sc<-sc[with(sc, order(sc$rgn, sc$sex,-sc$age_grp_le)), ]
sc$P1 <- ifelse(sc$age_grp_le == 20, (((sc$lx/2)^2)*sc$varqx),(sc$lx^2)*(((1-sc$ax)*sc$int+shift(sc$ex, 1, type = "lag"))^2)*sc$varqx)

for (i in 1:20) {sc$P2 <- ifelse(sc$age_grp_le == 20, sc$P1, sc$P1+shift(sc$P2, 1, type = "lag"))}

sc<-sc[with(sc, order(sc$rgn, sc$sex,sc$age_grp_le)), ]
sc$varex <- round(sc$P2/(sc$lx^2), digits = 5)
sc$SE <- round(sqrt(sc$varex), digits = 10)
sc$CIll <- round(sc$ex-sc$SE*1.96, digits = 5)
sc$CIul <- round(sc$ex+sc$SE*1.96, digits = 5)

head(sc, 20)
write.xlsx2(sc, "/Users/liambeardsmore/Documents/R Work/scle2.xlsx", sheetName = "Sheet 1", col.names = TRUE)
leout <- sc %>% select(rgn, sex, age_grp_le, ex, CIll, CIul)
leout <- leout %>%
  mutate(ex = round_excel(ex, 0),
         CIll = round_excel(CIll, 2),
         CIul = round_excel(CIul, 2))
         
         
         
         
#write.xlsx2(leout, "/Users/liambeardsmore/Documents/R Work/leout.xlsx", sheetName = "Sheet 1", col.names = TRUE)
#head(leout, 40)
#pdf("/Users/liambeardsmore/Documents/R Work/leout.pdf", height = 11, width = 8.5)
grid.table(leout)
           dev.off()
out <- dcast(leout ,sex+rgn ~ age_grp_le, fun= sum, value.var="ex")
#pdf("/Users/liambeardsmore/Documents/R Work/new.pdf", height = 22, width = 16)
#grid.table(newtab)
         # dev.off()
          with(sc[sc$rgn =="E06000001",], qplot (age_grp_le, ex, colour = sex))          
ggplot(subset(sc, rgn == "K02000001"), aes(x=age_grp_le, y=ex, color=sex)) + geom_line(aes(group=sex))
                                                                    
