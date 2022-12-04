server <-  function(input, output) {
  output$chart_two <- renderPlotly({
    shiny_chart_two_data <- debt_and_health_spending %>%
      filter(JDC_risk_2021 == input$risk)
    plot <- ggplot(data = shiny_chart_two_data) +
      geom_point(mapping = aes(x = net_creditor_debtor_2020,
                               y = health_perc_expenditure,
                               color = JDC_risk_2021)) +
      xlim(-425, 505) +
      ylim(-5, 25) +
      labs(title = "Net Debt vs. Health Spending",
           subtitle = "Subtitle",
           caption = "This is what the data shows.",
           x = "Net Creditor/Debtor",
           y = "Health Spending (% of Govt. Expenditure)",
           color = "JDC Risk (2021)")
    chart_2 <- ggplotly(plot)
    chart_2
  })
}



# ----------------------------- EXAMPLE ----------------------------------------
#
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#   
#   output$distPlot <- renderPlot({
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white',
#          xlab = 'Waiting time to next eruption (in mins)',
#          main = 'Histogram of waiting times')
#   })
# }
