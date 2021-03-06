twitter_engagements <- function(data) {
  filter_data <- data %>% select(created_at, user_time_zone,
                                 full_text, is_retweet, hashtags)
  
  pattern <- "https://t.co/"
  col_data <- filter_data %>% mutate(has_hashtag = hashtags != "", 
                                     has_tagged = str_detect(filter_data$full_text, "@"),
                                     has_content = str_detect(filter_data$full_text, pattern),
                                     length = ifelse(has_content == TRUE, str_length(full_text) - 23, str_length(full_text)))
  overall_length <- mean(col_data$length)
  sort_tag <- col_data %>% group_by(has_tagged) %>% summarise(avg_len = mean(length))
  sort_content <- col_data %>% group_by(has_content) %>% summarise(avg_len = mean(length))
  sort_hashtags <- col_data %>% group_by(has_hashtag) %>% summarise(avg_len = mean(length))
  sort_retweet <- col_data %>% group_by(is_retweet) %>% summarise(avg_len = mean(length))
  
  Tweet_features <- c("Has Content", "Has Mentions", "Has Hashtags", "Is a ReTweet")
  true <- c(sort_content$avg_len[2], sort_tag$avg_len[2],
            sort_hashtags$avg_len[2], sort_retweet$avg_len[2])
  false <-c(sort_content$avg_len[1], sort_tag$avg_len[1],
            sort_hashtags$avg_len[1], sort_retweet$avg_len[1])
  data <- data.frame(Tweet_features, true, false)
  m <- list(
    l = 75,
    r = 75,
    b = 75,
    t = 75,
    pad = 3
  )
  p <- plot_ly(data, x = ~Tweet_features, y = ~true, type = 'bar', name = 'True', title = "Comparing Tweet Length") %>%
    add_trace(y = ~false, name = 'False') %>%
    layout(title = "Comparing Tweet Length to Features", 
           xaxis = list(title = "Tweet Features"), 
           yaxis = list(title = 'Average Tweet Character Count'), 
           margin = m,
           barmode = 'group', font = list(color = "#C0C0C0"),
           paper_bgcolor = "transparent",
           plot_bgcolor = "transparent")
  
  return(p)

}


