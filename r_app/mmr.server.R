#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("../source/MMR.R")

server <- function(input, output) {
  outputPlotly$mmr_plot <- renderPlotly({
    barplot(mmr_data[,input$country], 
            main=input$country,
            ylab="Maternal Mortality Rate",
            xlab="Country")
  })
}



