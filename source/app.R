# app

library(shiny)

# Access files defining app ui and server
source("app_ui.R")
source("app_server.R")

# Run the application 
shinyApp(ui = ui, server = server)
