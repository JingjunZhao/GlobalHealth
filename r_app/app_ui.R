library(shiny)
library(rsconnect)
library(htmltools)

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
    Below, is a breakdown of the problem by major themes in the topic of interest",
  strong("(1) Health Indicators - how to define health inequality?"), 
    "Using some important indicator including morality rates, vaccination rates, and HIV incidence could help us to compare and realize the how much some of the countries are left behind and the significance of promoting health equity. All the indicators are essential medical needs that citizens today require for well-being and are influential to judge one country's medical level. The stakeholders are essentially everyone in the world, because one nation’s medical care policies are, as mentioned, influential to every single individual. One could be benefit from a well-established health system, and one could be also suffered from poor-designed and financial incapable health system.",
  strong("(2) Debts - how much debts are these “Global South” countries facing?"),
    "As discussed, we made the prediction that the debts were a primary reason for the inequality of the health system, so we want to take time to look at the reason and amount of money behind the debts, which influence governments’ spending decisions and citizen’s welfare.", 
  strong("(3) Austerity - How were paying back debts influence the health system?"),
            "Then, we have to prove our assumption by linking the debt-paying to the insufficient healthcare system. Debts include loans from multilateral lending agencies and bilateral loans take up a big component of government expenditure and lead to no-choice austerity that makes the government cut expenses in education, healthcare, and so on. Governments spend more money on debt payments than on public health, and COVID intensifies the debt situation, giving the government even more debts, more pressure to repay the debts, and exposed shortages in the national healthcare system are exposed: even though the governments built primary healthcare system to provide basic care to their citizens, the high demand for healthcare but the countries only have a limited number of workers with low payment."),
  h4("Direct and Indirect Stakeholders"),
  p("The direct stakeholders would be citizens in all these countries who suffers from limited medical resources, and the indirect stakeholders can be everyone in the world. Under the pandemic situation, the public health is essentially important and the well-being in one place would positively relate to the other, and vice versa."),
  h4("Human Values"),
  p("Human value that we want to propose in our project would be integrity and equality."),
  h4("Possible harms and benefits"),
  p("There are many organizations taking actions in improving this situation, including advocating debt relif and donating essential health equipment, which is a good start shows more and more of us are realizing this problem. We making this project primarily want that we can let people be aware about it and using the data visualization to demonstrate how bad it is."),
  h4("Related Work References"),
  p(a(" “Racial Inequities Persist in Health Care Despite Expanded Insurance”",
              href = "https://www.nytimes.com/2021/08/17/health/racial-disparities-health-care.html"
    ),
    "- New York Times, Roni Caryn Rabin"),
  p(a("“Aid in reverse: how poor countries develop rich countries”",
              href = "https://www.theguardian.com/global-development-professionals-network/2017/jan/14/aid-in-reverse-how-poor-countries-develop-rich-countries"
    ),
    "- the Guardian, Jason Hickle"),
  p(a("“END AUSTERITY, A Global Report on Budget Cuts and Harmful Social Reforms in 2022-25”",
              href = "https://assets.nationbuilder.com/eurodad/pages/3039/attachments/original/1664184662/Austerity_Ortiz_Cummins_FINAL_26-09.pdf"
    ),
    "- Isabel Ortiz and Matthew Cummins"),
  h2("Research Questions"),
  p("Here are the questions we sought to answer in our research project:"),
  p(strong("1) "),"To define the inequality: compared to other countries that have no or little debt, how much money, or what percentage of the government compensation are spent on healthcare that are suffering from international debts?",
    strong("2) "), "For the “Global South” country, compared to money spent on debts, how much money, or what percentage of the government compensation are spent on healthcare?",
    strong("3) "), "For the “Global South” country, how insufficient are they in the perspective of the health system?",
    strong("4) "), "What is the standard level of health resource for a country to equip?"),
  h2("Data"),
  p("Our project uses three datasets. The", strong("first"), " data set is from OECD, Organisation for Economic Co-operation and Development, and Nextjournal combined three sets of data form OECD together to calculate the ", a("health spending", href= "https://nextjournal.com/fiona-spooner/government-health-expenditure"), "as a share of total government expenditure. We think this combination finished by Nextjournal, an organization working on improving data-driven research, is more straightforward compared to the raw data to deliver our purposes of the project. 
  The", strong("second"), " data set is from Debt Justice, an organization based in the UK that provides the public with easy-access data about debt crises around the world. Debt Justice and Citizens for Financial Justice created the ", a("Debt Data Portal",  href = "https://data.debtjustice.org.uk/"), ", which compiles key statistics on the debts of different countries and governments globally. The Debt Data Portal is where we got our debt data for the second chart in this project, and for each country, it provides the JDC (Jubilee Debt Campaign) Risk Index, IMF Risk Index, government external debt payments, net creditor/debtor score, private external debt, and current account balance.
  The ", strong("third"), " data set is from the World Bank Group associated with WHO, UNICEF, UNFPA, and the United Nations Population Division. This data set depicts the ", a("Maternal Mortality Ratio", href = "https://data.worldbank.org/indicator/SH.STA.MMRT?end=2017&start=2000&view=map"), "of countries across the world from 2000-2017. However, we filtered out the data to focus on 2017. "),
  h2("Key Findings & Discussion"),
  p("words"))

