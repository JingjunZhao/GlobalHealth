library(shiny)
library(rsconnect)
library(htmltools)
library(shinythemes)

### Sourcing ###
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/chart_2.R")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/MMR.R")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/source/per%20capital.R")

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
    a("Jingjun Zhao", href = " jzhao2@uw.edu")
    ),
  p("Access and availability of health and medical care varies around the world. Many “Global South” countries have been found to have a smaller health workforce and medical resources. Our research seeks to better understand the causes of this inequality gap in healthcare between different countries. In this report we explore what we found as an important, but often overlooked, limiting factor to health care, which is government debt."),
  p("To understand our ", strong("problem domain"), " we decided to look at three major themes to guide our research. The first was health indicators, which would help us define health inequality and what it looks like in each of the countries across the globe. The second was government debt. Particularly in “Global South” countries. The third was austerity and how paying back debts influences the healthcare system. In this project we observe the relationship of debt and funds allocated to health spending in government. The stakeholders in this project are global health organizations, health advocacy groups, researchers and government officials across the globe interested in improving health systems. Our stakeholders also include basically all citizens that would benefit from improved healthcare, especially in countries facing economic crisis and those in the global south. Indirectly, while everyone in the world is involved, as health care access is a universal human right, the benefit of our research would also impact health care workers, providers, and medical researchers. This project centers around the human values of equality and integrity. The benefit of this project is spreading awareness about the gravity of the issue and supporting organizations who focus on debt relief and donating health equipment. However, the potential harm in this project is overgeneralization and possible overlooking of more specific root causes of health inequality at a more sub-national/regional level."),
  p("This project seeks to answer the following ", strong("questions:"),
    strong("1) "),"To define the inequality: compared to other countries that have no or little debt, how much money, or what percentage of the government compensation are spent on healthcare that are suffering from international debts?",
    strong("2) "), "For the “Global South” country, compared to money spent on debts, how much money, or what percentage of the government compensation are spent on healthcare?",
    strong("3) "), "For the “Global South” country, how insufficient are they in the perspective of the health system?",
    strong("4) "), "What is the standard level of health resource for a country to equip?"),
  p("Our ", strong("data"), " comes from the Organisation for Economic Co-operation and Development (OCED), Debt Justice (based in the UK) and the Jubilee Debt Campaign, and the World Bank Group in association with WHO, UNICEF, UNFPA, and the United Nations Population Division."),
  p("Overall, these datasets were used to create our visualizations and ultimately answered our research questions. We could see which countries were in debt, and from there, we were able to look at the exact percentages of government expenditure that went into health care in a year. In many of the countries that had lower health spending per capita, rates of maternal mortality were higher, which is an indicator of health inequality. These were part of our ", strong("key findings"), ", which made connections between health spending, government debt and expenditures, and citizen health according to access to health care."),
  img(src = "https://rocketreceivables.com/wp-content/uploads/medical-bills.jpg", width = "40%", height = "40%", align = "center", alt = "Graphic of person holding money symbol representing debt and doctor holding health symbol.")
)

