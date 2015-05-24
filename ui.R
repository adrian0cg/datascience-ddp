library(shiny)

# global data
variables <- colnames(mtcars)


shinyUI(fluidPage(
    
    # title
    titlePanel("MCPC: My Car Performace Calculator"),
    
    # sidebar
    sidebarLayout(
        
        # config panel
        sidebarPanel(
            p("Simple calculator for car performance data based on a model of the <code>mtcars</code> dataset"),
            h3("Config"),
            selectInput(
                inputId="predictor", label="Variable to be predicted:",
                choices=variables
            ),
            checkboxGroupInput(
                inputId="regressors", label="Variables to be regressed on:",
                choices=variables
            )
        ),
        
        # generate computation here
        mainPanel(
            wellPanel(
                h3("Your own car data:")
            ),
            h3("prediction of your car's performance"),
            p(textOutput("computation"))
        )
    )
))
