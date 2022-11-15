## maternal mortality ratio

mmr_data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/data/API_SH.STA.MMRT_DS2_en_csv_v2_4693917.csv")
View(mmr_data)

install.packages("ggplot2")
install.packages("dplyr")
install.packages("hrbrthemes")
install.packages("virdis")
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)


# organizing data
mmr_data <- subset(mmr_data, select = -c(X2000,X2001,X2002,X2003,
                                         X2004,X2005,X2006,X2007,X2008,X2009,
                                         X2010,X2011,X2012,X2013,X2014,X2015,X2016))
mmr_data <- na.omit(mmr_data)

# Plot
as.numeric(mmr_data$X2017)
barplot(mmr_data$X2017)
mmr_plot <- barplot(mmr_data$X2017, names.arg = mmr_data$Country.Name, main = "Maternal Mortality Rate Across Countries in 2017", 
                    xlab="Country Name", ylab = "Maternal Mortality")


plot(mmr_plot)


