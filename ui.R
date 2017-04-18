


shinyUI(fluidPage(
  titlePanel('Brand Sentiment Analysis Tool'),
  sidebarLayout(
    
    sidebarPanel(width = 3, tags$style(".well{background-color:#00ABC2; color:#FFF; font-weight:bold}")
                 #,HTML('<h3><center><b></center></b></h3>')
                 ,textInput(inputId = 'page', label = 'Search a Brand: ',width = '300px')
                 
                 ,sliderInput(inputId = 'n_page', label = 'Number of results:',value = 5000,min = 500, max = 50000, step = 500, width = '300px')
                 ,tags$style(".irs-grid-text{color:#FFF}
                             .irs-slider{background-color:#FFF}
                             .irs-bar{background:#FFF}
                             .irs-bar-edge{background:#FFF}
                             .irs-single{background:#424949}")
                 #,dateInput(inputId = 'from', label = 'From:', value = Sys.time()-31556926)
                 #,dateInput(inputId = 'to', label='To:', value = Sys.time())
                 #,radioButtons(inputId = 'type', label = 'Choose a type of search:', choices = c('mixed','recent','popular'), inline = T)
                 ,actionButton(inputId = 'Go', label = 'Go!' , icon = icon('bolt')
                               , style = "font-weight:bold; background-color:#424949;color:#FFF; border-color:#424949 ")
                 
    )
    
    ,mainPanel( dashboardPage(
      dashboardHeader(disable = T)
      
      ,dashboardSidebar(disable = T)
      
      ,dashboardBody(fluidRow(
        infoBoxOutput(outputId = 'neg')
        ,infoBoxOutput(outputId = 'pos')
        ,infoBoxOutput(outputId = 'neu')
        #tableOutput(outputId = 'tab')
        ,plotOutput(outputId = 'wordcloud')
        
      ))
  )
  )
  )
  ))
