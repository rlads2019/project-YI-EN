library(tidyr)
library(dplyr)
library(tibble)
library(shiny)
library(readr)
library(ggplot2)
library(DT)
library(shinythemes)

#-------------- 資料讀取分類 start -------------------------------

table <- read_csv("~/documents/GitHub/project-YI-EN/src/final_step/clean_fh1.csv")

#分類

#酸，材料有包含檸檬/酸橙/酸相關的sour欄為1
sour <- table %>%
  filter(grepl("((.+)?\\sLemon\\s(.+)?)|((.+)?\\sSour\\s(.+)?)|((.+)?\\sLime\\s(.+)?)",table$cocktails_name)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_1)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_2)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_3)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_4)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_5)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_6)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_7)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_8)
         |grepl("((.+)?Lemon(.+)?)|((.+)?Lime(.+)?)",table$ingredient_9)) %>%
  mutate(sour=1) %>%
  select(cocktails_name,sour)
#合併
table <-merge(table, sour, by = "cocktails_name", all = T)

#甜，材料有包含糖漿/糖/蜂蜜/巧克力/甜相關的sweet欄為1
sweet <- table %>%
  filter(grepl("((.+)?\\sSyrup(.+)?)|((.+)?\\sSweet(.+)?)|((.+)?\\sHoney(.+)?)|((.+)?\\sSugar(.+)?)|((.+)?\\sChocolate(.+)?)"
               ,table$cocktails_name)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_1)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_2)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_3)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_4)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_5)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_6)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_7)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_8)
         |grepl("((.+)?Syrup(.+)?)|((.+)?Honey(.+)?)|((.+)?Sugar(.+)?)|((.+)?Chocolate(.+)?)",table$ingredient_9)) %>%
  mutate(sweet=1) %>%
  select(cocktails_name,sweet)
#合併
table <-merge(table, sweet, by = "cocktails_name", all = T)

#苦，材料有包含苦精相關的bitter欄為1
bitter <- table %>%
  filter(grepl("(.+)?\\sBitter(.+)?",table$cocktails_name)|grepl("(.+)?Bitter(.+)?",table$ingredient_1)|grepl("(.+)?Bitter(.+)?",table$ingredient_2)|grepl("(.+)?Bitter(.+)?",table$ingredient_3)|grepl("(.+)?Bitter(.+)?",table$ingredient_4)|grepl("(.+)?Bitter(.+)?",table$ingredient_5)|grepl("(.+)?Bitter(.+)?",table$ingredient_6)|grepl("(.+)?Bitter(.+)?",table$ingredient_7)|grepl("(.+)?Bitter(.+)?",table$ingredient_8)|grepl("(.+)?Bitter(.+)?",table$ingredient_9)) %>%
  mutate(bitter=1) %>%
  select(cocktails_name,bitter)
#合併
table <-merge(table, bitter, by = "cocktails_name", all = T)

#薄荷，材料有包含薄荷的mint欄為1
mint <- table %>%
  filter(grepl("(.+)?\\sMint(.+)?",table$cocktails_name)|grepl("(.+)?\\sMint(.+)?",table$ingredient_1)|grepl("(.+)?\\sMint(.+)?",table$ingredient_2)|grepl("(.+)?\\sMint(.+)?",table$ingredient_3)|grepl("(.+)?\\sMint(.+)?",table$ingredient_4)|grepl("(.+)?\\sMint(.+)?",table$ingredient_5)|grepl("(.+)?\\sMint(.+)?",table$ingredient_6)|grepl("(.+)?\\sMint(.+)?",table$ingredient_7)|grepl("(.+)?\\sMint(.+)?",table$ingredient_8)|grepl("(.+)?\\sMint(.+)?",table$ingredient_9)) %>%
  mutate(mint=1) %>%
  select(cocktails_name,mint)
#合併
table <-merge(table, mint, by = "cocktails_name", all = T)

#把table中的NA值取代為0
table[is.na(table)] <- 0

#--------------------資料讀取分類 end------------------------------

#----------------------隨機挑酒 start------------------------------

random <- table[sample(nrow(table), 5),c(1,15:22)]
random

#----------------------隨機挑酒 end--------------------------------

#-------------------shiny ui start---------------------------------

cocktails_flavor <- table %>% select(cocktails_name,classified_by_abv,abv,long_and_short_drink,volume,sour,sweet,bitter,mint)

