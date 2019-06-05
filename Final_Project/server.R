library("dplyr")
library("plotly")
library("shiny")
library("stringr")
library("ggplot2")
library("lubridate")
library("shinythemes")


# loading related documents and library, read in dataset

source("../R/info project.R")
source("../R/twitter-engagements.R")

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
  
  
  output$helper <- renderText({
    dates <- input$choose_date_2
    paste(dates)
  })
  

 
  
  
  
  
})