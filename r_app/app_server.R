library(shiny)
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/per%20capital.R")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/chart_2.R")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/MMR.R")

server <- function(input, output) {

### Chart 1 ####
  observeEvent(map_share_2019, {
    updateSliderInput(
      inputId = "range",
      min = min(map_share_2019$Health_percentage),
      max = max(map_share_2019$Health_percentage),
      value = range(map_share_2019$Health_percentage, na.rm = FALSE)
    )
  })
  
  filter_range <- reactive({
    map_share_2019 %>%
      filter(Health_percentage >= input$range[1]) %>% 
      filter(Health_percentage <= input$range[2])
  })
  output$map<-renderPlotly({ggplotly(ggplot(filter_range(), aes(long, lat, group = group))+
                                       geom_polygon(aes(fill = Health_percentage))+ 
                                       scale_fill_gradient(low = "yellow", high = "red", na.value = NA))
    
  })
  
### Chart 2 ####
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

### Chart 3 ###
  output$plot_mmr <- renderPlotly({
    mmr_chart_data <- mmr_data %>%
      filter(maternal_mortality == input$country)
    plot <- ggplot(data = mmr_three_data) +
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
}
