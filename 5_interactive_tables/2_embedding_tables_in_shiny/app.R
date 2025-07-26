# Load required packages
library(shiny)
library(DT)

# Sample data
data <- mtcars
data$car <- rownames(mtcars)

# Define UI
ui <- fluidPage(
  titlePanel("Lecture 12: Embedding Tables in Shiny Apps"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("cyl", "Choose Cylinder Count:", 
                  choices = unique(data$cyl), 
                  selected = unique(data$cyl)[1],
                  multiple = TRUE)
    ),
    
    mainPanel(
      h3("Filtered Table (Interactive)"),
      DTOutput("carTable")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  filteredData <- reactive({
    data[data$cyl %in% input$cyl, ]
  })
  
  output$carTable <- renderDT({
    datatable(
      filteredData(),
      options = list(pageLength = 5, autoWidth = TRUE),
      rownames = FALSE
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
