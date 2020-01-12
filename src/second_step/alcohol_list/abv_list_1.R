# 從網站上爬取基酒列表，製成csv檔，再由人工填入酒精名

library(tibble)
library(httr)
library(xml2)
library(rvest)

req <- GET("https://www.socialandcocktail.co.uk",
           path = "alcohol")
req[["url"]]
req[["status_code"]]
html <- content(req)

liquor_name <- html %>% html_nodes("ul.open-chooser > li > a") %>% html_text()
liquor_name
alcohol_content <- vector("numeric", length = 259)

liquor_table <- data.frame(liquor_names = liquor_name, alcohol_contents = alcohol_content)
liquor_table

write.csv(liquor_table, file = "abv_list_1.csv", row.names = F, na = " ", sep = ",")