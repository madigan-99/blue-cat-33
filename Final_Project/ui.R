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
             tags$h2("About Charlottesville"),
           
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
                                choices = list("New York Times" = "NYT", "Twitter" = "Twitter"), 
                                selected = "NYT"),
                   checkboxGroupInput("choose_date_1", label = h5("Select a Date Range"), 
                                      choices = list("Aug 15, 2016" = "15", "Aug 16, 2016" = "16",
                                                     "Aug 17, 2016" = "17", "Aug 18, 2016" = "18"), 
                                      selected = "15")
          
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
             tags$div(
               id = "container", 
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
                 sliderInput("choose_date_2", label = h5("Select a Date Range"), min = 16, 
                             max = 19, step = 1, value = c(17, 18), ticks = FALSE, pre = "AUG ", post = ", 2016")
                 
                 ),
               
               mainPanel(
                 plotlyOutput("mean_goal_main_category")
               ),
               position = "left"
                 )
             )
             ),
    
    #--------------------------------Sentiment Analysis-----------------------------#
    tabPanel("Tweet Sentiment Analysis",
             icon = icon("meh"),
             tags$div(
               id = "container", 
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
                   radioButtons("data_type_3", label = h4("Choose Data"),
                                choices = list("New York Times" = "New York Times", "Twitter" = "Twitter"), 
                                selected = "NYT"),
                   radioButtons("date_range", label = h4("Choose Data"),
                                choices = list("Aug 15" = "15", "Aug 16" = "16",
                                               "Aug 17" = "17", "Aug 18" = "18"), 
                                selected = "15")
                 ),
                 mainPanel(
                   plotlyOutput("mean_goal_main_category")
                 ),
                 position = "left"
                 )
               
             )
    ),
    
    
    #--------------------------------Twitter User Analysis-----------------------------#
    tabPanel("Twitter User Analysis",
             icon = icon("mobile-alt"),
             tags$div(
               id = "container", 
               sidebarLayout(
                 
                 sidebarPanel(
                   id = "sidebar",
                   tags$div(class = "title", "Analysis of Twitter + NYT Sentiment"), 
                   hr(),
                   tags$div(class = "content", "Using a natural language processor,
                            this section analyzes the sentiment of the related media and whether it
                            is more positive or negative over time. Words in articles and tweets
                            are sorted by whether they are positive or negative and the following
                            graphics depict the most commonly used words as well as its 
                            overall trend."), 
                   hr(),
                   tags$div(class = "subtitle", "Filtering Options"),
                   HTML("<p></p>")
                   ), 
                   
                 
                 mainPanel(
                   plotlyOutput("mean_goal_main_category")
                 ),
                 position = "left"
                 )
               )
             
    ),
    
    #-----------------------------About Page------------------------------#
    tabPanel("About Our Group",
             icon = icon("users"),
             tags$div(
               id = "container"
                 
               
             )
    )
    )
)