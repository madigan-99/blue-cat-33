make_plot <- function(data_source, day, df, pos_or_neg, n_words)
{
  if(data_source == "Twitter") {
    twitter_bar_plot(df, day, pos_or_neg, n_words)
  } else {
    nyt_bar_plot(dfs, day, pos_or_neg, n_words)
  }
}

twitter_bar_plot <- function(dfs, day, pos_or_neg, n_words) {
  if(pos_or_neg == "Positive") {
    twitter_words_for_plot <- filter(dfs, sentiment == "positive")
    twitter_ggtitle <- ggtitle(paste("Top", n_words, "Most Used", pos_or_neg, 
                                     "Words in Charlottesville Tweets on August",
                                     day))
  }
  else if(pos_or_neg == "Negative") {
    twitter_words_for_plot <- filter(dfs, sentiment == "negative")
    twitter_ggtitle <- ggtitle(paste("Top", n_words, "Most Used", pos_or_neg, 
                                     "Words in Charlottesville Tweets on August",
                                     day))
  }
  else {
    twitterr_words_for_plot <- df
    twitter_ggtitle <- ggtitle(paste("Top", n_words, "Most Used Words in Charlottesville Tweets on August",
                                     day))
  }
  
  top_twenty_words_twitter <- head(twitter_words_for_plot, n_words)
  twitter_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))
  
  twitter_plot <- ggplot(data = top_twenty_words_twitter, aes(x = word, y = n)) +
    geom_col(stat = "identity")
  
  
  show(twitter_plot + twitter_ggtheme + twitter_ggtitle)
}

nyt_bar_plot <- function(dfs, day, pos_or_neg, n_words) {
  if(pos_or_neg == "Positive") {
    nyt_words_for_plot <- filter(dfs, sentiment == "positive")
    nyt_ggtitle <- ggtitle(paste("Top", n_words, "Most Used", pos_or_neg, 
                                 "Words in NYT Charlottesville Coverage on August",
                                 day))
  }
  else if(pos_or_neg == "Negative") {
    nyt_words_for_plot <- filter(dfs, sentiment == "negative")
    nyt_ggtitle <- ggtitle(paste("Top", n_words, "Most Used",  pos_or_neg, 
                                 "Words in NYT Charlottesville Coverage on August",
                                 day))
  }
  else {
    nyt_words_for_plot <- dfs
    nyt_ggtitle <- ggtitle(paste("Top", n_words, "Most Used",
                                 "Words in NYT Charlottesville Coverage on August",
                                 day))
  }
  
  top_twenty_words_nyt <- head( nyt_words_for_plot,n_words)
  nyt_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))
  
  nyt_plot <- ggplot(data = top_twenty_words_nyt,aes(x = word, y = n)) +
    geom_col(stat = "identity")
  
  show(nyt_plot + nyt_ggtheme + nyt_ggtitle)
}
