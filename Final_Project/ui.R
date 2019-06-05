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
                      .plot {
                        padding: 1.25em;
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
                   
                   checkboxGroupInput("choose_date_1", label = h4("Select a Date Range"),
                               choices = list("Aug 15" = "15", "Aug 16" = "16",
                                              "Aug 17" = "17", "Aug 18" = "18",
                                              "Aug 19" = "19"), 
                               selected = c("15", "16", "17","18", "19"))
          
                   ),
                 
                 mainPanel(
                   tags$div(class = "plot", 
                   plotlyOutput("first-plot")
                   )
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
                 checkboxGroupInput("choose_date_2", label = h4("Select a Date Range"),
                                    choices = list("Aug 15" = "15", "Aug 16" = "16",
                                                   "Aug 17" = "17", "Aug 18" = "18"
                                                   ), selected = "18")
                 ),
               
               mainPanel(
                 tags$div(class = "plot",
                   plotlyOutput("length_counts")
                 )
               ),
               position = "left"
                 )
             ),
    
    #--------------------------------Sentiment Analysis-----------------------------#
    tabPanel("Tweet Sentiment Analysis",
             icon = icon("meh"),
             sidebarLayout(
               
               sidebarPanel(
                 id = "sidebar",
                 tags$div(class = "title", "Analysis of Changing Sentiment"), 
                 hr(),
                 tags$div(class = "content", "This section analyzes a nationally
                          changing sentiment in reports and discourse regarding the
                          Charlottesville incident. With an ability to sort through
                          days and indicate a positive or negative graph,
                          one can render the most popular words in said category
                          and see the shifts over the period."), 
                 hr(),
                 tags$div(class = "subtitle", "Filtering Options"),
                 HTML("<p></p>"), 
                 radioButtons("data_type_3", label = h4("Choose Data"),
                              choices = list("New York Times" = "nyt_data", "Twitter" = "Twitter"), 
                              selected = "Twitter"),
                 radioButtons("choose_date_3", label = h4("Select a Date Range"),
                                    choices = list("Aug 15" = "15", "Aug 16" = "16",
                                                   "Aug 17" = "17", "Aug 18" = "18"
                                    ), selected = "16"),
                 radioButtons("sentiments", label = h4("Choose Sentiment"),
                              choices = list("Positive" = "Positive", "Negative" = "Negative", "All Words" = "All Words"), 
                              selected = "Positive"),
                 numericInput("n_words", label = h3("How Many Words?"), value = 1, min = 1, max = 20)
                 ),
               
               mainPanel(
                 tags$div(class = "plot",
                          plotlyOutput("pie_charts"),
                          plotOutput("top_words")
                 )
               ),
               position = "left"
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