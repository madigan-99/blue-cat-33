#install.packages("devtools")
#install.packages("tidyr")
library("jsonlite")
library("devtools")
library("dplyr")
library("tidyr")
library("ggplot2")
library("lubridate")
library(plotly)

twitter <- read.csv("data/tweet_count_time_series.csv", stringsAsFactors = FALSE)
nyt_data <- read.csv("data/nyt_data.csv")

# Make plot function

my_color <- c(
  "rgb(241, 188, 172)", "rgb(241, 171, 206)", "rgb(223, 172, 240)",
  "rgb(170, 172, 240)", "rgb(128, 162, 227)", "rgb(167, 129, 226)",
  "rgb(227, 129, 211)", "rgb(227, 127, 137)"
)

first_graph <- function(date, name) {
  date <- as.character(date)
  
  if (name == "Twitter") {
    twitter <- read.csv("data/tweet_count_time_series.csv", stringsAsFactors = FALSE)
    twitter_data <- twitter %>% group_by(created_at_day, created_at_hour) %>% summarise(sum_count = sum(tweet_count)) %>%
      filter(created_at_day %in% date)
    plot_ly(twitter_data, x = ~created_at_hour, y = ~sum_count, name = 'High 2014', type = 'scatter', mode = 'lines+markers', 
            color = ~as.character(created_at_day), width = 4) %>%
      layout(
        title = "",
        font = list(color = "#C0C0C0"),
        xaxis = list(title = "Hour of Twet"),
        yaxis = list(title = "Quantity of Related Tweets"),
        paper_bgcolor = "transparent",
        plot_bgcolor = "transparent")
      
  } else {
    NYT <- nyt_data %>% mutate(day = day(response.docs.pub_date)) %>% select(day) %>% 
      group_by(day) %>% count(day) %>% filter(day %in% date)
    
    plot_ly(NYT,
                 x = ~day,
                 y = ~n,
                 type = "bar",
                 marker = list(color = my_color[0:length(date)]),
                 hoverinfo = "text",
                 text = ~ paste0(
                   "Date:", "8/", day,
                   "<br>Number of Article:", n
                 )
    ) %>%
      layout(
        title = "Date vs Quantity of Articles about Charlottesville",
        font = list(color = "#C0C0C0"),
        xaxis = list(title = "Date of Publication"),
        yaxis = list(title = "Number of Published Articles"),
        paper_bgcolor = "transparent",
        plot_bgcolor = "transparent"
    )
  }
}






