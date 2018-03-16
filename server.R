# Developing Data Products - Programming Assignement 3
# Jeff Sternin
# Mar 14, 2018
#
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$waitingHist <- renderPlot({
    waiting    <- faithful$waiting   # generate bins based on input$bins from ui.R
    bins1 <- seq(min(waiting ), max(waiting ), length.out = input$bins1 + 1)
    # draw the histogram with the specified number of bins
    hist(waiting , breaks = bins1, col = 'darkgray', border = 'white')
  })
  output$eruptionsHist <- renderPlot({
    eruptions <- faithful$eruptions # generate bins based on input$bins from ui.R
    bins2 <- seq(min(eruptions ), max(eruptions ), length.out = input$bins2 + 1)
    # draw the histogram with the specified number of bins
    hist(eruptions , breaks = bins2, col = 'darkgray', border = 'white')
  })
  model <- reactive({
    brushed_data <- brushedPoints(faithful, input$brush1,xvar = "eruptions", yvar =  "waiting")
    if(nrow(brushed_data) < 2){
      return(NULL)
    }
    fit<-lm(waiting ~ eruptions, data = brushed_data)
    
  })
  output$slopeOut <- renderText({
    if(is.null(model())){ "No Model Found" } 
    else { model()[[1]][2] }
  })
  # ...
  output$intOut <- renderText({
    if(is.null(model())){ "No Model Found"} 
    else { model()[[1]][1]}
  })
  output$adjRsquaredOut <- renderText({
    if(is.null(model())){ "No Model Found"} 
    else { 
      summary(model())[[9]]
    }
  })
  output$plot1 <- renderPlot({
    plot(faithful$eruptions, faithful$waiting,  xlab = "eruptions (min)",
         ylab = "waiting (min)", main = "Old Faithful Geyser",
         cex = 1.5, pch = 16, bty = "n")
    if(!is.null(model())){
      abline(model(), col = "blue", lwd = 2)
    }
  })
})

