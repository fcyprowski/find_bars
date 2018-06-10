library(shiny)
library(shinydashboard)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    visualisationMap(input$city)
  })
}