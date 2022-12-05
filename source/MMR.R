## maternal mortality ratio

maternal_mortality_data <- read.csv("../data/API_SH.STA.MMRT_DS2_en_csv_v2_4693917.csv")

library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(plotly)

# organizing data
mmr_data <- group_by(maternal_mortality_data,Country.Name)%>%summarise(X2017=X2017,Country.Name=Country.Name)
mmr_data <- na.omit(mmr_data)
mmr_data<-mmr_data[-c(83, 86, 88, 89, 90, 91, 115, 121, 122, 123, 137, 138, 155, 157, 167, 168, 189, 197, 218, 225),]
names(mmr_data)[1]<-paste("Country")
names(mmr_data)[2]<-paste("maternal_mortality")


## ggplot plot

mortality_data <- mmr_data %>%
  group_by(Country,maternal_mortality) %>%
  summarise(n=n(), maternal_mortality = sum(maternal_mortality))

plot_mmr <- function () {
  summary <- ggplot(mortality_data, aes(y = maternal_mortality, x=Country)) + 
    ggtitle("Maternal Morality Rate Across Countries in 2017") +
    geom_bar(position = "dodge", stat="identity", color="gray")
  return(summary)
}

plot_mmr()

plot_mmr <- ggplotly(plot_mmr())
plot_mmr


