setwd("C:/Users/")  # Set wd here

# Loading packages
library(dplyr)

# Reading csv files
t1 <- read.table("table_1.tsv", sep= "\t", header= TRUE)
t2 <- read.table("table_2.tsv", sep= "\t", header= TRUE)

# Merging dataframes
t3 <- merge (t1, t2, by= "Order")

# Writing merged dataframe to csv file
write.table(t3, "t4.csv", sep= ",", quote= FALSE, row.names= FALSE)