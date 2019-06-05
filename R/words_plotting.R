#install.packages("tokenizers")
#install.packages("tidytext")
library("tidytext")
library("dplyr")
library("ggplot2")
library("tidyr")
library("plotly")
library("jsonlite")
data(stop_words)

make_plot <- function(data_source, day, pos_or_neg)
{
if(data_source == "Twitter")
{
  dfs <- get_twitter_df(day)
  twitter_bar_plot(dfs, day, pos_or_neg)
  pct_graph_twitter(dfs, day)
}
}


get_twitter_df <- function(day)
{
if(day == "15")
{
  twitter_data <- read.csv("data/aug15_sample.csv", stringsAsFactors = F)
} else if(day == "16")
{
  twitter_data <- read.csv("data/aug16_sample.csv", stringsAsFactors = F)
} else if(day == "17")
{
  twitter_data <- read.csv("data/aug17_sample.csv", stringsAsFactors = F)
} else if(day == "18")
{
  twitter_data <- read.csv("data/aug18_sample.csv", stringsAsFactors = F) 
}
  
twitter_text_df <- select(twitter_data, full_text)
twitter_token_df <- unnest_tokens(twitter_text_df, word, full_text)

##Cleaning the new data frame
twitter_token_df <- twitter_token_df %>%
  anti_join(stop_words)

twitter_token_df %>%
  count(word, sort = TRUE) 

twitter_token_df <- filter(twitter_token_df, word != "trump")
sentiment <- get_sentiments("bing")


twitter_words_for_plot <- twitter_token_df %>%
  inner_join(sentiment) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()
return(twitter_words_for_plot)
}


twitter_bar_plot <- function(df, day, pos_or_neg)
{
if(pos_or_neg == "Positive")
{
  twitter_words_for_plot <- filter(twitter_words_for_plot, sentiment == "positive")
  twitter_ggtitle <- ggtitle(paste("Top 20 Most used", pos_or_neg, 
                                   "Words in Charlottesville Tweets on August",
                                   day))
}
else if(pos_or_neg == "Negative")
{
    twitter_words_for_plot <- filter(twitter_words_for_plot, sentiment == "negative")
    twitter_ggtitle <- ggtitle(paste("Top 20 Most Used", pos_or_neg, 
                                     "Words in Charlottesville Tweets on August",
                                     day))
}
else if(pos_or_neg == "Positive and Negative")
{
  twitter_ggtitle <- ggtitle(paste("Top 20 Most used Words in Charlottesville Tweets on August",
                                   day))
}

top_twenty_words_twitter <- head(twitter_words_for_plot,20)
twitter_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))

twitter_plot <- ggplot(data = top_twenty_words_twitter,aes(x = word, y = n)) +
  geom_col(stat = "indentity")


twitter_plot + twitter_ggtheme + twitter_ggtitle
}




pct_graph_twitter<- function(data_frame_twitter, day)
{
twitter_summary <- group_by(twitter_words_for_plot, sentiment) %>%
    summarise(
      s_sum = sum(n)
    )
total_words <- sum(twitter_summary$s_sum)
twitter_summary_pct <- mutate(twitter_summary,ratio=s_sum/sum(twitter_summary$s_sum))
p <- plot_ly(twitter_summary_pct, labels = ~sentiment, values = ~s_sum, type = 'pie') %>%
  layout(title = paste("Percentage of Positive and Negative Tweets on August", day),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
p
}


get_nyt_data <- read.csv("data/nyt_data.csv", stringsAsFactors = F)








