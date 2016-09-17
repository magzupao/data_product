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
  titlePanel("Coursera Developing Data Products"),
  h4("September 2016 - Author: Marco Guado"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "Number of trees:",
                  min=0, max=100, value=30),
      helpText("Note: Forest Random algorithm used in our model ",
               "to predict that workout with weights is better, ",
               "we can see that higher values of 30 our system becomes stable and reliable.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("carsPlot")),
        tabPanel("Summary", verbatimTextOutput("carsSummary")),
        tabPanel("Raw Data", tableOutput("tableData")) 
      )
    )
  )
))
