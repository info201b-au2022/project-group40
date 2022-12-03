# R Source Third Chart

# Install packages
library("tidyverse")
library("RcppRoll")
library("ggplot2")
library("dplyr")
library("plotly")
library(ggiraph)

# Gets race and age data related to COVID-19
both_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group40/main/data/race_and_age.csv")

# Removes the month column from the dataset, which only has unknown values
both_data <- subset(both_data, select = -c(Month))

# Creates a stacked bar chart comparing race groups and age groups to COVID-19 Deaths
bar_chart <- ggplot(both_data, aes(
  fill = Race.and.Hispanic.Origin.Group,
  y = COVID.19.Deaths,
  # Establishes an order for the race groups
  x = factor(Age.Group,
    level = c(
      "0-4 years", "5-17 years", "18-29 years", "30-39 years", "40-49 years",
      "50-64 years", "65-74 years", "75-84 years", "85 years and over"
    )
  )
)) +
  geom_bar_interactive(position = "stack", stat = "identity") +
  # Ensures the labels do not conflict with each other
  scale_x_discrete(guide = guide_axis(n.dodge = 5)) +
  # Creates labels for the data
  labs(
    x = "Age Group",
    y = "COVID-19 Deaths",
    fill = "Racial Background",
    title = "COVID-19 Deaths Across Various Racial/Age Groupings"
  )

# Makes an interactive barchart where users can click on different racial groups and analyze
#   COVID-19 death discrepancies within them
interactive_barchart <- function(df, yvar) {
  p <- plot_ly(
    data = df,
  x = ~Age.Group,
  y = ~COVID.19.Deaths,
  fill = ~yvar,
  type = "bar"
) %>% 
  layout(#barmode = "stack",
         x = "Age Group",
         y = "COVID-19 Deaths",
         title = "COVID-19 Deaths Across Various Racial/Age Groupings"
  )
  return(p)
}