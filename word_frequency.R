library(tidyverse)
library(readxl)

download.file("https://www.wordfrequency.info/samples/wordFrequency.xlsx",
    "wordFrequency.xlsx")

word_frequency <- read_excel("wordFrequency.xlsx", sheet = "1 lemmas")

words <- word_frequency %>%
    filter(nchar(lemma) >= 3) %>%
    filter(!str_detect(lemma, "[^a-zA-Z]")) %>%
    mutate("Obtained_from_www.wordfrequency.info" = str_to_lower(lemma)) %>%
    select("Obtained_from_www.wordfrequency.info")

write_csv(words, "words.csv")
