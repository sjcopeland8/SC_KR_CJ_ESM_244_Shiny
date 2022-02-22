#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)


# Define UI for application that draws a histogram
ui <- fluidPage(

    #application title
    titlePanel("Tick, Tick, Boom: Tick distribution and tick-borne pathogens in California"),

    sidebarLayout(

        sidebarPanel("widgets here",
                     radioButtons(inputID = "County",
                     label = "Choose County",
                     choices = c("Sierra" ,"Sacramento","Santa Barbara" , "Calaveras" ,"Ventura", "Los Angeles","Sonoma", "San Francisco","Marin" ,"Mariposa","Lassen","Napa","Kings","San Diego","Placer", "San Francisco", "Marin","Mariposa",  "Lassen", "Napa", "Shasta","Monterey", "Trinity","Mendocino","Inyo","Mono","Tuolumne","Solano", "San Bernardino", "Contra Costa" ,"Alpine","El Dorado","Yolo", "Yuba", "San Benito", "Humboldt", "Riverside","Kern","Colusa" ,"Del Norte" ,"Modoc", "Fresno", "Madera", "Santa Clara", "Tehama" ,"San Joaquin" ,"Alameda","Nevada","Butte", "Merced", "Tulare" , "Stanislaus","Orange","Imperial","Sutter", "Amador", "Lake" ,"Plumas" ,"San Mateo", "Siskiyou", "Santa Cruz", "Glenn", "San Luis Obispo"
                     )),

       mainPanel("put my map here"),
           )
) #end sidebar layout

)



# Define server logic required to draw a histogram
server <- function(input, output) {

    county_select <- reactive({
    long %>%
        filter(County == input$County)
    }) #end county select reactive

output$lyme_plot  <- renderPlot({
    ggplot(data = county_select, aes(x = year, y = incidence, group = County)) +
        geom_line(aes(color = County)) +
        labs(x = "Year", y = "Lyme Disease Incidence", title = "Human Lyme Disease Incidence 2011-2020")
    theme_minimal()
    ggplotly(tick_graph)
})
    }



# Run the application
shinyApp(ui = ui, server = server)
