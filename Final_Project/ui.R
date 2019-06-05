library("shiny")
library("plotly")
library("shinythemes")

# Customized user interface
shinyUI(
  navbarPage(
    theme = shinytheme("slate"),
    
    tags$head(
      tags$style(HTML("
                      html, body {
                      min-height:100%;
                      overflow:auto;
                      }      
                      #sidebar{
                      background-color: transparent;
                      text-align: left;
                      }
                      .sliderInput {
                      background-color: red;
                      }
                    "))
      ),
    
    
    tabPanel("Home",
             icon = icon("home"),
             titlePanel(tags$h2("Charlottesville")),
             
             tags$div(
               id = "intro",
               tags$div(
                 id = "container",
                 "This is our group project"
               )
                 )
                 ),
    
    #--------------------------Time Trends----------------#
    tabPanel("Time Trends",
             icon = icon("chart-line"),
             tags$div(
               id = "container", titlePanel(tags$h5("Success Rate")),
               
               sidebarLayout(
                 sidebarPanel(
                   id = "sidebar",
                   uiOutput("line_ui1"),
                   uiOutput("line_ui2")
                   ),
                 mainPanel(
                   plotlyOutput("rate"),
                   plotlyOutput("line_rate")
                 )
                   )
                 )
               ),
    #----------------------------Twitter Engagements---------------------------------#
    tabPanel("Twitter Engagements",
             icon = icon("twitter"),
             
             sidebarLayout(
               
               sidebarPanel(
                 id = "sidebar",
                 tags$h5("Average Goals"),
                 
                 uiOutput("categories")
                 ),
               
               mainPanel(
                 plotlyOutput("mean_goal_main_category"),
                 plotlyOutput("mean_goal_sub_category")
               ),
               position = "left"
                 )
             ),
    
    #--------------------------------Sentiment Analysis-----------------------------#
    tabPanel("Tweet Sentiment Analysis",
             icon = icon("meh"),
             titlePanel(tags$h5("Where do the backers' investment go?")),
             
             tags$div(
               id = "sankey",
               plotlyOutput("sankey")
             )
             ),
    
    #--------------------------------Twitter User Analysis-----------------------------#
    tabPanel("Twitter User Analysis",
             icon = icon("mobile-alt"),
             tags$div(
               id = "container",
               titlePanel(tags$h5("Backer's Investment Information")),
               sidebarLayout(
                 sidebarPanel(
                   id = "sidebar",
                   uiOutput("backer_ui")
                   ),
                 
                 mainPanel(
                   plotlyOutput("backers")
                 )
                   )
               )
             ),
    #-----------------------------About Page------------------------------#
    tabPanel("About Our Group",
             icon = icon("users"),
             tags$div(
               id = "container",
               
                mainPanel(
                   plotlyOutput("backers")
                 )
               
             )
    )
    )
)