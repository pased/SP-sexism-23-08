library(tm)
library(dplyr)

load("./data/data23.rda")
stop_words <- readLines("https://raw.githubusercontent.com/pased/katabasia-twitter-sna/master/data/stop.txt")

feb23_corpus <- Corpus(VectorSource(data23$V1))
feb23_corpus <- tm_map(feb23_corpus, removeWords, c(stopwords("russian"), stop_words))
feb23_corpus <- tm_map(feb23_corpus, removeWords, c(stopwords("english")))

feb23_tdm <- TermDocumentMatrix(feb23_corpus)

feb23_man <- findAssocs(feb23_tdm, "мужчина", 0.5) %>%
  data.frame() %>%
  mutate(Word = row.names(.), Date = "Feb 23", Toi = "мужчина")

feb23_woman <- findAssocs(feb23_tdm, "женщина", 0.5) %>%
  data.frame() %>%
  mutate(Word = row.names(.), Date = "Feb 23", Toi = "женщина")

load("./data/data8.rda")
march8 <- Corpus(VectorSource(data8$V1))
march8 <- tm_map(march8, removeWords, c(stopwords("russian"), stop_words))
march8 <- tm_map(march8, removeWords, c(stopwords("english")))

march8_tdm <- TermDocumentMatrix(march8)

march8_man <- findAssocs(march8_tdm, "мужчина", 0.5) %>%
  data.frame() %>%
  mutate(Word = row.names(.), Date = "March 8", Toi = "мужчина")

march8_woman <- findAssocs(march8_tdm, "женщина", 0.5) %>%
  data.frame() %>%
  mutate(Word = row.names(.), Date = "March 8", Toi = "женщина")

feb23_wnet <- full_join(feb23_man, march8_man)
feb23_wnet[nrow(feb23_wnet)+1:nrow(feb23_wnet),] <- feb23_wnet[,c(1, 4, 3, 2)]

march8_wnet <- full_join(feb23_woman, march8_woman)
march8_wnet[nrow(march8_wnet)+1:nrow(march8_wnet),] <- march8_wnet[,c(1, 4, 3, 2)]

save(feb23_wnet, file = "./data/feb23_wnet.rda")
save(march8_wnet, file = "./data/march8_wnet.rda")
