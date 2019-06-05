#install.packages("plotly")
library("plotly")
library("dplyr")
library("ggplot2")
library("tidyr")

twitter_popularity <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count, friends_count, followers_count)
  filter_data <- na.omit(filter_data)
  
  followers_sorted <- filter_data %>% group_by(followers_count) %>% summarise(avg_len = mean(length))
  
  statuses_sorted <- filter_data %>% group_by(user_statuses_count) %>% summarise(avg_len = mean(length))
  
  favorites_sorted <- filter_data %>% group_by(user_favorites_count) %>% summarise(avg_len = mean(length))
  
  friends_sorted <- filter_data %>% group_by(friends_count) %>% summarise(avg_len = mean(length))
  
  #combine multiple scatter plots 
  #p <- plot_ly(data, x = ~followers_sorted, y = ~statuses_sorted, favorites_sorted, friends_sorted, type = "scatter", 
    #title = "Comparing Twitter Followers to Users' Activity") %>%
    #layout(title = "Comparing # of Twitter Followers to Users' # of Friends, # of Favorites, and # of Statuses", 
            #xaxis = 
            #yaxis =
            #scatter.smooth
    
}
