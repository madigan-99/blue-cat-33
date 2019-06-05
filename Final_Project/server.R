library(dplyr)
library(plotly)
library(shiny)
library(shinythemes)


# loading related documents and library, read in dataset
source("../R/info project.R")

# Start shinyServer
shinyServer(function(input, output) {

  output$`first-plot` <- renderPlotly({
    first_graph(input$choose_date, input$data_type)
  })
  
  
  
})