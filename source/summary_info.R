## Summary Information

library("dplyr")
library("tidyverse")
source("../source/summary_table.R")
summary_info<-list()
summary_info <- list(num_countries = summary_info$num_countries, 
                     num_in_debt = summary_info$num_in_debt, 
                     greatest_country = summary_info$greatest_country, 
                     greatest_country_net = summary_info$greatest_country_net,
                     most_in_debt = summary_info$most_in_debt,
                     most_in_debt_mmr = summary_info$most_in_debt_mmr)
summary_info$num_countries <- nrow(Summary_data)
summary_info$num_in_debt <- Summary_data %>%
  filter(JDC_risk_2021 == "In debt crisis") %>%
  nrow()
summary_info$greatest_country <- Summary_data %>%
  filter(health_perc_expenditure == max(health_perc_expenditure, na.rm = TRUE)) %>%
  pull(Country)
summary_info$greatest_country_net <- Summary_data %>%
  filter(health_perc_expenditure == max(health_perc_expenditure, na.rm = TRUE)) %>%
  pull(net_creditor_debtor_2020)
summary_info$most_in_debt <- Summary_data %>%
  filter(net_creditor_debtor_2020 == min(net_creditor_debtor_2020)) %>%
  pull(Country)
summary_info$most_in_debt_mmr <-  Summary_data %>%
  filter(net_creditor_debtor_2020 == min(net_creditor_debtor_2020)) %>%
  pull(maternal_mortality)
