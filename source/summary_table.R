### P2 Summary Table

debt_data <- read.csv("../data/debt_data_portal.csv", stringsAsFactors = FALSE)
health_spending_data <- read.csv("../data/expenditure_as_a_share.csv", stringsAsFactors = FALSE)

## Editing debt data
debt <- debt_data %>%
  rename("JDC_risk_2021" = JDC.Risk..2021.) %>%
  rename("net_creditor_debtor_2020" = Net.creditor...debtor..2020.) %>%
  subset(select = -(IMF.Risk..2022.)) %>%
  subset(select = -(Government.external.debt.payments..2021.)) %>%
  subset(select = -(Private.external.debt..2020.)) %>%
  subset(select = -(Current.account.balance..2021.))

## Editing health spending data
health_spending <- health_spending_data %>%
  rename("health_perc_expenditure" = Indicator.Domestic.general.government.health.expenditure..GGHE.D..as.percentage.of.general.government.expenditure..GGE.....) %>%
  rename("Country" = Entity) %>%
  rename("health_perc_year" = Year) %>%
  group_by(Country) %>%
  summarize(health_perc_year = health_perc_year,
            most_recent_year = max(health_perc_year),
            health_perc_expenditure = health_perc_expenditure) %>%
  filter(health_perc_year == most_recent_year) %>%
  subset(select = -(most_recent_year))

## Join debt and health spending tables
debt_and_health_spending <- health_spending %>%
  left_join(debt, by = "Country")


