
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



# Define UI
ui <- fluidPage(
  navbarPage(
    theme = shinytheme("sandstone"),
    includeCSS("../source/www/styles.css"),
    title = "Race, Age, and COVID-19 Deaths",
    windowTitle = "Race, Age, and COVID-19 Deaths",
    position = "static-top",
    fluid = TRUE,
    tabPanel("Introduction",
             h1("Introduction"),
             textOutput("intro_text_1"),
             textOutput("intro_text_2"),
             h3("Research Questions"),
             tags$ul(
               tags$li("How has the Covid-19 pandemic affected individuals belonging to a specific age group?"),
               tags$li("How has the Covid-19 pandemic affected individuals belonging to a specific race?"),
               tags$li("Is there a correlation between race and age in concern to the Covid-19 pandemic, specifically in individuals who have been disproportionately affected by the virus?")),
             img(src = "WFMY Age and Race Among COVID-19 800w.png", height = "50%", width = "50%")
    ),
    tabPanel("Chart 1: Race",
             h1("Race and COVID-19 Deaths Pie Chart"),
             sidebarLayout(
               sidebarPanel(
                 
               ),
               
               mainPanel(
                 plotlyOutput(outputId = "PIE_CHART")
               )
             )
             
    ),
    tabPanel("Chart 2: Age",
             h1("Age and COVID-19 Deaths Bar Chart")),
    tabPanel("Chart 3: Race & Age", id="race_and_age",
             h1("Race, Age, and COVID-19 Deaths Stacked Bar Chart"),
             sidebarLayout(
               sidebarPanel(
                 # selectInput(
                 #   label= "Racial/Ethnic Group",
                 #   choices = list(
                 #     "Unknown" = "Unknown",
                 #     "White (Non-Hispanic)" = "Non-Hispanic White",
                 #     "Native Hawaiian or Other Pacific Islander (Non-Hispanic)" = "Non-Hispanic Native Hawaiian or Other Pacific Islander",
                 #     "Black (Non-Hispanic)" = "Non-Hispanic Black",
                 #     "Asian (Non-Hispanic)" = "Non-Hispanic Asian",
                 #     "American Indian or Alaska Native (Non-Hispanic)" = "Non-Hispanic American Indian or Alaska Native",
                 #     "Hispanic" = "Hispanic"
                 #   ),
                 #   selected = "Unknown"
                 # ),
                 p("Click on different races/origin groups to analyze the discrepancies between COVID-19 deaths across age groups."),
                 p("From this chart, it is evident that COVID-19 deaths increase as age increases with all age groups. However, an interesting observation is that there is a larger proportion of Black citizens in the age group of 50-74 years who died as a result of COVID-19 than for older age groups, a trend similar for Hispanic citizens."),
                 p("This is an interesting observation to note and may point to racial inequities within the American healthcare system, or other societal factors that may lead to these disparities.")
                 
               ),
               mainPanel(plotlyOutput("race_age_chart"))),
             tabPanel("Summary",
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
             ), 
             tabPanel("Report",
                      includeMarkdown("../docs/p01-proposal.md"),
                      
             )
    )
  )
)