page_one <- tabPanel(
  "Graph 1",
    sliderInput(inputId = "range","Health_Spending_percentage", 0, max(map_share_2019$Health_percentage, na.rm = TRUE), value = range(map_share_2019$Health_percentage)),
    titlePanel("Health Spending as a Share of Government Expenditure"),
    mainPanel(
      plotOutput(outputId = 'map'),
      p("This Chart shows in 2019 each country has what share of their government spending was spent on health. Using the slide feature, this chart can directly show the inequality of health-related spending all over the world and filter out countries with low health expenditures to testify the austerity and link to the following debt and health well-being chart. "))
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
  titlePanel("Maternal Mortality Rate in 2017"),
  sidebarPanel(
    selectInput("country", "Country:",
                choices = colnames(mmr_data$Country)),
    hr(),
    helpText("Data collected from WHO, UNICEF, UNFPA, World Bank Group, and the United Nations Population Division")
  ),
  mainPanel(
    plotlyOutput(outputId = ("plot_mmr")),
    p("This bar plot depicts the maternal mortality ratio of various countries in 2017. With the drop down feature, users can compare any combination of countries to view the difference in mortality rate based on the government funding available to treat these mothers during their pregnancy. This chart includes countries from various levels of economic stability making it clear to see the inequality in healthcare accessibility people face when it comes to the economic status of their country.")
  )
)

conclusion_pg <- tabPanel(
  "Conclusion",
  titlePanel("Final Analysis"),
  h3("Summary Takeaways"),
  p("In conclusion, from this project, we can certainly testify to our initial hypothesis that there is an important correlation between the international debts and health inequality, that the more a country owed, the more likely the country had poor medical conditions. As a first takeaway, using maternal mortality ratio as a health indicator, the health inequalities situation is serious all over the world, and the poor data in African countries specifically contributed to this situation. Secondly, the inequality and limited conditions in these southern countries can be tied back to their governments’ restricted spending and austerity policy. Based on the map chart, the exact countries with high maternal mortality ratio have low percentage of health spending as a share of government expenditure, meaning these countries’ governments provide limited medical resources and workforce. Therefore, the restrcited government health expenditure is a main reason that led to the inequality. Finally, we can prove that debt is the main reason leading to the austerity policy and directly cut down the health -related expenditure. The countries with more payments during are likely to have a low percentage of expenditure spent on health. Thus, we can conclude that international debts are a significant factor in causing health inequality, and if we want to eliminate this gap, debts are a crucial problem that we need to recognize and resolve.")
)


### ui page ###
ui <- navbarPage(
  "Global Health Spending",
  intro_page,
  page_one,
  page_two,
  page_three,
  conclusion_pg
)

