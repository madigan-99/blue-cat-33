#install.packages("tokenizers")
#install.packages("tidytext")
library("tidytext")
library("dplyr")
library("ggplot2")
library("tidyr")
data(stop_words)


make_plot <- function(data_source, day, p_or_n)
{
if(data_source == "Twitter")
{
  twitter_function(day, p_or_n)
}else(data_source == "New York Times")
{
  nyt_function(day, p_or_n)
}
}

twitter_pie <- function(word_sentiment_df)
{
  twitter_summary <- group_by(word_sentiment_df, sentiment) %>%
    summarise(
      sum = sum(n)
    )
  bp<- ggplot(twitter_summary, aes(x="", y=sentiment, fill=sum))+
    geom_bar(width = 1, stat = "identity")
  day_pie_chart <- bp + coord_polar("y", start=0)
  day_pie_chart
}

twitter_function <- function(day, p_or_n)
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

if(p_or_n == "Positive")
{
  twitter_words_for_plot <- filter(twitter_words_for_plot, sentiment == "positive")
  twitter_ggtitle <- ggtitle(paste("Top 20 Most used", p_or_n, 
                                   "Words in Charlottesville Tweets on August",
                                   day))
}
else if(p_or_n == "Negative")
{
    twitter_words_for_plot <- filter(twitter_words_for_plot, sentiment == "negative")
    twitter_ggtitle <- ggtitle(paste("Top 20 Most Used", p_or_n, 
                                     "Words in Charlottesville Tweets on August",
                                     day))
}
else if(p_or_n == "Positive and Negative")
{
  twitter_ggtitle <- ggtitle(paste("Top 20 Most used Words in Charlottesville Wweets on August",
                                   day))
}

top_twenty_words_twitter <- head(twitter_words_for_plot,20)


twitter_ggtheme <- theme(axis.text.x = element_text( size = 8, angle = 90))

twitter_plot <- ggplot(data = top_twenty_words_twitter,aes(x = word, y = n)) +
  geom_col(stat = "indentity")

twitter_pie(twitter_words_for_plot)
twitter_plot + twitter_ggtheme + twitter_ggtitle

}


