return_df <- function(data_source, day)
{
  if(data_source == "Twitter")
  {
    return(get_twitter_df(day))
    
  } else {
    return(nyt_data_as_df(day))
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
  
  ## Cleaning the new data frame
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
  
  twitter_words_for_plot
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
  
  nyt_token_df
}
