
library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("MPG data with random variable of interest"),
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "var",
                      label = "Variable of interest",
                      choices = c("cty", "hwy")),
        ),
        # Show a table
        mainPanel(
           tableOutput("table")
        )
    )
)

server <- function(input, output) {
    output$table <- renderTable({
      mpg %>% 
        select(-.data[[input$var]]) %>% 
        mutate(new = 20) %>% 
        set_names(ifelse(names(.) == "new", 
                         input$var, 
                         names(.)))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
