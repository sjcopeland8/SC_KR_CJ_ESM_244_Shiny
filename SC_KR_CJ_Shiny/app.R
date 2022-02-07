#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(palmerpenguins)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Tick, Tick, Boom: Tick population (Family Acari) distributions in California"),
    sidebarLayout(
        sidebarPanel("Studies incorporated by Year",
                     fluidPage(
                             column(4,
                                    sliderInput("slider2", label = h3("Slider Range"), min = 1980,
                                                max = 2022, value = c(1990, 2010))
                             )
                         ),

                         hr(),

                         fluidRow(
                             column(4, verbatimTextOutput("value")),
                             column(4, verbatimTextOutput("range"))
                         )

                     ), # sidebar panel #1 - slider bar graph of studies incorporated by year
       sidebarPanel = "Seasonality of Tick Populations by Ecoregion",
       fluidPage(
           checkboxGroupInput("checkGroup", label = h3("Ecoregion"),
                              choices = list("Central CA Coast" = 1, "Mojave Desert" = 2, "Northern CA Coast" = 3, "Sierra Nevada" = 4, "Sierra Nevada Foothills" = 5, "Great Valley" = 6 ),
                              selected = 1),


           hr(),
           fluidRow(column(6, verbatimTextOutput("value")))

       ), # end check box section #1
       fluidPage(
           checkboxGroupInput("checkGroup", label = h3("Ecoregion"),
                              choices = list("January" = 1, "February" = 2, "March" = 3, "April" = 4, "May" = 5, "June" = 6, "July" = 7, "August" = 8, "September" = 9, "Octobor" = 10, "November" = 11, "December" = 12), selected = 1),
           hr(),
           fluidRow(column(12, verbatimTextOutput("value")))

       ), #end check box section #2
       ), #sidebar panel #2 - Two selection choice boxes of ecoregion and month, attempting to show seasonality of data...I DON'T KNOW HOW TO EVENTUALLY GET THIS TO SYNC UP TO A GRAPH/MAP AND NOT JUST BE A NUMERICAL OUTPUT

    mainPanel("Data Collection Information",
                  plotOutput(outputId = "study_yr_plot"), # main panel 1? - Hopefully I'm doing this right
              "Seasonality of Tick Abundance by Ecoregion",
                plotOutput(outputId = eco_plot)), # main panel 2? - Still not sure this is right

)


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$range <- renderPrint({ input$slider2 })

    output$study_yr_plot <- renderPlot({

        ggplot(data = tick(), aes(x = year, y = studies)) +
            geom_bar()})

    output$eco_plot <- renderPlot({
        ggplot(data = tick, aes(x = month, y = tick_abd)) +
            geom_bar(aes(color = ecoregion)) +
            geom_smooth(aes(color = ecoregion))
    })

    }



# Run the application
shinyApp(ui = ui, server = server)
