library(dplyr)

data23_13 <- read.csv2("./data/23-08-csv/23-2013-lem.csv.csv", 
                       header = F, stringsAsFactors = F,
                       na.strings = c("NA","00000 "))
data23_13 <- data23_13 %>%
  select(V1) %>%
  mutate(Year = "2013")

data23_14 <- read.csv2("./data/23-08-csv/23-2014-lem.csv.csv", 
                       header = F, stringsAsFactors = F,
                       na.strings = c("NA","00000 "))
data23_14 <- data23_14 %>%
  select(V1) %>%
  mutate(Year = "2014")

data23 <- full_join(data23_13, data23_14) %>%
  na.omit()

rm(data23_13, data23_14)
save(data23, file="./data/data23.rda")

############# 8 MARCH
data8_13 <- read.csv2("./data/23-08-csv/08-2013-lem.csv.csv", 
                       header = F, stringsAsFactors = F,
                       na.strings = c("NA","00000 "))
data8_13 <- data8_13 %>%
  select(V1) %>%
  mutate(Year = "2013")

data8_14 <- read.csv2("./data/23-08-csv/08-2014-lem.csv.csv", 
                       header = F, stringsAsFactors = F,
                       na.strings = c("NA","00000 "))
data8_14 <- data8_14 %>%
  select(V1) %>%
  mutate(Year = "2014")

data8 <- full_join(data8_13, data8_14) %>%
  na.omit()

rm(data8_13, data8_14)
save(data8, file="./data/data8.rda")