page_one <- tabPanel(
  "Graph 1",
    titlePanel("Health Spending as a Share of Government Expenditure"),
    sliderInput(inputId = "range","Health_Spending_percentage", min(map_share_2019$Health_percentage, na.rm = TRUE), max(map_share_2019$Health_percentage, na.rm = TRUE), value = range(map_share_2019$Health_percentage)),
    mainPanel(
      plotlyOutput(outputId = 'map'),
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
  p("In conclusion, from this project, we can certainly testify to our initial hypothesis that there is an important correlation between the international debts and health inequality, that the more a country owed, the more likely the country had poor medical conditions."),
  h3("First Takeaway"),
  p("Using maternal mortality ratio as a health indicator, the health inequalities situation is serious all over the world, and the poor data in African countries specifically contributed to this situation."),
  h3("Second Takeaway"),
  p("Secondly, the inequality and limited conditions in these southern countries can be tied back to their governments’ restricted spending and austerity policy. Based on the map chart, the exact countries with high maternal mortality ratio have low percentage of health spending as a share of government expenditure, meaning these countries’ governments provide limited medical resources and workforce. Therefore, the restrcited government health expenditure is a main reason that led to the inequality."),
  h3("Third Takeaway"),
  p("Finally, we can prove that debt is the main reason leading to the austerity policy and directly cut down the health -related expenditure. The countries with more payments during are likely to have a low percentage of expenditure spent on health. Thus, we can conclude that international debts are a significant factor in causing health inequality, and if we want to eliminate this gap, debts are a crucial problem that we need to recognize and resolve.")
)

report_pg <- tabPanel(
  "Report",
  titlePanel("Final Analysis"),
  h2("Basic Information"),
  p(strong("Code Name: "), "JAE-3"),
  p(strong("Project Title: "), "Understanding Global Healthcare Inequalities by Country Debt"),
  p(strong("Authors: "), a("Abigail Babila", href = "ababila@uw.edu"), ", ", 
    a("Emma Esteban", href = "esteb@uw.edu"), ", ",
    a("Jingjun Zhao", href = " jzhao2@uw.edu")
  ),
  p(strong("Affiliation: "), "INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
  p(strong("Date: "), "Autumn 2022"),
  h2("Abstract"),
  p("The goal of our research is to better understand the causes of the huge inequality gap between healthcare in different countries. We think this question is important because health is a basic and essential need for all human beings, but the health services provided by many countries in the world are insufficient. We think if we need to solve the problem, we need to first understand the reason that led to this situation. In this case, we find an essential factor and use data to illustrate how the factors are influential to cause the inequality.",
    strong("Keywords: "), em("Health Inequality, International Debts, Government expenditure, the Global South")),
  h2("Introduction"),
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
  h2("Findings"),
  p("Overall, the data we used allowed us to answer our research questions. We could see which countries were in debt, and from there, we were able to look at the exact percentages of government expenditure that went to health care in a year. From the global map chart, the gap in the percentage of health spending is serious and clear, southern countries and especially African countries had low health-related expenditure and a low health spending percentage in terms of government expenditure (less than ten percent), as they are in a lighter color. And the majority of them have and some of them even have close to zero percent, which is significantly insufficient for their citizens to enjoy a well-being health system. The negative correlation between the spending percentage of health expenditure and international debt can be proved through the second chart: the majority of countries that are facing debt crises from both private and public debts have lower spending in health-related policy and facilitation. In comparison, countries with no debt or even have a positive amount of debt, the creditors, are more general in terms of health-related expenditure. The harm caused by low spending is conspicuous: limited money means limited resources and a limited workforce, which leads to an unhealthy population. Using the maternal mortality rate as a health indicator, we can clearly see the seriousness of health inequality and the terrible effects because of the insufficient government input. Countries like Colombia have a mortality rate as high as 50 percent and other African countries also have rates around 30 percent, which is some horrible data to process and imagine and help us to realize the essential effect brought by international debts. Whereas countries like Japan, which has the highest percentage of government expenditure spending on health, has a 0.005 percent of maternal mortality rate. Of course, there are many other causes that led to this result, other than government health spending and health inequality, but the significant trends and data should prove that debt is one of the major causes leading to health inequality."),
  p("As a short conclusion, from this project, we can certainly testify to our initial hypothesis that there is an important correlation between international debts and health inequality, that the more a country owed, the more likely the country had poor medical conditions. We are sure once we build this correlation, more people would notice and understand the harm caused by international debts, as a key contributor to health inequality, and would be more likely to resolve it."),
  h2("Discussion"),
  p("Besides the correlation between debts and health conditions and the well-bings of the countries’ citizens, the project further proves the existence and harm of austerity policies, which refers to a system of economic regulations that a government enacts to manage the debt of the public sector. When a country's public debt is too high and default or being unable to make due payments on its debts is a serious possibility, the government implements austerity measures. Our project proves the potential but harmful effects of the vague word “austerity”. In this situation and such policy, not only health expenditure, sectors like education, retirement pension, and other social welfare would also face serious cuts and further lead to greater social harms and unhealthy situations. Even though this specific project only addressed health-related data and inequality, the serious effect of austerity on health pointed out by our project can essentially indicate its harm to these other sections, which are also significant factors to decide world inequality and citizens' life expectations.  Under this finding, we sure need to understand the harm of austerity and international debt; in addition, actions are needed to promote all kinds of debt relief, and that is actually what many world health organizations begin to do, especially under the outbreak of Covid-19, where the majority countries are facing their economic downsides and in increasing need of health equipment, medicines, and workforce. In light of the pandemic, these countries' pressure on both repaying the bills and taking care of their citizens was dramatized, and the inequality situation was even harsher."),
  p("In response, more world organizations realized it and provide additional help to the countries to handle the overwhelming effects brought by COVID. World Bank has given out loans to help especially for the Global South to repay the bills, and G20 launched Debt Service Suspension Initiative to delay the debt without additional interest to lessen the government pressure. In addition, the UHC (universal health coverage) set up a goal with actually assistant to bring health to anywhere in the world including financial risk protection, access to quality essential healthcare services, and so on to resolve the difficulties."),
  p("Our group wants to use this project to not only point out and testify to the correlation in between, but we want to use this opportunity to let everyone realize this specific reason causing global inequality. Only with more people understanding the effect and reason, we can better solve this question, and more actions and proposals can be done to ask these powerful institutions to make changes and improve inequality."),
  h2("Conclusion"),
  p("Healthcare isn’t only defined by the amount of nurses or doctors or the skills of these workers. Financial stability by the country is an important aspect that impacts the quality and availability of healthcare for the people. Unfortunately, there is a large financial gap between different different countries, specifically in the Global South. Certain areas such as Africa, Latin America, and other develpoping countries face economic instability that makes it difficult to fund something as important as proper healthcare facilities and workers. Through this project, we sought out to find a proper correlation between these two variables and determine the root cause of how government debt is impacting people’s health across the world."),
  p("Based on our findings, we were able to compare the financial aspect of global healthcare with an important indicator of health such as maternal mortalty. Our first chart measuring health spending as a share of governemnt expenditure led us to reach the conclusion that most African and southern countries experience low cost expenditures for healthcare (almost 0%) which consequently provides no access to sufficient health services to the public. Our second chart that specifically investigates government debt supports this notion by demonstrating the correlation that the majority of these countries that are spending less money on healthcare are also in debt both privately and publicly. Finally, we reflected these financial results into investigating real data of mortality ratios of maternal women across various countries. Based on our third graph, there was a strong indirect correlation between maternal mortality and government spending. In other words, our results found that less spending on healthcare and therefore increased debt in a country led to a higher mortality rate overall."),
  p("Countries in the Global South are suffering from insufficient healthcare services based on their governemnt’s lack of funding and financial stability. These developing countries already have limited resources which are contributing to the deteriorating health that’s present there. Factors such as limited access to clean water or poor air quality are already prevalent in these countries. The fact that little to no money is being spent on the healthcare system that is supposed to treat it just makes the situation worse for the people living in these conditions."),
  p("This project touches on only a small aspect of this issue but it’s nonetheless important. Millions of people are suffering around the world because of poor healthcare services stemming from their country’s increasing debt and lack of spending. It is vital to bring to light this economic instability the Global South faces and provide them with the proper healthcare and funding they deserve.")
)


### ui page ###
ui <- navbarPage(
  theme = shinythemes::shinytheme("journal"),
  "Global Health Spending",
  intro_page,
  page_one,
  page_two,
  page_three,
  conclusion_pg,
  report_pg
)


