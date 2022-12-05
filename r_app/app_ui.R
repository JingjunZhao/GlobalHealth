library(shiny)
library(rsconnect)

### Sourcing ###
source("../source/chart_2.R")
source("../source/MMR.R")

### Variables ###
x <- debt_and_health_spending$JDC_risk_2021 %>%
  unique()
risk_choices <- x[-c(2)]

### Tabs ###
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Our Project"),
  h2("heading 1"),
  p("Words about project here")
)

page_one <- tabPanel(
  "Graph 1",
    sliderInput(inputId = "range","Health_Spending_percentage", 0, max(map_share_2019$Health_percentage, na.rm = TRUE), value = range(map_share_2019$Health_percentage)),
    titlePanel("Health Spending as a Share of Government Expenditure"),
    mainPanel(
      plotOutput(outputId = 'map'))
  )


page_two <- tabPanel(
  "Graph 2",
  titlePanel("Government Debt"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "risk",
        label = "JDC Risk (2021)",
        choices = risk_choices
      )
    ),
    mainPanel(
      plotlyOutput(
        outputId = "chart_two"
      )
    )
  )
)

page_three <- tabPanel(
  "Graph 3",
  titlePanel("Health Indicators")
)

conclusion_pg <- tabPanel(
  "Conclusion",
  titlePanel("Final Analysis"),
  h2("heading 1"),
  p("Words about project here")
)

page_four <- tabPanel(
  "Graph 3",
  titlePanel("Maternal Mortality Rate in 2017"),
  sidebarPanel(
    selectInput("country", "Country:",
                choices = colnames(Country)),
    hr(),
    help.Text("Data collected from WHO, UNICEF, UNFPA, World Bank Group, and the United Nations Population Division")
    ),
  mainpanel(
    plotOutput(
      outputId = ("plot_mmr"))
))




### ui page ###
ui <- navbarPage(
  "Global Health Spending",
  intro_page,
  page_one,
  page_two,
  page_three,
  page_four,
  conclusion_pg
)

# ----------------------------- EXAMPLE ----------------------------------------
#
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#   
#   # Application title
#   titlePanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30)
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot")
#     )
#   )
# )
