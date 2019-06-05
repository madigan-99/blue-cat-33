library("dplyr")
library("plotly")
library("shiny")
library("shinythemes")


# loading related documents and library, read in dataset

source("../R/info project.R")

# Start shinyServer
shinyServer(function(input, output) {

  # output$`first-plot` <- renderPlotly({
  #   first_graph(input$choose_date_1, input$data_type_1)
  # })
  # 
  output$text1 <- renderText({
    paste("Hello!! ")
    
  })
  
  output$text2 <- renderText({
    paste("HELP !", "<font color=\"#FF0000\">")
  })
  
  
  
})