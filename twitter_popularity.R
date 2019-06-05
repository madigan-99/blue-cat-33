library("dplyr")
library("ggplot2")
library("tidyr")

twitter_popularity <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count, friends_count, followers_count)
  filter_data <- na.omit(filter_data)
  sort_followers <- filter_data %>% group_by(followers_count) %>% summarise(avg_len = mean(length))
  sort_statuses <- filter_data %>% group_by(user_statuses_count) %>% summarise(avg_len = mean(length))
  sort_favorites <- filter_data %>% group_by(user_favorites_count) %>% summarise(avg_len = mean(length))
  sort_friends <- filter_data %>% group_by(friends_count) %>% summarise(avg_len = mean(length))
  
#p <- plot_ly(data, )
    
}
