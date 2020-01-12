# 原始碼說明文件
- `first_step/`:爬取資料並進行第一次資料整理
- `second_step/`:得出調酒的總容量與酒精濃度
- `final_step/`:將所有資料合併，完成最終資料庫
- `final_GUI.Rmd`:最終使用shiny所做出的GUI介面，若要體驗開啟此檔案。



### 細部檔案夾說明

##### first_step/ 
- `first_data_cleaning.py`:內涵爬蟲同時進行第一次資料清洗的檔案 
- `first_clean.csv`:從`first_data_cleaning.py`輸出的資料庫

##### second_step/
- `alcohol_list/`:內涵人工抓取基酒名稱，之後手動填寫酒精濃度的各時期版本列表，勿動。
    - `abv_list_1.R`:第一期版本，從網站上搜集的259種基酒
    - `missed.R`:發現基酒資料仍有疏漏，繼續抓出漏掉的基酒名稱，並再次地用人工填寫酒精濃度
    - `adjusted_missed.R`:刪去 missed 版本中一些不必出現在基酒列表的雜列
    - `whiskey.R`:發現 whiskey 與 whisky 的差異會使某些調酒的酒精濃度計算有誤，再次調整
    - `*csv`:各 R script 所輸出的 csv 檔
- `final_alcohol_list.csv`:人工整理的基酒酒精濃度表單。由`abv_list_1.csv`、`adjusted_missed.csv`及`whiskey.csv`組成。
- `unify.py`:運用`/first_step/first_clean.csv`及`final_abv_list.csv`算出調酒的酒精濃度與總容量
- `abv_involved.csv`:從`unify.py`輸出的資料庫（含調酒的酒精濃度與總容量）

##### final_step/
- `final_data_processing.R`:做出最終的資料庫
- `clean_fh1.csv`:最終的資料庫，準備被shiny使用
- `delete_list.pdf`:人工挑錯時所抓出來的列的編號及其被抓出來的原因，可待日後資料庫擴增時使用
