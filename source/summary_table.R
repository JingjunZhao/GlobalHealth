### P2 Summary Table

debt_data <- read.csv("../data/debt_data_portal.csv", stringsAsFactors = FALSE)
health_spending_data <- read.csv("../data/expenditure_as_a_share.csv", stringsAsFactors = FALSE)
per_capital_data <- read.csv("../data/o_per_capital .csv", stringsAsFactors = FALSE)
maternal_mortality_data <- read.csv("../data/API_SH.STA.MMRT_DS2_en_csv_v2_4693917.csv", stringsAsFactors = FALSE)

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

## Editing per capital data
per_capital <- per_capital_data %>%
  filter(Period == 2019) %>%
  rename("per_cap_health_spend" = Value) %>%
  subset(select = -(IndicatorCode)) %>%
  subset(select = -(Indicator)) %>%
  subset(select = -(ValueType)) %>%
  subset(select = -(ParentLocationCode)) %>%
  subset(select = -(ParentLocation)) %>%
  subset(select = -(Location.type)) %>%
  subset(select = -(SpatialDimValueCode)) %>%
  subset(select = -(Period.type)) %>%
  subset(select = -(Period)) %>%
  subset(select = -(IsLatestYear)) %>%
  subset(select = -(Dim1.type)) %>%
  subset(select = -(Dim1)) %>%
  subset(select = -(Dim1ValueCode)) %>%
  subset(select = -(Dim2.type)) %>%
  subset(select = -(Dim2)) %>%
  subset(select = -(Dim2ValueCode)) %>%
  subset(select = -(Dim3)) %>%
  subset(select = -(Dim3ValueCode)) %>%
  subset(select = -(Dim3.type)) %>%
  subset(select = -(DataSourceDimValueCode)) %>%
  subset(select = -(DataSource)) %>%
  subset(select = -(FactValueNumericPrefix)) %>%
  subset(select = -(FactValueNumeric)) %>%
  subset(select = -(FactValueNumericLow)) %>%
  subset(select = -(FactValueNumericHighPrefix)) %>%
  subset(select = -(FactValueUoM)) %>%
  subset(select = -(FactValueNumericLowPrefix)) %>%
  subset(select = -(FactValueNumericHigh)) %>%
  subset(select = -(FactValueTranslationID)) %>%
  subset(select = -(FactComments)) %>%
  subset(select = -(Language)) %>%
  subset(select = -(DateModified))

o_per_capital. <-read.csv("../data/o_per_capital .csv")
o_per_capital. <-o_per_capital. [-1,]
per_capital<-group_by(o_per_capital.,ParentLocation)%>%summarise(Period=Period,Value=Value,ParentLocation=ParentLocation,Location=Location)
names(per_capital)[1]<-paste("continents")
names(per_capital)[2]<-paste("year")
names(per_capital)[3]<-paste("Health_spending_per_capital")
names(per_capital)[4]<-paste("Country")
per_capital_2019<-filter(per_capital,year==2019) %>%
  subset(select = -(continents)) %>%
  subset(select = -(year))

## Join debt and health spending tables
joined_data <- health_spending %>%
  left_join(debt, by = "Country") %>%
  left_join(per_capital_2019, by = "Country")


