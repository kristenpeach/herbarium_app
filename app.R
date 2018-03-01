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
      
      
      #To create header text
      hr(),
      helpText("Herbarium Data Source: California Consortium of Herbaria")),
    
    mainPanel(leafletOutput("CCH_map"),
              plotOutput("CCH_graph")))
  
)


# Define server logic required to draw a histogram


server <- function(input, output, session) {
  
  
  output$CCH_map <- renderLeaflet({
    CCH_subset_map <- CCH_subset %>% 
      filter(family == input$family)
      
    
    leaflet() %>%
      addTiles() %>% 
      addMarkers(data = CCH_subset_map, lat = ~ Latitude, lng = ~ Longitude)
  })
  
  output$CCH_graph <- renderPlot({
    
    CCH_subset_x <- CCH_subset %>% 
      filter(family == input$family) %>% 
      count(species) %>% 
      arrange(n) %>% 
      tail(10)
    
    
    ggplot(CCH_subset_x, aes(x = species, y = n)) + 
      geom_col(aes(fill = species)) + 
      xlab("Top 10 Species Collected") +
      ylab("Freqency of Collection") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
