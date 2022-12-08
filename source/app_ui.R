# ui

library(shiny)
library(shinythemes)
library(markdown)

# Source files
source("R_Race_and_Age_Chart_#3.R")
source("R_Age_Chart_#2.R")
source("R_Race_Pie_Chart_#1.R")
source("R_Source_Summary_Info.R")
source("R_Source_Summary_Info_Table.R")

Intro_Page <- tabPanel(
  "Introduction",
  h1("Introduction"),
  textOutput("intro_text_1"),
  textOutput("intro_text_2"),
  h3("Research Questions"),
  tags$ul(
    tags$li("How has the Covid-19 pandemic affected individuals belonging to a specific age group?"),
    tags$li("How has the Covid-19 pandemic affected individuals belonging to a specific race?"),
    tags$li("Is there a correlation between race and age in concern to the Covid-19 pandemic, specifically in individuals who have been disproportionately affected by the virus?")),
  img(src = "WFMY Age and Race Among COVID-19 800w.png", height = "50%", width = "50%")
)

chart_1 <- tabPanel(
  "Chart 1: Pie Chart",
  h1("Race, Age, and COVID-19 Deaths Pie Chart By Race"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "Race_Pie_Chart",
        label = "Select Race",
        choices = c(
          "White (Non-Hispanic)" = "White",
          "Native Hawaiian or Other Pacific Islander (Non-Hispanic)" = "Hawaiian_Pacific_Islander",
          "Black (Non-Hispanic)" = "Black",
          "Asian (Non-Hispanic)" = "Asian",
          "American Indian or Alaska Native (Non-Hispanic)" = "Non_Hispanic_Indian_Native"
        ),
        
        selected = "White",
        multiple = TRUE),
      p("This Pie Chart shows how differnt cases has been affected by COVID-19. As can be analyzed, the white race has been most affected by COVID-19. To compare how each race has been affected, selected from the drop down menu below. To see statistics, place mouse cursor over pie slices.")
    ),
    mainPanel(
      plotlyOutput(outputId = "PIE_CHART"),
    )
  )
)

chart_2 <- tabPanel(
  "Chart 2: Age", id = "age", 
  h1("Age and COVID-19 Deaths Bar Chart"),
  sidebarLayout(
    sidebarPanel(
      age_x_input,
      age_y_input,
      p("This bar chart shows how different age groups have been affected by the Covid-19 virus during the years of 2020 to 2022. 
      By including a Y-Variable that changes between different death counts, including the total death count in the United States 
      and the death counts by influenza and pnuemonia in those same years, one can make direct comparisons between the impacts of 
      Covid versus other deadly viruses. As shown in the chart, across all viruses there is an increase in death totals as the age group
      increases. The chart also shows that while influenza death totals are significantly lower than that of Covid-19, the range of 
      pneumonia death totals are similar to the Covid-19 death totals. However, across all charts individuals of older ages are
      shown to be disproportionally affected by the virus.")
      ),
    mainPanel(
      plotlyOutput("age"),
    )
  )
)

chart_3 <- tabPanel(
  "Chart 3: Race & Age", id = "race_and_age",
  h1("Race, Age, and COVID-19 Deaths Stacked Bar Chart"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "race_age",
        label = "Racial/Ethnic Group",
        choices = list(
        "Unknown" = "Unknown",
        "White (Non-Hispanic)" = "Non-Hispanic White",
        "Native Hawaiian or Other Pacific Islander (Non-Hispanic)" = "Non-Hispanic Native Hawaiian or Other Pacific Islander",
        "Black (Non-Hispanic)" = "Non-Hispanic Black",
        "Asian (Non-Hispanic)" = "Non-Hispanic Asian",
        "American Indian or Alaska Native (Non-Hispanic)" = "Non-Hispanic American Indian or Alaska Native",
        "Hispanic" = "Hispanic"
        ),
        selected = "Unknown"
      ),
    p("Click on different races/origin groups to analyze the discrepancies between COVID-19 deaths across age groups."),
    p("From this chart, it is evident that COVID-19 deaths increase as age 
       increases with all age groups. However, an interesting observation is 
       that there is a larger proportion of Black citizens in the age group of 50-74 years who died as a result of COVID-19 than for older age groups, a trend similar for Hispanic citizens."),
    p("This is an interesting observation to note and may point to racial inequities within the American healthcare system, or other societal factors that may lead to these disparities.")
  ),
  mainPanel(plotlyOutput("race_age_chart"))
  )
)

summary <- tabPanel(
  "Summary", id = "summary",
  h1("Summary"),
  textOutput("summary_text_header"),
  tags$ol(
   tags$li("The older a person is, the more likely they are to die from COVID-19, specifically between the groups 74-85 years old and 85 years or older"),
   tags$li("The racial group \"Non-Hispanic White\" was most affected by COVID-19, likely because they make up a portion of the population"),
   tags$li("\"Hispanic\" and \"Non-Hispanic Black\" individuals tended to die from COVID-19 in larger proportions at slightly younger ages, e.g. from 50-64 years"),
   img(src = "race_age.png", height = "33%", width = "33%"),
   img(src = "race.png", height = "33%", width = "33%"),
   img(src = "age.png", height = "33%", width = "33%")
  )
)

# Define UI
ui <- navbarPage(
  theme = shinytheme("sandstone"),
  includeCSS("../source/www/styles.css"),
  title = "Race, Age, and COVID-19 Deaths",
  windowTitle = "Race, Age, and COVID-19 Deaths",
  Intro_Page,
  chart_1,
  chart_2,
  chart_3,
  summary,
  tabPanel("Report", includeMarkdown("../docs/p01-proposal.md")
  )
)
