

shinyServer(function(input, output, session){
  
  #----------------------------------------------------------------------------------------------
  # bring list of tweet
  #----------------------------------------------------------------------------------------------
  
  observeEvent(input$Go, { 
    
    tweets <- twit_extract(input$page, input$n_page) 
    
    
    output$tab <- renderTable({
      tweets[,c(11,1,17)] }, striped = T, bordered = T, hover = T , align = 'c', spacing = 'm' )
    
    output$neg <- renderInfoBox({
      infoBox('Negative tweets', dim(tweets[tweets$pol==-1,])[1], fill= F, color = 'red')
    })
  
    output$pos <- renderInfoBox({
      infoBox('Positive tweets', dim(tweets[tweets$pol==1,])[1], fill= F, color = 'green')
    })
    
    output$neu <- renderInfoBox({
      infoBox('Neutral tweets', dim(tweets[tweets$pol==0,])[1] , fill= F, color = 'yellow')
    })
    
    t <- as.data.frame(tweets[,1])
    corp <- Corpus(DataframeSource(t))
    corp <- tm_map(corp, removeNumbers)
    corp <- tm_map(corp, removePunctuation )
    #corp <- tm_map(corp, stemDocument)
    corp <- tm_map(corp, removeWords, stopwords("english"))
    corp <- tm_map(corp, stripWhitespace)
    
    dtm <- DocumentTermMatrix(corp)
    dtm2 <- as.matrix(dtm)
    
    freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
    
    output$wordcloud <- renderPlot({ 
      wordcloud(names(freq),freq,min.freq = 50, colors = brewer.pal(6,"Dark2"))

      })
    
    

    
    })
  
  
  
})
  
  
  
  
