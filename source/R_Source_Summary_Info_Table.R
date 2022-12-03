# R Source File Summary Information Table

# Install Packages
library("RcppRoll")
library("dplyr")

# All Datasets
race_data <- read.csv("../data/race.csv")
age_data <- read.csv("../data/age.csv")
race_and_age <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group40/main/data/race_and_age.csv")

#
# Grouping for Race Data
#
# Filter Race_Data dataframe for percentages
race_filtered <- race_data %>% 
  filter(Indicator == "Distribution of COVID-19 deaths (%)") %>%
  select(Data.as.of, Indicator, Non.Hispanic.White, Non.Hispanic.Black, Non.Hispanic.American.Indian.or.Alaska.Native, Non.Hispanic.Asian, Non.Hispanic.Native.Hawaiian.or.Other.Pacific.Islander, Hispanic) %>%
  summarise_at(vars(Non.Hispanic.White:Hispanic), mean, na.rm = TRUE)
# Rename Columns
new_race_filtered <- race_filtered %>%
  rename("Non-Hispanic White" = "Non.Hispanic.White") %>%
  rename("Non-Hispanic Black" = "Non.Hispanic.Black") %>%
  rename("Non-Hispanic American Indian or Alaska Native" = "Non.Hispanic.American.Indian.or.Alaska.Native") %>%
  rename("Non-Hispanic Asian" = "Non.Hispanic.Asian") %>%
  rename("Non-Hispanic Native Hawaiian or Other Pacific Islander" = "Non.Hispanic.Native.Hawaiian.or.Other.Pacific.Islander")
# Reorganize the Dataframe
race_percentages <- gather(
  new_race_filtered,
  key = Race.and.Hispanic.Origin.Group,
  value = Percent_of_Covid_Deaths_by_Race
)

#
# Grouping for Age Data
#
# Filter the Age_Data dataframe for percentages
age_filtered <- age_data %>%
  filter(State == "United States", Sex == "All Sexes", Group == "By Total") %>%
  select(Age.Group, COVID.19.Deaths, Total.Deaths) %>%
  mutate(Percent_Covid_Deaths_by_Age = (COVID.19.Deaths / Total.Deaths))
# Filter out overlapping age groups
age_percentages <- age_filtered[-c(1, 2, 4, 5, 6, 8, 10, 12, 14), ]

#
# Filtered Race and Age Data
#
# Filter the Race_and_Age dataframe by Age Group
filter1 <- race_and_age %>%
  filter(HHS.Region == "United States") %>%
  group_by(Age.Group) %>%
  summarize(sum(COVID.19.Deaths, na.rm = TRUE))
# Combine both Age related dataframes
df1 <- left_join(age_percentages, filter1)
# Rename Columns
df1 <- df1 %>%
  rename("Covid Deaths by Age" = "sum(COVID.19.Deaths, na.rm = TRUE)") %>%
  rename("Percent Covid Deaths by Age" = "Percent_Covid_Deaths_by_Age") %>%
  rename("Age Group" = "Age.Group") %>%
  select("Age Group", "Covid Deaths by Age", "Percent Covid Deaths by Age")

# Filter the Race_and_Age dataframe by Race Group
filter2 <- race_and_age %>%
  filter(HHS.Region == "United States") %>%
  group_by(Race.and.Hispanic.Origin.Group) %>%
  summarize(sum(COVID.19.Deaths, na.rm = TRUE))
# Combine both Race related dataframes
df2 <- left_join(race_percentages, filter2)
# Rename Columns
df2 <- df2 %>%
  rename("Race Group" = "Race.and.Hispanic.Origin.Group") %>%
  rename("Percent Covid Deaths by Race" = "Percent_of_Covid_Deaths_by_Race") %>%
  rename("Covid Deaths by Race" = "sum(COVID.19.Deaths, na.rm = TRUE)")

# Add column to join by
df1 <- df1 %>%
  mutate(row_number = (1:8)) %>%
  rename("#" = "row_number") %>%
  select("#", "Age Group", "Covid Deaths by Age", "Percent Covid Deaths by Age")
df2 <- df2 %>%
  mutate(row_number = (1:6)) %>%
  rename("#" = "row_number") %>%
  select("#", "Race Group", "Covid Deaths by Race", "Percent Covid Deaths by Race")

# Join dataframes
summary_table <- left_join(df1, df2)
View(summary_table)
