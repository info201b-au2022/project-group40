# R Source First Chart

covid_race <- read.csv("../data/race.csv", stringsAsFactors = FALSE)
library(ggplot2)


Race <- read.csv("../data/race.csv", stringsAsFactors = FALSE)
race_data <- Race %>%
  rename(Covid_Deaths = COVID.19.Deaths) %>%
  rename(Black = Non.Hispanic.Black) %>%
  rename(Non_Hispanic_Indian_Native = Non.Hispanic.American.Indian.or.Alaska.Native) %>%
  rename(Asian = Non.Hispanic.Asian) %>%
  rename(Hawaiian_Pacific_Islander = Non.Hispanic.Native.Hawaiian.or.Other.Pacific.Islander) %>%
  rename(White = Non.Hispanic.White) %>%
  drop_na()


Race_Filter <- race_data %>%
  select(Covid_Deaths, Black, Non_Hispanic_Indian_Native, Asian, Hawaiian_Pacific_Islander, White) %>%
  group_by(Covid_Deaths) %>%
  summarise(
    Covid_Deaths = (Covid_Deaths),
    Black = sum(Black),
    Non_Hispanic_Indian_Native = sum(Non_Hispanic_Indian_Native),
    Asian = sum(Asian),
    Hawaiian_Pacific_Islander = sum(Hawaiian_Pacific_Islander),
    White = sum(White), .groups = "drop"
  )


PIE <- Race_Filter %>%
  select(Covid_Deaths, Black, Non_Hispanic_Indian_Native, Asian, Hawaiian_Pacific_Islander, White) %>%
  gather(key = Race, value = Covid_Deaths) %>% 
  filter(Race%in% input$Race_Pie_Chart) %>% 
  group_by(Race, Covid_Deaths)


Pie_Chart_Covid_Deaths <- plot_ly(PIE, labels = ~Race, values = ~Covid_Deaths, type = "pie")
Pie_Chart_Covid_Deaths <- Pie_Chart_Covid_Deaths %>%
  layout(
    title = "Covid Deaths For Each Race",
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
