# Chart 2 - Scatter Plot - Debt and Health Spending
library("dplyr")
library("tidyverse")
library("ggplot2")
library("plotly")

# Import Data
debt_data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/data/debt_data_portal.csv", stringsAsFactors = FALSE)
health_spending_data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/data/expenditure_as_a_share.csv", stringsAsFactors = FALSE)

## Editing debt data
debt <- debt_data %>%
  rename("JDC_risk_2021" = JDC.Risk..2021.) %>%
  rename("net_creditor_debtor_2020" = Net.creditor...debtor..2020.)

## Editing health spending data
health_spending <- health_spending_data %>%
  rename("health_perc_expenditure" = Indicator.Domestic.general.government.health.expenditure..GGHE.D..as.percentage.of.general.government.expenditure..GGE.....) %>%
  rename("Country" = Entity) %>%
  group_by(Country) %>%
  summarize(Year = Year,
            most_recent_year = max(Year),
            health_perc_expenditure = health_perc_expenditure) %>%
  filter(Year == most_recent_year) %>%
  subset(select = -(most_recent_year))

## Join debt and health spending tables
debt_and_health_spending <- health_spending %>%
  left_join(debt, by = "Country")

## Plotting
plot <- ggplot(data = debt_and_health_spending) +
  geom_point(mapping = aes(x = net_creditor_debtor_2020,
                           y = health_perc_expenditure,
                           color = JDC_risk_2021)) +
  geom_smooth(mapping = aes(x = net_creditor_debtor_2020,
                            y = health_perc_expenditure),
              method = loess,
              formula = y ~ x) +
  labs(title = "Net Debt vs. Health Spending",
       subtitle = "Subtitle",
       caption = "This is what the data shows.",
       x = "Net Creditor/Debtor",
       y = "Health Spending (% of Govt. Expenditure)",
       color = "JDC Risk (2021)")
chart_2 <- ggplotly(plot)
print(chart_2)

