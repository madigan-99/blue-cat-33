make_pie_chart <- function(data_source, day, df)
{
  if(data_source == "Twitter")
  {
    pct_graph_twitter(df, day)
  } else {
    pct_graph_nyt(df, day)
  }
}

pct_graph_twitter<- function(dfs, day)
{
  twitter_words_for_plot <- dfs
  twitter_summary <- group_by(twitter_words_for_plot, sentiment) %>%
    summarise(
      s_sum = sum(n)
    )
  total_words <- sum(twitter_summary$s_sum)
  twitter_summary_pct <- mutate(twitter_summary,ratio=s_sum/sum(twitter_summary$s_sum))
  m <- list(
    l = 75,
    r = 75,
    b = 75,
    t = 75,
    pad = 3
  )
  p <- plot_ly(twitter_summary_pct, labels = ~sentiment, values = ~s_sum, type = 'pie') %>%
    
    layout(title = paste("Percentage of Positive and Negative Tweets on August", day),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE, title = "Positive"),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE, title = "Negative"), 
           margin = m,
           font = list(color = "#C0C0C0"),
           paper_bgcolor = "transparent",
           plot_bgcolor = "transparent")
  return(p)
}

pct_graph_nyt<- function(dfs, day)
{
  nyt_token_df <- dfs
  nyt_summary <- group_by(nyt_token_df, sentiment) %>%
    summarise(
      s_sum = sum(n)
    )
  total_words <- sum(nyt_summary$s_sum)
  nyt_summary_pct <- mutate(nyt_summary,ratio=s_sum/sum(nyt_summary$s_sum))
  m <- list(
    l = 75,
    r = 75,
    b = 75,
    t = 75,
    pad = 3
  )
  p <- plot_ly(nyt_summary_pct, labels = ~sentiment, values = ~s_sum, type = 'pie') %>%
    layout(title = paste("Percentage of Positive and Negative Words in the NYT Selections on August", day),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE, title = "Positive"),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE, title = "Negative"), margin = m, 
           font = list(color = "#C0C0C0"),
           paper_bgcolor = "transparent",
           plot_bgcolor = "transparent")
  return(p)
}