ui <- navbarPage("Recommend the Cocktails to You",
                 
                 #頁面一
                 tabPanel("我要按喜好選酒！",fluidPage(theme = shinytheme("simplex"),
                                               
                                               # 顏色
                                               tags$style("body{background-image: linear-gradient(to top, #cfd9df 0%, #e2ebf0 50%,#cfd9df 100%);}"),
                                               tags$style("td{background-color:white}"),
                                               tags$style("form.well{background-color:#2F4EF}"),
                                               tags$style("#DataTables_Table_0_length{color: white}"),
                                               tags$style("select{color: black}"),
                                               tags$style("label.control-label{font-size: 14pt}"),
                                               
                                               #--------------------------------------------------------------   
                                               
                                               #頁面一標題
                                               titlePanel(strong("今天想喝甚麼酒")),
                                               br(),
                                               
                                               #將版面分成塊(上)
                                               fluidRow(
                                                 
                                                 #下拉選項
                                                 column(6,
                                                        selectInput("abv",
                                                                    "能飲一杯無?",
                                                                    c("All",
                                                                      unique(as.character(table$classified_by_abv))))
                                                 ),
                                                 column(6,
                                                        selectInput("drink",
                                                                    "千杯不醉?",
                                                                    c("All",
                                                                      unique(as.character(table$long_and_short_drink))))
                                                 ),
                                                 
                                                 # verbatimTextOutput("summary"),
                                                 
                                                 #將版面分成兩塊(下)table
                                                 
                                               ),
                                               DT::dataTableOutput("cocktails")
                 )),
                 
                 #--------------------------------------------------------------      
                 
                 #頁面二
                 tabPanel("我要按味道選酒！",fluidPage(
                   
                   #頁面二標題
                   titlePanel(strong("今天想喝甚麼酒")),
                   br(),
                   
                   #將版面分成兩塊(左)
                   sidebarLayout(
                     sidebarPanel(
                       
                       #複選input
                       checkboxGroupInput("flavor", label = strong("Choose the flavor you like"), choices = names(cocktails_flavor) ,selected = names(cocktails_flavor) ),
                       
                     ),
                     
                     #將版面分成兩塊(右) table
                     mainPanel(
                       DT::dataTableOutput("cocktails2"),
                     )
                   )
                 )),
                 
                 #--------------------------------------------------------------   
                 
                 #頁面三
                 tabPanel("給我隨機來幾款酒！",fluidPage(
                   
                   #頁面三標題
                   titlePanel(strong("命運讓你與這五款調酒相遇")),
                   br(),
                   
                   
                   #隨機table
                   mainPanel(
                     DT::dataTableOutput("cocktails3"),
                   )
                   
                   
                 ))
)


#-------------------shiny ui end---------------------------------



#-------------------shiny server start---------------------------

cocktails_name <- cocktails_flavor %>% select(cocktails_name)

server <- function(input, output, session) {
  # dataset <- reactive({
  #   get(input$dataset, cocktails_flavor)
  # })
  
  # output$summary <- renderPrint({
  #   summary(dataset())
  # })
  
  #顯示datatable
  output$cocktails <- DT::renderDataTable(
    DT::datatable({
      
      data1 <-table %>% select(cocktails_name,classified_by_abv,abv,long_and_short_drink,volume)
      if (input$abv != "All") {
        data1 <- data1[ data1$classified_by_abv == input$abv,]
        
      }
      if (input$drink != "All") {
        data1 <- data1[ data1$long_and_short_drink == input$drink,]
        
      }
      data1
      #table[, input$flavor],filter = 'top',options = list(orderClasses = TRUE))
      
      #依勾選可將該欄刪除不比較 
      #filter="top"可做為flavor為 1 或 0 的條件選擇
      #orderClasses == True 使點選該行時，會有灰底框住
      
      #table[, input$flavor],filter = 'top',options = list(orderClasses = TRUE))
      
      
      
    }))
  
  
  output$cocktails2 <- DT::renderDataTable(
    DT::datatable(
      
      #依勾選可將該欄刪除不比較 
      #filter="top"可做為flavor為 1 或 0 的條件選擇
      #orderClasses == True 使點選該行時，會有灰底框住
      
      table[, input$flavor[c(1,6,7,8,9)]],filter = 'top',options = list(orderClasses = TRUE))
  )
  
  output$cocktails3 <- DT::renderDataTable(
    DT::datatable(
      
      random,filter = 'top',options = list(orderClasses = TRUE))
  )
  
}
#-------------------shiny server end-----------------------------

#啟動shiny
shinyApp(ui=ui,server = server)




