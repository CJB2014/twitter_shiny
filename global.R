

library(shiny)
library(shinyjs)
library(shinydashboard)
library(twitteR)
library(sentimentr)
library(plyr)
library(dplyr)
library(tm)
library(highcharter)
library(SnowballC)
library(wordcloud)


#setwd('//wdmpsvr01/RedirectedFolders/clemence.burnichon/My Documents/code_repo/twitterapp')


#----------------------------------------------------------------------------------------------
# set up connection to API
#----------------------------------------------------------------------------------------------

twit_extract <- function(string, n){ 
  library(twitteR)
  library(sentimentr)
  library(plyr)
  
  api_key = ''
  api_secret = ''
  token = ''
  token_secret = ''
  
  setup_twitter_oauth(api_key,api_secret,token,token_secret)
  print('Connection ..... Done')
  
  tweets <- searchTwitteR(string, n = n, lang = 'en', resultType = 'recent')
  
  print('Tweets ..... Acquired')
  tweet_df <- twListToDF(tweets)
  
  pol <- sentiment(tweet_df$text)
  pol_agg <- ddply(pol, c('element_id'),summarise, sentiment = sum(sentiment))
  
  tweet_df <- cbind(tweet_df,pol_agg$sentiment)
  tweet_df$pol <- ifelse(tweet_df$`pol_agg$sentiment`>0,1,ifelse(tweet_df$`pol_agg$sentiment`<0,-1,0))
  return(tweet_df)
  #return(tweets)
}

