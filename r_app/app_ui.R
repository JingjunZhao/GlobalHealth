library(shiny)
library(rsconnect)

intro_page <- tabPanel(
  "Introduction",
  titlePanel("Our Prject"),
  h2("heading 1"),
  p("Words about project here")
)

page_one <- tabPanel(
  "Graph 1",
  titlePanel("Health Spending")
)

page_two <- tabPanel(
  "Graph 2",
  titlePanel("Government Debt")
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

ui <- navbarPage(
  "Global Health Spending",
  intro_page,
  page_one,
  page_two,
  page_three,
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
