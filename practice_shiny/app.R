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
library(lubridate)

penguins <- penguins

# Create the user interface:
# using navbarPage() to setup tabs
ui <- navbarPage("Tick, Tick, Boom: Tick population (Family Acari) distributions in California",
                 # first tab
                 tabPanel("Human Lyme Disease",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Human Lyme Disease Occurence by Year and County",
                                         # add slider input
                                         sliderInput(inputId = "year",
                                                     label = "Select Years",
                                                     min = 2007,
                                                     max = 2009,
                                                     value = c(2007, 2009),
                                                     timeFormat = TRUE),
                                         # add checkbox group
                                         checkboxGroupInput(inputId = "island",
                                                            label = "Select Counties",
                                                            choices = c("Torgersen",
                                                                        "Biscoe",
                                                                        "Dream"),
                                                            selected = "Torgersen")),
                            # create main panel for output
                            mainPanel("Graph/Map 1 Here")
                          )),
                 # second tab
                 tabPanel("Life Stage Map",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Tick Lifestage Map",
                                         radioButtons(inputId = "species",
                                                      label = "Select Life Stage",
                                                      choices = c("Chinstrap",
                                                                  "Gentoo",
                                                                  "Adelie"),
                                                      selected = "Chinstrap"),
                                         checkboxGroupInput(inputId = "island",
                                                            label = "Select Counties",
                                                            choices = c("Torgersen",
                                                                        "Biscoe",
                                                                        "Dream"),
                                                            selected = "Torgersen")),
                            # create main panel for output
                            mainPanel("Graph/Map 2 Here")
                          )),
                 # third tab
                 tabPanel("Tejon Ticks",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Widget 3 Here"),
                            # create main panel for output
                            mainPanel("Graph/Map 3 Here")
                          ))
)

# Create the server function:
server <- function(input, output) {}

# Combine them into an app:
shinyApp(ui = ui, server = server)


