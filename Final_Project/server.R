library(dplyr)
library(plotly)
library(shiny)
library(shinythemes)


# loading related documents and library, read in dataset
source("scripts/backer.R")
source("scripts/chart#3.R")
source("scripts/average goal.R")
source("scripts/initial_info.R")
source("scripts/total_backer.R")
data <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Start shinyServer
shinyServer(function(input, output) {


  
  
  
})