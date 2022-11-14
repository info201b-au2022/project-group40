# R Source Code: Summary Information Calculations
library(dplyr)
library(tidyverse)
source("../source/R_Source_Summary_Info_Table.R")

summary_info <- list()

renamed <- summary_table %>%
  rename("row" = "#") %>% 
  rename("Age_Group" = "Age Group") %>% 
  rename("Covid_Deaths_by_Age" = "Covid Deaths by Age") %>% 
  rename("Percent_Covid_Deaths_by_Age" = "Percent Covid Deaths by Age") %>% 
  rename("Race_Group" = "Race Group") %>% 
  rename("Covid_Deaths_by_Race" = "Covid Deaths by Race") %>% 
  rename("Percent_Covid_Deaths_by_Race" = "Percent Covid Deaths by Race")

# Find the age group with the most deaths
summary_info$max_age_deaths <- renamed %>% 
  select(Age_Group, Covid_Deaths_by_Age) %>% 
  drop_na() %>% 
  filter(Covid_Deaths_by_Age == max(Covid_Deaths_by_Age)) %>% 
  pull(Age_Group)
  
# Find the age group with the least deaths
summary_info$min_age_deaths <- renamed %>% 
  select(Age_Group, Covid_Deaths_by_Age) %>% 
  drop_na() %>% 
  filter(Covid_Deaths_by_Age == min(Covid_Deaths_by_Age)) %>% 
  pull(Age_Group)

# Find the race with the most deaths 
summary_info$max_race_deaths <- renamed %>% 
  select(Race_Group, Covid_Deaths_by_Race) %>% 
  drop_na() %>% 
  filter(Covid_Deaths_by_Race == max(Covid_Deaths_by_Race)) %>% 
  pull(Race_Group)

# Find the race with the least deaths
summary_info$min_race_deaths <- renamed %>% 
  select(Race_Group, Covid_Deaths_by_Race) %>% 
  drop_na() %>% 
  filter(Covid_Deaths_by_Race == min(Covid_Deaths_by_Race)) %>% 
  pull(Race_Group)

# Find the race with the least deaths within the age group with the least deaths
summary_info$min_age_race_deaths <- renamed %>% 
  select(Age_Group, Race_Group, Covid_Deaths_by_Age) %>% 
  drop_na() %>% 
  filter(Covid_Deaths_by_Age == min(Covid_Deaths_by_Age)) %>% 
  pull(Race_Group)
