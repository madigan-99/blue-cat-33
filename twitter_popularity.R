library("dplyr")
library("ggplot2")
library("tidyr")

twitter_popularity <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count, friends_count, followers_count)
  filter_data <- na.omit(filter_data)
}
