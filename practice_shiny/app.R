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
library(palmerpenguins)

penguins <- penguins

# Create the user interface:
ui <- navbarPage("Tick, Tick, Boom: Tick population (Family Acari) distributions in California",
                 tabPanel("Human Lyme Disease",
                          sidebarLayout(
                            sidebarPanel("Widget 1 Here",
                                         sliderInput(inputId = "year",
                                                     label = "Select Years",
                                                     min = 2007,
                                                     max = 2009,
                                                     value = c(2007, 2009))),
                            mainPanel("Graph/Map 1 Here")
                          )),
                 tabPanel("Life Stage Map",
                          sidebarLayout(
                            sidebarPanel("Widget 2A Here"),
                            mainPanel("Graph/Map 2 Here")
                          )),
                 tabPanel("Tejon Ticks",
                          sidebarLayout(
                            sidebarPanel("Widget 3 Here"),
                            mainPanel("Graph/Map 3 Here")
                          ))
)

# Create the server function:
server <- function(input, output) {}

# Combine them into an app:
shinyApp(ui = ui, server = server)


