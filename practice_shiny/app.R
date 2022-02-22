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
library(bslib)
library(plotly)
#install.packages("ggthemes")
library(ggthemes)

#penguins <- penguins

long <- read_csv("long.csv")
tick_graph <-
  ggplot(data = long, aes(x = year, y = incidence, group = County)) +
  geom_line(aes(color = County)) +
  labs(x = "Year", y = "Lyme Disease Incidence", title = "Human Lyme Disease Incidence 2011-2020")
theme_minimal()


# Create the user interface:
# using navbarPage() to setup tabs
ui <- navbarPage(theme = bs_theme(bootswatch = "flatly"),
                 # title
                 "Tick, Tick, Boom: Tick population (Family Acari) distributions in California",
                 # first tab
                 tabPanel("Human Lyme Disease",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Human Lyme Disease Occurence by Year and County",
                                         # add slider input
                                         # add checkbox group
                                         checkboxGroupInput(inputId = "County",
                                                            label = "Select County",
                                                            choices = c("Sierra" ,"Sacramento","Santa Barbara" , "Calaveras" ,"Ventura", "Los Angeles","Sonoma", "San Francisco","Marin" ,"Mariposa","Lassen","Napa","Kings","San Diego","Placer", "San Francisco", "Marin","Mariposa",  "Lassen", "Napa", "Shasta","Monterey", "Trinity","Mendocino","Inyo","Mono","Tuolumne","Solano", "San Bernardino", "Contra Costa" ,"Alpine","El Dorado","Yolo", "Yuba", "San Benito", "Humboldt", "Riverside","Kern","Colusa" ,"Del Norte" ,"Modoc", "Fresno", "Madera", "Santa Clara", "Tehama" ,"San Joaquin" ,"Alameda","Nevada","Butte", "Merced", "Tulare" , "Stanislaus","Orange","Imperial","Sutter", "Amador", "Lake" ,"Plumas" ,"San Mateo", "Siskiyou", "Santa Cruz", "Glenn", "San Luis Obispo"
                                                            ))),
                            # create main panel for output
                            mainPanel("Graph/Map 1 Here",
                                      plotlyOutput(outputId = "lyme_plot"))
                          )),
                 # second tab
                 tabPanel("Life Stage Map",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Tick Lifestage Map",
                                         # add radio button group
                                         radioButtons(inputId = "species",
                                                      label = "Select Life Stage",
                                                      choices = c("Chinstrap",
                                                                  "Gentoo",
                                                                  "Adelie"),
                                                      selected = "Chinstrap"),
                                         # add checkbox group
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
                 tabPanel("Tejon Ticks: Climate and Host Change",
                          sidebarLayout(
                            # create sidebar panel that will house widgets
                            sidebarPanel("Time of Year and Exclosure Effects",
                                         # add checkbox group
                                         checkboxGroupInput(inputId = "month",
                                                            label = "Select Month",
                                                            choices = c("January",
                                                                        "February",
                                                                        "March",
                                                                        "April",
                                                                        "May",
                                                                        "June",
                                                                        "July",
                                                                        "August",
                                                                        "September",
                                                                        "October",
                                                                        "November",
                                                                        "December"),
                                                            selected = NULL),
                                         # add checkbox group #2
                                         checkboxGroupInput(inputId = "plot",
                                                            label = "Select Exclusion Treatment",
                                                            choices = c("Total", "Partial", "Control"),
                                                            selected = NULL)
),
                            # create main panel for output
                            mainPanel("Graph/Map 3 Here")
                                      #plotOutput(outputId = tejon_tick))
                          ))
)

# Create the server function:
server <- function(input, output) {
  ##Pt.1 Lyme incidence
  lyme_incidence <- reactive({
    long %>%
      #dplyr::group_by(County)
      dplyr::filter(County %in% input$County)
  })

  output$lyme_plot <- renderPlotly({
    ggplot(data = long, aes(x = year, y = incidence, group = County)) +
      geom_line(aes(color = County)) +
      labs(x = "Year", y = "Lyme Disease Incidence", title = "Human Lyme Disease Incidence 2011-2020") +
    theme_minimal()


#Pt 3: Tick Seasonality - I'm not getting this to display and I don't know why
 tejon_tick_app_2 <- reactive({
   tejon_tick_app_2 %>%
     filter(month == input$month) %>%
     filter(plot == input$plot)
  }) #end tejon reactive

 output$tejon_tick <- renderPlot({
    ggplot(data = tejon_tick_app_2(), aes(x = month, y = n))+
      geom_bar(stat = "identity")+
     theme_bw()
  })

}

# Combine them into an app:
shinyApp(ui = ui, server = server)


