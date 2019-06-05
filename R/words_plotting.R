#install.packages("tokenizers")
#install.packages("tidytext")
library("tidytext")
library("dplyr")
library("ggplot2")
library("tidyr")
library("plotly")
library("jsonlite")
library("lubridate")
data(stop_words)


make_plot <- function(data_source, day, pos_or_neg)
{
if(data_source == "Twitter")
{
  dfs <- get_twitter_df(day)
  twitter_bar_plot(dfs, day, pos_or_neg)
  pct_graph_twitter(dfs, day)
}else(data_source == "New York Times")
  {
    dfs <- nyt_data_as_df(day)
    nyt_bar_plot(dfs, day, pos_or_neg)
    pct_graph_nyt(dfs, day)
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


twitter_bar_plot <- function(dfs, day, pos_or_neg)
{
twitter_words_for_plot <- dfs
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
else if(pos_or_neg == "All Words")
{
  twitter_ggtitle <- ggtitle(paste("Top 20 Most used Words in Charlottesville Tweets on August",
                                   day))
}

top_twenty_words_twitter <- head(twitter_words_for_plot,20)
twitter_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))

twitter_plot <- ggplot(data = top_twenty_words_twitter,aes(x = word, y = n)) +
  geom_col(stat = "indentity")


show(twitter_plot + twitter_ggtheme + twitter_ggtitle)
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
p <- plot_ly(twitter_summary_pct, labels = ~sentiment, values = ~s_sum, type = 'pie') %>%
  layout(title = paste("Percentage of Positive and Negative Tweets on August", day),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
p
}

nyt_data_as_df <- function(day)
{
nyt_data <- read.csv("data/nyt_data.csv", stringsAsFactors = F)
nyt_data <- mutate(nyt_data, response.docs.pub_date = day(response.docs.pub_date))
nyt_data <- mutate(nyt_data, response.docs.snippet = 
                     paste(response.docs.lead_paragraph, response.docs.abstract, 
                           response.docs.snippet))
nyt_data <- filter(nyt_data, response.docs.pub_date == day)

sentiment <- get_sentiments("bing")
nyt_token_df <- unnest_tokens(nyt_data, word, response.docs.snippet)

nyt_token_df <- nyt_token_df %>%
  inner_join(sentiment) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

return(nyt_token_df)
}

nyt_bar_plot <- function(dfs, day, pos_or_neg)
{
  nyt_token_df <- dfs
  if(pos_or_neg == "Positive")
  {
    nyt_words_for_plot<- filter(nyt_token_df, sentiment == "positive")
    nyt_ggtitle <- ggtitle(paste("Most used", pos_or_neg, 
                                     "Words in NYT Charlottesville Coverage on August",
                                     day))
  }
  else if(pos_or_neg == "Negative")
  {
    nyt_words_for_plot <- filter(nyt_token_df, sentiment == "negative")
    nyt_ggtitle <- ggtitle(paste("Most used", pos_or_neg, 
                                     "Words in NYT Charlottesville Coverage on August",
                                     day))
  }
else if(pos_or_neg == "All Words")
{
  nyt_words_for_plot <- nyt_token_df
  nyt_ggtitle <- ggtitle(paste("Most used",
                               "Words in NYT Charlottesville Coverage on August",
                               day))
}
  
  top_twenty_words_nyt <- head( nyt_words_for_plot,20)
  nyt_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))
  
  nyt_plot <- ggplot(data = top_twenty_words_nyt,aes(x = word, y = n)) +
    geom_col(stat = "indentity")
  
  
show(nyt_plot + nyt_ggtheme + nyt_ggtitle)
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
  p <- plot_ly(nyt_summary_pct, labels = ~sentiment, values = ~s_sum, type = 'pie') %>%
    layout(title = paste("Percentage of Positive and Negative Words in the NYT Selections on August", day),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  return(p)
}

