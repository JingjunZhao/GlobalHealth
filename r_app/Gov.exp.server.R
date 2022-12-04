#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("../source/per capital.R")
library(shiny)

server <- function(input, output) {
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
}