library(dplyr)
library(tidyverse)
library(stringr)

fh1 <- read.csv("abv_list_1.csv")
fh2 <- read.csv("missed.csv")
missed <- fh2 %>% 
  mutate("TorF" = fh2$ABV > 0) %>%
  filter(TorF == TRUE) %>%
  mutate("Capital" = str_detect(X, "^[A-Z][a-z ]+")) %>%
  filter(Capital == TRUE) %>% 
  select(X, ABV)
missed
write.csv(missed, "adjusted_missed.csv", row.names = F, col.names = F)