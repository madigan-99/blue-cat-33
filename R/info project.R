##install.packages("devtools", "jsonlite")
library("jsonlite")
library("devtools")
library("dplyr")
library("tidyr")
library("ggplot2")
library("lubridate")

# Get data through NYT API
begin_date <- "20170805"
end_date <- "20170825"
term <- "Charlottesville+Virginia"
source("~/key.R")

nyt_url <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",key, sep="")

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

# Make plot function

first_graph <- function(date, name) {
  if (name == "Twitter") {
    twitter <- read.csv("data/tweet_count_time_series.csv", stringsAsFactors = FALSE)
    twitter_data <- twitter %>% group_by(created_at_day, created_at_hour) %>% summarise(sum_count = sum(tweet_count)) %>%
      filter(created_at_day %in% date)
    ggplot(data = twitter_data, aes(x = created_at_hour, y = sum_count, group = created_at_day, colour = as.factor(created_at_day)))+
    geom_line()
  } else {
    NYT <- nyt_data %>% mutate(day = day(response.docs.pub_date)) %>% select(day) %>% 
      group_by(day) %>% count(day) %>% filter(day %in% date)
    
    ggplot(data = NYT, aes(x = day, y = n, fill = day)) +
        geom_bar(stat = "identity") +
        theme_classic() +
        labs(
          x = "The date article published",
          y = "The number of article published",
          title = paste(
            "New York Time paper article"
        )
      )
  }
}

date <- c("16", "17", "18", "19")

first_graph(date, "NYT")












