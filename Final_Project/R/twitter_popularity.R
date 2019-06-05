twitter_popularity <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count, followers_count)
  
  pattern <- "https://t.co/"
  
  #creating a data frame to get two scatterplots in one plot
  
  x <- pull(filter_data, followers_count)
  favorites <- pull(filter_data, user_favorites_count)
  statuses <- pull(filter_data, user_statuses_count)
  
  View(filter_data)
  data <- data.frame(x, favorites, statuses)
  View(data)  
  m <- list(l = 75, 
            r = 75, 
            b = 75, 
            t = 75, 
            pad = 3)
  
  #plotting
  
  plot_ly(type = "scatter", mode = "markers") %>%
    add_trace(x = ~x, y = ~favorites, name = "Number of Favorites", mode = "markers") %>%
    add_trace(x = ~x, y = ~statuses, name = "Number of Statuses", mode = "markers") %>%
  layout(title = "Comparing # of Twitter Followers to Users' Activity",
         xaxis = list(title = "User Activity"),
         yaxis = list(title = "Number of Followers"),
         margin = m,  font = list(color = "#C0C0C0"),
         paper_bgcolor = "transparent",
         plot_bgcolor = "transparent")
  
}

