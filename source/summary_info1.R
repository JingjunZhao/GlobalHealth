## Summary Information redo

library("dplyr")
library("tidyverse")
source("../source/summary_table.R")
summary_info <- list()
summary_info <- list(num_countries = num_countries, 
                     num_in_debt = num_in_debt, 
                     greatest_country = greatest_country, 
                     greatest_country_net = greatest_country_net,
                     most_in_debt = most_in_debt,
                     most_in_debt_mmr = most_in_debt_mmr)
num_countries <- nrow(Summary_data)
num_in_debt <- Summary_data %>%
  filter(JDC_risk_2021 == "In debt crisis") %>%
  nrow()
greatest_country <- Summary_data %>%
  filter(health_perc_expenditure == 24.21) %>%
  pull(Country)
greatest_country_net <- Summary_data %>%
  filter(health_perc_expenditure == 24.21) %>%
  pull(net_creditor_debtor_2020)
most_in_debt <- Summary_data %>%
  filter(net_creditor_debtor_2020 == -421) %>%
  pull(Country)
most_in_debt_mmr <-  Summary_data %>%
  filter(net_creditor_debtor_2020 == -421) %>%
  pull(maternal_mortality)

