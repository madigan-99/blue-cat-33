# Team 33 - Blue Cat 
#### Members: Max Beeson, Liangqi Cai, Divya Rajasekhar, YuYu Madigan

## Project Description

#### Data Sets and API's Used
We will be working with the [New York Times API](https://developer.nytimes.com/) as well as a dataset from Kaggle about [Tweets relating to Charlottesville](https://www.kaggle.com/vincela9/charlottesville-on-twitter#aug17_sample.csv
). The New York Times API is created by them and so the data is pulled directly from the source. We will mostly be using data from
August 2017, the time of the Charlottesville protests. The Kaggle daataset allows us to analyze related tweets between August 15-18. It provides data on 
users such as their username, follow counts, retweets, likes, as well as the text of the tweet, hashtags and more. This is a random sample of 50,000 selected tweets.
Additionally, we will use either a Google Maps API or a simiar resource to analyze the geographics of the tweets in relation to Charlottesville. 

#### Target Audience
Our target audience is those interested in the revisiting the events, feelings, and discourse of the Charlottesville protests. By exploring both national, respected, journalism (NYT) and public discourse (Twitter) we hope build a complete picture of how people felt. Additionally, although it is not the main focus, we will examine how people’s reporting on twitter differs from that of the NYT.
#### Related Questions to Explore
* How does the sentiment of those reacting (both the NYT and Twitter users) change day-to-day over the four day period?
* Where did the Tweets originate from geographically and how did they spread?
* Does linking the article affect ones engagement on twitter?
* Does a new published article relates to quantity of tweets? 
* Are there any other factors or trends in tweeting? 

## Technical Description
The data will be read using an API and a static .csv file. We will be filtering the data significantly to reduce its size for running as well as transforming both the CSV And the json data into R data frames. 
We will most likely need to create small test files as well. 
We will use the following packages as well as additional ones yet to be determined. 
* sentimentanalysis -takes string and returns sentiment
* NLP - POS tokenizing and string analysis
* plotly - plotting
* ggplot - plotting and long/lat data


We hope we can understand a relationship between distance from Charlottesville affecting the quantity the content of the tweets. We will also look for relationships between article publishing and quantity. 
We are expecting many challenges with this project including and especially the learning curve to using the new technology. There will be a learning curve to using natural language processors, and understanding how the NYT API works. Once we get over those hurdles, it should work out for us but there is a significant initial time dedication necessary for this. 

## Project Set Up

Our project can be found here at: https://github.com/madigan-99/blue-cat-33

Our project description can be found [here](https://docs.google.com/document/d/1QKxJONnqVa6tjy7QvqlrREe767OG9fCvibo2TRsle4E/edit?usp=sharing)


