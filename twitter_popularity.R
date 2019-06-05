twitter_popularity <- function(data) {
  filter_data <- data %>% select(user_statuses_count, user_favorites_count, followers_count)

  pattern <- "https://t.co/"
  
  #creating a data frame to get two scatterplots in one plot
 
  x <- followers_count
  num1 <- user_favorites_count
  num2 <- user_statuses_count
  data <- data.frame(x, nums1, num2)
  
  m <- list(l = 75, 
            r = 75, 
            b = 75, 
            t = 75, 
            pad = 3)
  
  #plotting
  
  plot <- plot_ly(data, x = ~x) %>%
    add_trace(y = ~num1, name = "Number of Favorites", mode = "markers") %>%
    add_trace(y = ~num2, name = "Number of Statuses", mode = "markers")
    layout(title = "Comparing # of Twitter Followers to Users' Activity",
            xaxis = list(title = "User Activity"),
            yaxis = list(title = "Number of Followers"),
            margin = m)

  return(plot)    
}
