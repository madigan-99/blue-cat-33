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
                      #intro img{
                      display: block;
                      margin-left: auto;
                      margin-right: auto;
                      margin-top: 1em;
                      }
                      #first-plot{
                      margin-top: 4em;
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
                      #full-content {
                      display: table;
                      }
                      #inline-portfolios {
                      width: 100%; 
                      display: table-row;
                      }
                      
                      .member {
                      width: 18%;
                      border: 1px solid black;
                      padding: 1.25em;
                      margin: .5em;
                      border-radius: 5px
                      display: table-cell;
                      float: left;
                      
                      }
                      #intro-content {
                      padding: 2em;
                      margin: 1em;
                      font-size: 1.2em;
                      }
                      .member img{
                      width: 100%;
                      margin-bottom: .6em;
                      }
                      .member a{
                      font-weight: bold;
                      
                      }
                      .member .name{
                      text-align: center;
                      font-weight: bold;
                      margin-bottom: .6em;
                      }
                      .member hr{
                      width: 60%;
                      }
                      
                      
                      "))
      ),
    
    
    tabPanel("Introduction",
             icon = icon("home"),
             titlePanel(tags$h2("About Charlottesville")),
             
             tags$div(
               id = "intro",
               HTML("<p>  &nbsp </p>"), img(src = "cover_photo.jpg", width = "50%"), 
               tags$div(
                 id = "intro-content",
                 
                 "Two years ago, in August a 'Unite the Right rally in Charlottesville, Virginia 
                 turned deadly when a 20-year-old Ohio man allegedly 
                 accelerated his car into a crowd of counter-protesters. This sparked national
                 discourse and debate, brining up a nation-wide discussion about the role of 
                 hate, hate-crimes, and hate groups. This began with month-long debates regarding
                 what the city should do with a statue of a confederate general, Robert E. Lee.
                 As the city voted to remove this statue knowing that it continued to stand as a symbol
                 of hate in a divided county, the Neo-Nazi and Alt-Right groups protested. 
                 On the 12th of August, A group of white nationalists holding lit tiki
                 torches marched through the campus of the University of Virginia, some 
                  chanting the Nazi-associated phrase 'bloor and soil'. During this stressful event,
                 The violence reached its climax at 1:42 p.m. when 
                  James Alex Fields rammed his car into a crowd of counterprotesters.
                 This event sparked conntroversy regarding the political sentiment and reaction by Donald 
                Trump, as all eyes watched too see what he would say in response",tags$br(),tags$br(),  "
                 Social media has enabled people to voice their thoughts whenever they desire,
                  to how large or small of an audience they desire. It can be used as a platform to post life 
                  achievements, raise awareness on a topic, or even to simply rant. As long as people
                  have a readily available platform to share their feelings, they will continue to do so. 
                  
                  Because it is so readily available, social media has drastically changed the way people react
                  to huge events. Without having to wait for newspapers or for other more traditional media 
                  sources to receive news, people have the ability to learn about devastating events hours,
                  even moments after they happen. This means people often post their immediate, visceral 
                  reactions to an event, which is what we were interested in and wanted to look at further. 
                  
                  After the 2015 Charlottesville attack, thousands of people took to Twitter to discuss 
                  their feelings through hundreds of thousands of tweets, and these sentiments were broadcast 
                  to everyone. For our project, we decided to focus on these tweets in the four days 
                  following the incident. We wanted to see trends in the sentiment behind what people 
                  were tweeting day-to-day, the length of the tweets day-to-day, the number of followers
                  a user had relative to how active they were on Twitter after the incident, and any 
                  patterns in when the tweets were posted. In doing so, we found some trends that show 
                  how social media, more specifically Twitter, has enabled people to share their thoughts 
                  as fast as they can. 
                  "
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
                                      choices = list("Aug 16" = "16",
                                                     "Aug 17" = "17", "Aug 18" = "18",
                                                     "Aug 19" = "19"), 
                                      selected = c("16", "17","18", "19"))
                   
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
               )
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
                 numericInput("n_words", label = h3("How Many Words?"), value = 5, min = 1, max = 25)
                 ),
               
               mainPanel( 
                 tags$div(class = "plot",
                          plotlyOutput("pie_charts"),
                          plotOutput("top_words")
                 )
                 
               )
               )
             ),
    #--------------------------------Twitter User Analysis-----------------------------#
    # tabPanel("Twitter User Analysis",
    #          icon = icon("mobile-alt"),
    #          sidebarLayout(
    #            
    #            sidebarPanel(
    #              id = "sidebar",
    #              tags$div(class = "title", "Analysis of Twitter User"), 
    #              hr(),
    #              tags$div(class = "content", "This section analyzes how the twitter user
    #                               engages with their enviornment and the platform."), 
    #              hr(),
    #              tags$div(class = "subtitle", "Filtering Options"),
    #              HTML("<p></p>"), 
    #              checkboxGroupInput("choose_date_4", label = h4("Select a Date Range"),
    #                                 choices = list("Aug 15" = "15", "Aug 16" = "16",
    #                                                "Aug 17" = "17", "Aug 18" = "18"
    #                                 ), selected = "18")
    #              ),
    #            
    #            mainPanel(
    #              tags$div(class = "plot",
    #                       plotlyOutput("final_chart")
    #                       
    #              )
    #              
    #            )
    #            )
    #          
    # ),
    #-----------------------------About Page------------------------------#
    tabPanel("About Our Group",
             titlePanel("Meet the Team"),
             icon = icon("users"),
             tags$div(
               id = "container",
               tags$div(id = "full-content",
                        tags$div(id = "inline-portfolios", 
                                 tags$div(class = "member",
                                          "This project was created by Max Beeson, Liangqi Cai, Divya Rajasekhar, YuYu Madigan
                                          in June of 2019 for the Informatics 201 Lecture B final project. This uses data from",
                                          tags$a(href = "https://www.kaggle.com/vincela9/charlottesville-on-twitter#aug17_sample.csv", "Kaggle"),
                                          " as well as utilizing the ", 
                                          tags$a(href = "https://developer.nytimes.com/indexV2.html", "New York Times API")
                                 ),
                                 
                                 tags$div(class = "member", 
                                          img(src = "max.jpg"),
                                          tags$div(class = "name", "Max Beeson"),
                                          tags$div(class = "description", "Max Beeson is a Sophomore in the Foster School of Business.")),
                                 
                                 tags$div(class = "member", 
                                          img(src = "cai.gif"),
                                          tags$div(class = "name", "Liangqi Cai"),
                                          tags$div(class = "description", "Lianqi Cai is a Sophomore and undeclared.")),
                                 
                                 tags$div(class = "member", 
                                          img(src = "divya.jpg"),
                                          tags$div(class = "name", "Divya Rajasekhar"),
                                          tags$div(class = "description", "Divya Rajasekhar is a Junior studying ACMS.")),
                                 
                                 tags$div(class = "member", 
                                          img(src = "yuyu.png"),
                                          tags$div(class = "name", "YuYu Madigan"),
                                          tags$div(class = "description", "YuYu Madigan is a freshman with an intended major of informatics."))
                                 
                        )
               )
             )
    )
    )
    )