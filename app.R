#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(tidyverse)

family_list <- unique(CCH_subset$family)
family_list_sort <- sort(family_list)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Herbarium Data of North America"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with inputs
    sidebarPanel(
      #To select Family Name
      selectInput("family", "Plant Families:", choices = family_list_sort),
      
      #To select collection years
      sliderInput("slider2", label = ("Collection Years"), min = 1877, 
                  max = 2010, value = c(1900, 1920)),
      #To create header text
      hr(),
      helpText("Herbarium Data Source: California Consortium of Herbaria")),
    
    mainPanel(leafletOutput("CCH_map")))
  
)


# Define server logic required to draw a histogram


server <- function(input, output, session) {
  
  
  output$CCH_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addMarkers(data = CCH_subset, lat = ~ Latitude, lng = ~ Longitude)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
