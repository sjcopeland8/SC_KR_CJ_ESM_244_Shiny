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

#penguins <- penguins

## Tejon Data and Organization
tejon_tick_2 <- read_csv("Tejon_MixedModels_Dataset.csv")

Full_no0 <- tejon_tick_2[which(tejon_tick_2$log_total != 0),]

#tejon_tick_app_2 <- Full_no0 %>%
  #select(year, month, site, plot, total, deoc, ipac, deva, other) %>%
  #group_by(across(all_of(group_cols))) %>%
  #summarize(n = n())

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
                            mainPanel("Graph/Map 3 Here",
                                      plotOutput(outputId = tejon_tick))
                          ))
)

# Create the server function:
server <- function(input, output) {

  ## Pt 3: Tick Seasonality - I'm not getting this to display and I don't know why
  tejon_tick_app_3 <- reactive({
    Full_no0 %>%
      select(year, month, site, plot, total, deoc, ipac, deva, other) %>%
      group_by(across(all_of(group_cols))) %>%
      summarize(n = n()) %>%
      filter(month == input$month)# end tejon reactive
  })

  #tejon_tick_app_2 <- reactive({
    #tejon_tick_app_2 %>%
      #filter(month == input$month) #%>%
      #filter(plot == input$plot)

#end tejon reactive

  output$tejon_tick <- renderPlot({
    ggplot(data = tejon_tick_app_3(), aes(x = plot, y = n))+
      geom_bar(stat = "identity")+
      theme_bw()})

}

# Combine them into an app:
shinyApp(ui = ui, server = server)


