install.packages("devtools")
install.packages("tidyr")
library("jsonlite")
library("devtools")
library("dplyr")
library("tidyr")
library("ggplot2")
library("lubridate")
library(plotly)

twitter <- read.csv("C:/Junior Year/INFO/blue-cat-33/data/tweet_count_time_series.csv", stringsAsFactors = FALSE)
# Get data through NYT API
begin_date <- "20170805"
end_date <- "20170825"
term <- "Charlottesville+Virginia"
source("~/key.R")

nyt_url <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",nyt_key, sep="")

initialQuery <- fromJSON(nyt_url)
maxPages <- round((initialQuery$response$meta$hits[1] / 10)-1) 
pages <- list()
for(i in 0:maxPages){
  nytSearch <- fromJSON(paste0(nyt_url, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages[[i+1]] <- nytSearch 
  Sys.sleep(5) 
}

nyt_data <- rbind_pages(pages)

View(nyt_data)

# Make plot function

my_color <- c(
  "rgb(241, 188, 172)", "rgb(241, 171, 206)", "rgb(223, 172, 240)",
  "rgb(170, 172, 240)", "rgb(128, 162, 227)", "rgb(167, 129, 226)",
  "rgb(227, 129, 211)", "rgb(227, 127, 137)"
)

first_graph <- function(date, name) {
  if (name == "Twitter") {
    twitter <- read.csv("data/tweet_count_time_series.csv", stringsAsFactors = FALSE)
    twitter_data <- twitter %>% group_by(created_at_day, created_at_hour) %>% summarise(sum_count = sum(tweet_count)) %>%
      filter(created_at_day %in% date)
    plot_ly(twitter_data, x = ~created_at_hour, y = ~sum_count, name = 'High 2014', type = 'scatter', mode = 'lines', 
            group = twitter_data$created_at_day, line = list(color = my_color[0:length(date)], width = 4))
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
                   "<br>Number of Atricle:", n
                 )
    ) %>%
      layout(
        title = "New York Time",
        font = list(color = "#C0C0C0"),
        xaxis = list(title = "The date atricle published"),
        yaxis = list(title = "The number of article published"),
        paper_bgcolor = "transparent",
        plot_bgcolor = "transparent"
    )
  }
}
<<<<<<< HEAD
=======
date <- c("16", "17", "18", "19")

first_graph(date, "NYT")
>>>>>>> a780481f0ab7b143db0bf28ef64eb75e455264e7












