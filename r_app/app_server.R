source("../source/chart_2.R")

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

