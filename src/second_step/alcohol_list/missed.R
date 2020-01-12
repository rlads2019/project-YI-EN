library(tibble)
library(dplyr)
library(stringr)

alco <- readr::read_delim("alcohol_percentage.csv", 
                          delim = ",")
cocktail <- readr::read_delim("first_clean.csv", delim = ",")

alcohol <- character(0)
#character of all kinds of alcohol
ingredients <- character(0)
for (i in 2:13){
  ingredients <- append(ingredients, cocktail[[i]], length(ingredients))
} #將所有成分儲存在一個向量中
ingredients <- ingredients[!is.na(ingredients)] #移除NA值
split_ing <- strsplit(ingredients, split = ":") #將成分名稱和量分開
ing <- character(0)
for (i in 1:length(split_ing)){
  ing <- append(ing, split_ing[[i]][1], length(ing))
} #將成分名稱儲存在一個向量中
alcotype <- unique(ing) #刪掉重複的向量
alcotype <- alcotype[!str_detect(alcotype, "[0-9]")] #刪掉類似"2 1/2 Strawberries"的成分
#alcotype = 表單一酒精成份

listed_alco <- alco$liquor_names #cocktail表單裡的酒
missed <- character(0)
for (i in 1:length(alcotype)){
  if(length(listed_alco[listed_alco == alcotype[i]]) == 0){
    missed <- append(missed, alcotype[i], length(missed))
  } #將alco中沒列出的成分儲存到"missed"中
}
noalco <- c("juice", "Juice", "Kiwi", "Lemon")
missed <- missed[!str_detect(missed, "([Jj]uice)|Kiwi|Lemon")] #刪掉酒精濃度為0的成分

write.csv(missed, "missed.csv", row.names = F, na = " ", sep = ",")
