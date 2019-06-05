install.packages("devtools")
install.packages("tidyr")
library("jsonlite")
library("devtools")
library("dplyr")
library("tidyr")
library("ggplot2")

twitter <- read.csv("data/tweet_count_time_series.csv", stringsAsFactors = FALSE)

begin_date <- "20170805"
end_date <- "20170825"
term <- "Charlottesville+Virginia"
key <- "z8ha000iwkU3s7jPUSsH1wG2LfaGVSoZ"

nyt_url <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",key, sep="")

initialQuery <- fromJSON(nyt_url)
maxPages <- round((initialQuery$response$meta$hits[1] / 10)-1) 
pages <- list()
for(i in 0:maxPages){
  nytSearch <- fromJSON(paste0(nyt_url, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages[[i+1]] <- nytSearch 
  Sys.sleep(5) 
}

nyt_data <- rbind_pages(pages)


