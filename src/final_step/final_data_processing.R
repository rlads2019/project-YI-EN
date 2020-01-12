library(dplyr)
library(tidyverse)
library(stringr)
library(tibble)

fh1 <- read.csv("../first_step/first_clean.csv")  # 從/first_step中選出preprocessing.csv
fh2 <- read.csv("../second_step/abv_involved.csv")  # 從/second_step中拿出final_abv_list.csv
as_tibble(fh1)
as_tibble(fh2)

# 將final_abv_list中的兩欄都合併到preprocessing的dataframe中
fh1 <- fh1 %>%
  mutate("abv" = fh2$alcohol_concentration...) %>%
  mutate("volume" = fh2$total_volume.ml.)

# 人工挑除含有錯誤的調酒列（挑錯的資料寫在/final_step/delete_list.pdf中）
delete_set <- c(6, 15, 16, 23, 34, 44, 104, 107, 114, 127, 128, 132, 137, 163, 169, 171, 179, 204, 205, 226
                , 233, 234, 239, 242, 243, 247, 254, 256, 258, 280, 286, 289, 291, 296, 303, 306, 310, 314, 318, 324, 329, 336, 340, 342, 349, 352, 369, 373, 383, 388, 402, 406, 407, 408, 414, 421, 436, 446, 464, 466, 469, 474, 476, 489, 490, 500, 502, 528, 532, 534, 536, 548, 554, 555, 568, 573, 574, 575, 582, 584, 585, 589, 599, 605, 617, 624, 627, 640, 641, 643, 644, 646, 661, 665, 681, 690, 696, 699, 701, 730, 736, 745, 755, 761, 764, 765, 778, 779, 789, 796, 805, 809, 819, 829, 847, 868, 871, 880, 881, 883, 893, 898, 899, 914, 918, 922, 923, 928, 932, 935, 938, 939, 942, 946, 968, 969, 981, 982, 989, 990, 996, 1000, 1001, 1002, 1008, 1016, 1023, 1024, 1029, 1046, 1050, 1057, 1061)
clean_fh1 <- fh1[-delete_set, ]

# 依酒精濃度分類
clean_fh1 <- clean_fh1 %>% mutate("classified_by_abv" = 0)
clean_fh1[clean_fh1$abv == 0, "classified_by_abv"] <- "偷偷告訴你，我不含酒精呦～"
clean_fh1[(0 < clean_fh1$abv) & (clean_fh1$abv < 20), "classified_by_abv"] <- "啊啊啊啊明天還有早八Orz"
clean_fh1[(20 <= clean_fh1$abv) & (clean_fh1$abv < 40), "classified_by_abv"] <- "喝到微醺最快樂！"
clean_fh1[(40 <= clean_fh1$abv) & (clean_fh1$abv < 60), "classified_by_abv"] <- "人生偶爾就是要來大醉一場"

# 依120ml為界分長短飲
clean_fh1 <- clean_fh1 %>% mutate("long_and_short_drink" = 0)
clean_fh1[(clean_fh1$volume <= 120), "long_and_short_drink"] <- "快快喝，快快醉"
clean_fh1[(120 < clean_fh1$volume), "long_and_short_drink"] <- "慢慢喝，還是會醉"

write.csv(clean_fh1, "clean_fh1.csv")