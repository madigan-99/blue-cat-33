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
                      font-family: Helvetica
                      }      
                      #sidebar{
                      background-color: transparent;
                      text-align: left;
                      }
                      .subtitle {
                      margin-right: auto;
                      text-align: center;
                      font-size: 1.75em;
                      margin-left: auto;
                      }
                      .title {
                        font-size: 1.75em;
                        width: 80%;
                      text-align: center;
                      font-weight: bold;
                      margin-left: auto;
                      margin-right: auto
                      }
                      
                      hr {
                        width: 90%;
                        color: white;
                      }
                      .content {
                        font-size: 1.1em;
                      }
  

 
                  "))
      ),
    
    
    tabPanel("Introduction",
             icon = icon("home"),
             titlePanel(tags$h2("About Charlottesville")),
             
             tags$div(
               id = "intro",
               HTML("<p>  &nbsp </p>"), img(src = "banner_photo.jpg", width = "70%"), 
               tags$div(
                 id = "container",
                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                 Integer pharetra venenatis ante vitae laoreet. 
                 Cras consequat mauris in posuere pretium. Pellentesque quis tortor neque. 
                 Vestibulum volutpat felis vitae tempus viverra. Vivamus nisl magna, pharetra eget turpis ac,
                 varius vehicula erat. Cras imperdiet tellus nec est molestie fringilla at sed orci. 
                 Integer porttitor libero sapien, id mattis erat imperdiet in. Morbi semper convallis
                 enim vitae consectetur. In varius nulla magna, non ullamcorper turpis cursus ac. 
                 Nullam eget est sed quam mattis laoreet. Sed orci mi, accumsan eu odio at, aliquam 
                 ultricies nisi. Aliquam varius, felis id posuere venenatis, dolor ligula posuere sapien, 
                 sed tempor nunc nulla et elit. Mauris ultrices non eros a tincidunt. Class aptent taciti 
                 sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
               )
                 )
                 ),
    
    #--------------------------Time Trends----------------#
    tabPanel("Time Trends",
             icon = icon("chart-line"),
             tags$div(
               id = "container", 
               sidebarLayout(
                 sidebarPanel(
                   id = "sidebar",
                   
                   tags$div(class = "title", "Analysis of Time and Attention"),
                      hr(),
                      tags$div(class = "content", "This section analyzes the trends in articles and 
                               tweets during the four day period. Choose which data structure to 
                               learn more about, whether that is the New York Times artices or Tweets, and specify a date range 
                               to show how the quantity of related posts/tweets changed. "), 
                      hr(),
                      tags$div(class = "subtitle", "Filtering Options"),
                   HTML("<p></p>"), 
                    radioButtons("data_type_1", label = h4("Choose Data"),
                                choices = list("New York Times" = "nyt_data", "Twitter" = "Twitter"), 
                                selected = "nyt_data"),
                   
                   checkboxGroupInput("choose_date_1", label = h5("Select a Date Range"),
                               choices = list("Aug 15" = "15", "Aug 16" = "16",
                                              "Aug 17" = "17", "Aug 18" = "18",
                                              "Aug 19" = "19"), selected = "15")
          
                   ),
                 
                 mainPanel(
                   plotlyOutput("first-plot")
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
                 tags$div(class = "title", "Analysis of Tweet Length"), 
                 hr(),
                 tags$div(class = "content", "This section analyzes average length of tweets
                                   and how these numbers are affected by different features of the 
                                   tweet including whether the tweet has @ mentions, hashtags,
                                   media links which include images or external articles, or are retweets."), 
                 hr(),
                 tags$div(class = "subtitle", "Filtering Options"),
                 HTML("<p></p>"), 
              
                 sliderInput("choose_date", label = h5("Select a Date Range"), min = 16, 
                             max = 19, step = 1, value = c(17, 18), ticks = FALSE, pre = "AUG ", post = ", 2016")
                 
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
               "This project was created by Max Beeson, Liangqi Cai, Divya Rajasekhar, YuYu Madigan
               in June of 2019 for the Informatics 201 Lecture B final project. This uses data from",
               tags$a(href = "https://www.kaggle.com/vincela9/charlottesville-on-twitter#aug17_sample.csv", "Kaggle"),
               " as well as "      
               
             )
    )
    )
)