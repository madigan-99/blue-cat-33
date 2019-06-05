library("dplyr")
library("plotly")
library("shiny")
library("stringr")
library("ggplot2")
library("lubridate")
library("shinythemes")
library("tidytext")
library("tidyr")
library("plotly")
library("jsonlite")
data(stop_words)


# loading related documents and library, read in dataset

source("../R/info project.R")
source("../R/twitter-engagements.R")
source("../R/words_plotting.R")
source("../R/pie_chart_generator.R")
source("../R/words_data.R")


day1 <- read.csv("data/aug15_sample.csv")
day2 <- read.csv("data/aug16_sample.csv")
day3 <- read.csv("data/aug17_sample.csv")
day4 <- read.csv("data/aug18_sample.csv")

# Start shinyServer
shinyServer(function(input, output) {
  
  output$`first-plot` <- renderPlotly({
    first_graph(input$choose_date_1, input$data_type_1)
  })
  
  output$length_counts <- renderPlotly({
    dates <- input$choose_date_2
    df <- data.frame()
    if(is.element(dates, "15")) {
      df <- rbind(df, day1)
    } 
    if(is.element(dates, "16")) {
      df <- rbind(df, day2)
    }
    if(is.element(dates, "17")) {
      df <- rbind(df, day3)
    }
    if(is.element(dates, "18")) {
      df <- rbind(df, day4)
    }
    
    twitter_engagements(df)
    
  })
  # 
  # output$changing_tones <- renderPlot({
  #   df <- return_df(input$data_type_3, input$choose_date_3)
  #   make_plot(input$data_type_3, input$choose_date_3, df, input$sentiments)
  # })

  output$pie_charts <- renderPlotly({
    df <- return_df(input$data_type_3, input$choose_date_3)
    make_pie_chart(input$data_type_3, input$choose_date_3, df)
  })
  
  output$top_words <- renderPlot({
    df <- return_df(input$data_type_3, input$choose_date_3)
    make_plot(input$data_type_3, input$choose_date_3, df, input$sentiments, input$n_words)
  })
})