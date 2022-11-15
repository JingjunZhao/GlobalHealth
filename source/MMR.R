## maternal mortality ratio

maternal_mortality_data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/data/API_SH.STA.MMRT_DS2_en_csv_v2_4693917.csv")


install.packages("ggplot2")
install.packages("dplyr")
install.packages("hrbrthemes")
install.packages("virdis")
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)


# organizing data
mmr_data<-group_by(maternal_mortality_data,Country.Name)%>%summarise(X2017=X2017,Country.Name=Country.Name)
names(mmr_data)[1]<-paste("Country")
names(mmr_data)[2]<-paste("maternal_mortality")

# Plot
mmr_plot <- barplot(mmr_data$maternal_mortality, names.arg = mmr_data$Country,main = "Maternal Mortality Rate Across Countries in 2017", 
                    xlab="Country", ylab = "maternal_mortality")
plot(mmr_plot)


