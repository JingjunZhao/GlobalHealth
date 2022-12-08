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
  output$mmr_plot <- renderPlotly({
    mmr_chart_data <- mmr_data %>%
      filter(maternal_mortality == input$country)
    plot <- ggplot(data = chart_three_data) +
      geom_bar(color = "gray",
               x = Country,
               y = maternal_mortality) +
      labs(title = "Maternal Mortality Ratio 2017",
           x = "Country",
           y = "Maternal Mortality Ratio",
           color = "gray")
    chart_three <- ggplotly(plot)
    chart_three
  })


