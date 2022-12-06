# R Source Second Chart

# Install Packages
# install.packages("ggplot2")
library("tidyverse")
library("RcppRoll")
library("ggplot2")
library("dplyr")

# Gets age data
age_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group40/main/data/age.csv")

# Filters age data by Age Group and Covid Deaths
filtered <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, COVID.19.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(COVID.19.Deaths = sum(COVID.19.Deaths, na.rm = TRUE))

# Filters Age Groups to remove overlap between age ranges
new <- filtered[-c(1, 4, 6, 8, 11, 16), ]

# Creates a bar chart based off the filtered data chart
bar <- ggplot(data = new) +
  geom_col(mapping = aes(
    # Orders the X-axis labels in ascending order
    x = factor(Age.Group,
      level = c(
        "Under 1 year", "1-4 years", "5-14 years", "15-24 years", "25-34 years", "35-44 years",
        "45-54 years", "55-64 years", "65-74 years", "75-84 years", "85 years and over"
      )
    ),
    y = COVID.19.Deaths
  )) +
  # Changes the Y-axis labels
  scale_y_continuous(
    breaks = c(0, 50000, 100000, 150000, 200000, 250000, 300000),
    labels = c("0", "50,000", "100,000", "150,000", "200,000", "250,000", "300,000")
  ) +
  # Removes label overlap
  scale_x_discrete(guide = guide_axis(n.dodge = 3)) +
  # Labels the chart data
  labs(
    x = "Age Group",
    y = "Covid-19 Deaths",
    title = "Covid-19 Deaths by Different Age Groups"
  )

# Data for Ui

# Filter age dataframe for various diseases and join to create a dataframe for final report
covid_deaths <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, COVID.19.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(COVID.19.Deaths = sum(COVID.19.Deaths, na.rm = TRUE))
filtered_covid <- covid_deaths[-c(1, 4, 6, 8, 11, 16), ]

pneumonia_deaths <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, Pneumonia.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(Pneumonia.Deaths = sum(Pneumonia.Deaths, na.rm = TRUE))
filtered_pneumonia <- pneumonia_deaths[-c(1, 4, 6, 8, 11, 16), ]

influenza_deaths <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, Influenza.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(Influenza.Deaths = sum(Influenza.Deaths, na.rm = TRUE))
filtered_influenza <- influenza_deaths[-c(1, 4, 6, 8, 11, 16), ]

total_deaths <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, Total.Deaths) %>%
  group_by(Age.Group) %>%
  summarize(Total.Deaths = sum(Total.Deaths, na.rm = TRUE))
filtered_total <- total_deaths[-c(1, 4, 6, 8, 11, 16), ]

combined1 <- left_join(filtered_covid, filtered_influenza)
combined2 <- left_join(filtered_pneumonia, filtered_total)
final_df <- left_join(combined1, combined2)

# Obtain input values from dataframe
input_values <- colnames(final_df)
input_values_x <- input_values[1]
input_values_y <- input_values[2:5]

# Create variable `age_x_input`to store values that will appear on the x-axis
age_x_input <- selectInput(
  inputId = "x_var",
  label = "X Variable",
  choices = input_values_x
)

# Create variable `age_y_input` to store values that will appear on the y-axis
age_y_input <- selectInput(
  inputId = "y_var",
  label = "Y Variables",
  choices = input_values_y
)