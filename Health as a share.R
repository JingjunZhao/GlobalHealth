head(Health.spending.as.a.share.of.total.government.expenditure)
names(Health.spending.as.a.share.of.total.government.expenditure)[4]<-paste("Health_percentage")
Share_2019<-filter(Health.spending.as.a.share.of.total.government.expenditure,Year==2019)
names(Share_2019)[1]<-paste("region")
map_share_2019<-left_join(Share_2019, world_map, by = "region")
map_share_2019$Health_percentage<-as.numeric(map_share_2019$Health_percentage)
ggplot(map_share_2019, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Health_percentage))+ 
  scale_fill_gradient(low = "yellow", high = "red", na.value = NA)