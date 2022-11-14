

#per_capital_2019<-filter(per_capital,year==2019,country%in%countries)
#per_capital_2019<-filter(per_capital,year==2019)
#ggplot(data=per_capital_2019, aes(x=factor(country,level=country),y=spending_per_capital)) + 
#  geom_bar(stat="identity", fill="steelblue")
#nrow(per_capital_2019)


read.csv("../data/o_per_capital .csv")
o_per_capital <-o_per_capital [-1,]
per_capital<-group_by(o_per_capital,V5)%>%summarise(V10=V10,V24=V24,V5=V5,V8=V8)
names(per_capital)[1]<-paste("continents")
names(per_capital)[2]<-paste("year")
names(per_capital)[3]<-paste("Health_spending_per_capital")
names(per_capital)[4]<-paste("region")

world_map <- map_data("world")
map_2019<-left_join(per_capital_2019, world_map, by = "region")
head(map_2019)
map_2019$Health_spending_per_capital<-as.numeric(map_2019$Health_spending_per_capital)
ggplot(map_2019, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Health_spending_per_capital))+ 
  scale_fill_gradient(low = "yellow", high = "red", na.value = NA)

read.csv("../data/expenditure_as_a_share.csv")
head(expenditure_as_a_share)
names(expenditure_as_a_share)[4]<-paste("Health_percentage")
Share_2019<-filter(expenditure_as_a_share,Year==2019)
names(Share_2019)[1]<-paste("region")
map_share_2019<-left_join(Share_2019, world_map, by = "region")
map_share_2019$Health_percentage<-as.numeric(map_share_2019$Health_percentage)
ggplot(map_share_2019, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Health_percentage))+ 
  scale_fill_gradient(low = "yellow", high = "red", na.value = NA)
