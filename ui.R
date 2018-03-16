# Developing Data Products - Programming Assignement 3
# Jeff Sternin
# Mar 14, 2018
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser:Waiting/Eruptions hist. & multiple models"),
  sidebarLayout(
    sidebarPanel(  # Sidebar with a slider input for number of bins 
       sliderInput("bins1","Waiting (min) number of bins:", min = 1,max = 50,value = 30),
       sliderInput("bins2","Eruption (min) Number of bins:", min = 1,max = 50,value = 30),
       h3("Slope"),
       textOutput("slopeOut"),
       h3("Intercept"),
       textOutput("intOut"),
       h3("adjRsquared"),
       textOutput("adjRsquaredOut")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
          tabPanel("Waiting (min) Histogram", br(), plotOutput("waitingHist")),
          tabPanel("Eruptions (min) Histogram", br(), plotOutput("eruptionsHist")),
          tabPanel("Eruptions-Waiting regression", br(), 
                   h4("Select points to get regression model"),br(),
                   plotOutput("plot1", brush = brushOpts(id = "brush1"))))

    )
  )
))


