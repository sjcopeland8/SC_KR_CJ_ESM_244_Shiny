#
# Practice shiny layout: CJ 2_21_2022
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# attach necessary packages
library(shiny)
library(tidyverse)

# Create the user interface:
ui <- navbarPage("Tick, Tick, Boom: Tick population (Family Acari) distributions in California",
                 tabPanel("Tick Thing 1",
                          sidebarLayout(
                            sidebarPanel("Widget 1 Here"),
                            mainPanel("Graph/Map 1 Here")
                          )),
                 tabPanel("Tick Thing 2",
                          sidebarLayout(
                            sidebarPanel("Widget 2 Here"),
                            mainPanel("Graph/Map 2 Here")
                          )),
                 tabPanel("Tick Thing 3",
                          sidebarLayout(
                            sidebarPanel("Widget 3 Here"),
                            mainPanel("Graph/Map 3 Here")
                          )),
                 tabPanel("Tick Thing 4",
                          sidebarLayout(
                            sidebarPanel("Widget 4 Here"),
                            mainPanel("Graph/Map 4 Here")
                          ))
)

# Create the server function:
server <- function(input, output) {}

# Combine them into an app:
shinyApp(ui = ui, server = server)


