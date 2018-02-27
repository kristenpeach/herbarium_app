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

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
      titlePanel("Herbarium Data of North America"),
      
      # Generate a row with a sidebar
      sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
          selectInput("family", "Plant Families:", choices=colnames(CCH_subset)),
          
          hr(),
          helpText("Herbarium Data Source"))),
      
  
        mainPanel(
          leafletOutput("CCH_map"))
        
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

