library(tidyverse)
library(outliers)
library(nycflights13)
library(babynames)
library(nasaweather)

#Creates the dataframe 'median_windspeed'
median_windspeed<- weather %>%
  #Only these three columns are needed for analysis
  select(wind_speed, wind_dir, origin) %>%
  group_by(origin, wind_dir) %>%
  #outliers of wind_speed are removed using the outlier() function from the outliers package
  filter(wind_speed != c(outlier(wind_speed)), is.na(wind_dir) == FALSE) %>%
  #median wind speed is calculated for each airport and wind direction
  summarise(median_wind_speed = median(wind_speed, na.rm = TRUE))
print(median_windspeed)
#Wind Direction vs Median Wind Speed is plotted for each airport
median_windspeed_plot <- median_windspeed %>%
  ggplot(aes(wind_dir, median_wind_speed)) +
  geom_smooth() + geom_point() +
  facet_wrap(~origin) +
  labs(x= "Wind Direction", y = "Median Wind Speed")
print(median_windspeed_plot)

combined_flights_airlines <- left_join(flights, airlines, by = 'carrier')
distance_from_JFK <- combined_flights_airlines %>%
  filter(origin == 'JFK') %>%
  select(name, distance) %>%
  group_by(name) %>%
  summarise(median_distance = median(distance)) %>%
  arrange(desc(median_distance))

leaving_newark <- combined_flights_airlines %>%
  select(origin, name, month) %>%
  filter(origin == "EWR") %>%
  group_by(name, month) %>%
  summarise(number_left = length(name))%>%
  spread(key = month, value = number_left)

most_common_male <- babynames %>%
  filter(year == "2014", sex == "M") %>%
  arrange(desc(n)) %>%
  head(n=10)

most_common_female <- babynames %>%
  filter(year == "2014", sex == "F") %>%
  arrange(desc(n)) %>%
  head(n=10)
common_names_2014 <- full_join(most_common_male, most_common_female)
common_frequency <- semi_join(babynames, common_names_2014, by = c('name', 'sex'))
prop_combined <- common_frequency %>%
  group_by(year, sex) %>%
  summarise('prop' = sum(prop))
prop_plot_combined <- prop_combined %>%
  ggplot(aes(year, prop, color = sex)) + geom_point() + facet_wrap(~sex)

common_girl_26to29 <- babynames %>%
  filter(year ==  1896 | year == 1946 | year == 2014, sex == 'F') %>%
  group_by(year) %>%
  arrange(desc(n)) %>%
  slice(26:29) %>%
  select(year, name)

testweather<- nasaweather::storms %>%
  filter(type == "Hurricane" & year == '1995') %>%
  unite(date_and_time, day, hour, sep = ".") %>%
  select(name, date_and_time, pressure)

weatherplot <- testweather %>%
  ggplot( aes(date_and_time, pressure)) +
  geom_point() + facet_wrap(~name)

roothairdata <- read_csv("../data/2017_4_6_complete_dataset.csv", col_names = TRUE) %>%
  unite(rh_ID, ID, root_hair, sep = "_")

nucmeans<- roothairdata %>%
  filter(oryzalin_treated == 'no') %>%
  group_by(rh_ID) %>%
  summarise(mean_nuc_distance = mean(nuc_to_tip_length)) #%>%

newhairdata<-left_join(roothairdata, nucmeans, by = 'rh_ID') %>%
  group_by(genotype) %>%
  mutate(overall_mean_distance = mean(mean_nuc_distance)) %>%
  mutate(overall_distance_sd = sd(mean_nuc_distance)) %>%
  group_by(rh_ID, oryzalin_treated) %>%
  mutate(distance_from_mean = nuc_to_tip_length - mean_nuc_distance) %>%
  group_by(genotype, oryzalin_treated, time) %>%
  mutate(average_mean_difference = mean(distance_from_mean))

pretreatment <- newhairdata %>%
  filter(oryzalin_treated =="no")
posttreatment <- newhairdata %>%
  filter(oryzalin_treated =="yes")
treatmentplot <-
  ggplot() +
  geom_smooth(data = pretreatment, aes(x = time, y = distance_from_mean, group = rh_ID, color = genotype)) +
  geom_smooth(data = posttreatment, aes(x = time, y = distance_from_mean, group = rh_ID, color = genotype)) +
  facet_wrap(~oryzalin_treated)
print(treatmentplot)

