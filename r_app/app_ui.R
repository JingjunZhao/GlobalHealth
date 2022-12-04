library(shiny)
library(rsconnect)
library(dplyr)
library(htmltools)

### Sourcing ###
source("../source/chart_2.R")

### Variables ###
x <- debt_and_health_spending$JDC_risk_2021 %>%
  unique()
risk_choices <- x[-c(2)]

### Tabs ###
# ------------------------ Intro tab ------------------
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Understanding Global Healthcare Inequalities by Country Debt"),
  p("Authors: ", a("Abigail Babila", href = "ababila@uw.edu"), ", ", 
    a("Emma Esteban", href = "esteb@uw.edu"), ", ",
    a("Jinjun Zhao", href = " jzhao2@uw.edu")),
  p("“Health for all now!” is the slogan of the People’s Health Movement. However, 
    we are still far from accomplishing it. Along with the outbreak of the pandemic, 
    more and more studies began to focus on longstanding gaps in medical care, 
    especially the inequality in the “Global South'', which caught our attention. 
    We found that many southern countries like countries in Africa have very limited 
    health workforce and resources that are way below the very basic standard set by 
    WHO. To address the concern, we need to solve the question: what would be the 
    main factor causing the huge inequity? According to research, we found one of 
    the most important and unexpected factors that led to and worsen the situation 
    is neocolonialism in the forms of debt. In our project, we will provide data 
    supporting our theory about how international debts have influenced health 
    systems in the “Global South” countries."),
  h2("Problem Domain"),
  h4("Background and Framing"),
  p("The Global South referred to regions within Latin America, Asia, Africa, and Oceania, and specifically means the developing countries in these region that suffer poverty and limited resources. A majorty of these countries suffered international debts from the global bank and advanced countries, and the debt repayment made up a larger portion of their government expenditures.
    Below, is a breakdown of the problem by major themes in the topic of interest"),
  withTags(
  ul(
    li(strong("Health Indicators - how to define health inequality?"),
       "Using some important indicator including morality rates, vaccination rates, and HIV incidence could help us to compare and realize the how much some of the countries are left behind and the significance of promoting health equity. All the indicators are essential medical needs that citizens today require for well-being and are influential to judge one country's medical level. The stakeholders are essentially everyone in the world, because one nation’s medical care policies are, as mentioned, influential to every single individual. One could be benefit from a well-established health system, and one could be also suffered from poor-designed and financial incapable health system."), 
    li(strong("Debts - how much debts are these “Global South” countries facing?"),
       "As discussed, we made the prediction that the debts were a primary reason for the inequality of the health system, so we want to take time to look at the reason and amount of money behind the debts, which influence governments’ spending decisions and citizen’s welfare."), 
    li(strong("Austerity - How were paying back debts influence the health system?"),
       "Then, we have to prove our assumption by linking the debt-paying to the insufficient healthcare system. Debts include loans from multilateral lending agencies and bilateral loans take up a big component of government expenditure and lead to no-choice austerity that makes the government cut expenses in education, healthcare, and so on. Governments spend more money on debt payments than on public health, and COVID intensifies the debt situation, giving the government even more debts, more pressure to repay the debts, and exposed shortages in the national healthcare system are exposed: even though the governments built primary healthcare system to provide basic care to their citizens, the high demand for healthcare but the countries only have a limited number of workers with low payment.")
  )),
  h4("Direct and Indirect Stakeholders"),
  p("The direct stakeholders would be citizens in all these countries who suffers from limited medical resources, and the indirect stakeholders can be everyone in the world. Under the pandemic situation, the public health is essentially important and the well-being in one place would positively relate to the other, and vice versa."),
  h4("Human Values"),
  p("Human value that we want to propose in our project would be integrity and equality."),
  h4("Possible harms and benefits"),
  p("There are many organizations taking actions in improving this situation, including advocating debt relif and donating essential health equipment, which is a good start shows more and more of us are realizing this problem. We making this project primarily want that we can let people be aware about it and using the data visualization to demonstrate how bad it is."),
  h4("Related Work References"),
  withTags(
  ul(
    li(a(" “Racial Inequities Persist in Health Care Despite Expanded Insurance”",
         href = "https://www.nytimes.com/2021/08/17/health/racial-disparities-health-care.html"
    ),
    "- New York Times, Roni Caryn Rabin"
    ),
    li(a("“Aid in reverse: how poor countries develop rich countries”",
         href = "https://www.theguardian.com/global-development-professionals-network/2017/jan/14/aid-in-reverse-how-poor-countries-develop-rich-countries"
    ),
    "- the Guardian, Jason Hickle"
    ),
    li(a("“END AUSTERITY, A Global Report on Budget Cuts and Harmful Social Reforms in 2022-25”",
         href = "https://assets.nationbuilder.com/eurodad/pages/3039/attachments/original/1664184662/Austerity_Ortiz_Cummins_FINAL_26-09.pdf"
    ),
    "- Isabel Ortiz and Matthew Cummins"
    )
  )),
  h2("Research Questions"),
  p("Here are the questions we sought to answer in our research project:"),
  withTags(ol(
    li("To define the inequality: compared to other countries that have no or little debt, how much money, or what percentage of the government compensation are spent on healthcare that are suffering from international debts?"),
    li("For the “Global South” country, compared to money spent on debts, how much money, or what percentage of the government compensation are spent on healthcare?"),
    li("For the “Global South” country, how insufficient are they in the perspective of the health system?"),
    li("What is the standard level of health resource for a country to equip?")
  )),
  h2("Data"),
  p(""),
  h2("Key Findings"),
  p("")
)

# ----------------------------------------------------------------


page_one <- tabPanel(
  "Graph 1",
    sliderInput(inputId = "range","Health_Spending_percentage", 0, max(map_share_2019$Health_percentage, na.rm = TRUE), value = range(map_share_2019$Health_percentage)),
    titlePanel("Health Spending as a Share of Government Expenditure"),
    mainPanel(
      plotOutput(outputId = 'map'),
      p("This is Chart shows in 2019 each country have what share of their government spending was spent on health. Using the slide feature, this chart can directly show the inequality of health-related spending all over the world and filter out countries with low health expenditures to testify the austerity and link to the following debt and health well-being chart."
        )
      )
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
      plotlyOutput(outputId = "chart_two"),
      p("   This chart is a scatter plot showing the relationship between a country's
        government debt and government health spending. Each point represents a country. 
        On the x-axis is the a numeric indicator for net creditor(+) or debtor(-) of 
        that country from 2020. On the y-axis is the health spending as a percent of 
        total government expenditure. This number is taken form the most-recent year of 
        data collection, which most are from 2019 with a few from 2018. The color of 
        each point tells you what the level of debt risk calculated by the Jubilee Debt 
        Campaign. Hover over a point for more specific statistical information."
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

### UI ###
# ----------------------------------------------------------------------------

ui <- navbarPage(
  "Global Health Spending",
  intro_page,
  page_one,
  page_two,
  page_three,
  conclusion_pg
)