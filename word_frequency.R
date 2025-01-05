library(tidyverse)
library(readxl)
word_frequency <- read_excel("wordFrequency.xlsx", sheet = "1 lemmas")
words <- word_frequency %>%
    filter(nchar(lemma) >= 3) %>%
    filter(!str_detect(lemma, "[^a-zA-Z]")) %>%
    mutate(lemma2 = str_to_lower(lemma)) %>%
    pull(lemma2)
words2 <- c("Obtained from www.wordfrequency.info",
    words) %>% tibble()
write_csv(words2, "words.csv",
    col_names = FALSE)
