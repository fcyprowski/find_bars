library(shiny)
library(shinydashboard)

header = dashboardHeader(title = "Bar Finder")
sidebar = dashboardSidebar(
                    
        menuItem("SEARCH IT", tabName = "searcher", icon = icon("beer"))
                           )
body = dashboardBody(
  tabItem(tabName = "city_search",
          fluidRow(
            selectInput(inputId = 'city' , 
                        label = "Decide where R U now", 
                        choices = c("London", "Bialystok", "Warsaw")),
            box(plotOutput("plot1"))
            )
          )
)


dashboardPage(
  header,
  sidebar,
  body
)
