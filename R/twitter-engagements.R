day1 <- read.csv("../data/aug15_sample.csv")
day2 <- read.csv("../data/aug16_sample.csv")
day3 <- read.csv("../data/aug17_sample.csv")
day4 <- read.csv("../data/aug18_sample.csv")

# full_concat <- rbind(day1, day2, day3, day4)

library(dplyr)
library(ggplot2)
library(stringr)

twitter_engagements <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count,
                                 friends_count, followers_count, user_time_zone,
                                 full_text, is_retweet, hashtags)
  filter_data <- na.omit(filter_data)
  filter_data$is_tag <- filter_data$hashtags != ""
  pattern <- "https://t.co/"
  filter_data$has_content <- str_detect(filter_data$full_text, pattern)
  filter_data$length <- length(filter_data$full_text)

}

twitter_engagements(day1)
