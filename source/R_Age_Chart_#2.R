# R Source Second Chart

# Install Packages
install.packages("ggplot2")
library("tidyverse")
library("RcppRoll")
library("ggplot2")
library("dplyr")

# Gets age data 
age_data <- read.csv("age.csv")

# Filters age data by Age Group and Covid Deaths
filtered <- age_data %>%
  select(Age.Group, COVID.19.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(COVID.19.Deaths = sum(COVID.19.Deaths, na.rm = TRUE))

# Filters Age Groups to remove overlap between age ranges
new <- filtered[-c(1,4,6,8,11,16),]

# Creates a bar chart based off the filtered data chart
ggplot(data = new) + 
  geom_col(mapping = aes(
    # Orders the X-axis labels in ascending order
    x = factor(Age.Group, 
               level = c("Under 1 year", "1-4 years", "5-14 years", "15-24 years", "25-34 years", "35-44 years",
                         "45-54 years", "55-64 years", "65-74 years", "75-84 years", "85 years and over")),
    y = COVID.19.Deaths)) +
  # Changes the Y-axis labels
  scale_y_continuous(
    breaks = c(0, 500000, 1000000, 1500000, 2000000, 2500000, 3000000, 3500000),
    labels = c("0","500,000", "1,000,000", "1,500,000", "2,000,000", "2,500,000", "3,000,000", "3,500,000")
  )+
  # Labels the chart data
  labs(
    x = "Age Group",
    y = "Covid-19 Deaths",
    title = "Covid-19 Deaths by Different Age Groups"
  )
