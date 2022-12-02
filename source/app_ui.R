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
           img(src = "../source/www/WFMY Age and Race Among COVID-19 800w.png", align = "center")
           ),
  tabPanel("Chart 1: Race"), 
  tabPanel("Chart 2: Age"), 
  tabPanel("Chart 3: Race & Age",
           plotlyOutput("race_age_chart")),
  tabPanel("Summary",
           h1("Summary"),
           textOutput("summary_text_header"),
           tags$ol(
             tags$li("The older a person is, the more likely they are to die from COVID-19, specifically between the groups 74-85 years old and 85 years or older"),
             tags$li("The racial group \"Non-Hispanic White\" was most affected by COVID-19, likely because they make up a portion of the population"),
             tags$li("\"Hispanic\" and \"Non-Hispanic Black\" individuals tended to die from COVID-19 in larger proportions at slightly younger ages, e.g. from 50-64 years")
           )
           ),
  tabPanel("Report",
           includeMarkdown("../docs/p01-proposal.md")
           )
)
)

