library(dplyr)
library(tidyverse)
library(stringr)

# 解決 whisky 和 whiskey 的問題

liquor_table <- read.csv("abv_list_1.csv")
liquor_table <- as_tibble(liquor_table)
whiskey <- liquor_table %>% filter(str_detect(liquor_names, "Whiskey"))
write.csv(whiskey, "whiskey.csv", row.names = F)