# server



library(shiny)



# Source files
source("R_Race_and_Age_Chart_#3.R")
source("R_Age_Chart_#2.R")
source("R_Race_Pie_Chart_#1.R")
source("R_Source_Summary_Info.R")
source("R_Source_Summary_Info_Table.R")

# Gets race and age data related to COVID-19
both_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group40/main/data/race_and_age.csv")

# Removes the month column from the dataset, which only has unknown values
both_data <- subset(both_data, select = -c(Month))

# Define server
server <- function(input, output) {
  
  output$intro_text_1 <- renderText({
    "Covid-19 was declared a global pandemic on March 11th of 2020. At that point, there were already around 110,000 confirmed cases in 110 countries. Research showed that China had the first confirmed case. After that, there were confirmed cases in Iran, Italy, and South Korea. Shortly after, there was a major outbreak in cases all around the world. Covid-19 has affected everyone on earth. Whether it be directly or indirectly. Research shows that as of October, 10,2020, more than 7.7 million people across all the states of the US have tested positive for the virus. With that, the New York Times’s database showed that at least 213,876 people have passed away due to the virus in the United states. Covid-19 has been taking lives on a large scale and it makes us wonder, do different social identities play a role?"
  })
  
  output$intro_text_2 <- renderText({
    "Our sources include data presenting COVID-19 deaths across various races and ages. The datasets record daily observances, spanning from 2020 to yesterday, across as many as 10 age groups, eight racial groups, and their corresponding COVID-19 deaths. In this project, we use this data set to examine the relationship between race, age, and deaths using a sample from the United States."
  })
  
  output$race_age_chart <- renderPlotly({
    race_age_df <- both_data %>%
      filter(Race.and.Hispanic.Origin.Group == input$race_age)
    return(interactive_barchart(race_age_df, input$race_age))
  })
  
  output$age <- renderPlotly({
    chart <- ggplot(final_df) + 
      geom_col(mapping = aes_string(
        x = input$x_var,
        y = input$y_var),
        fill = "black") +
      scale_x_discrete(guide = guide_axis(n.dodge = 3)) +
      labs(
        x = "Age Groups",
        y = input$y_var,
        title = "Deaths by Covid-19 and Other Viruses by Different Age Groups (2020-2022)"
      )
    return(chart)
  })
  
  output$PIE_CHART <- renderPlotly({
    return(Pie_Chart_Covid_Deaths)
  })
  
  
  
  output$summary_text_header <- renderText({
    "After examining the data, we found that: "
  })
}
