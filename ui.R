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
            uiOutput("regressorChoices")
        ),
        
        # generate computation here
        mainPanel(
            h2("Model:"), h4(textOutput("formula")),
            inputPanel(
                h2("Your own car data:"),
                uiOutput("ownRegressorInput")
            ),
            h2("Prediction of Your Car's Performance:"),
            p(textOutput("prediction"))
        )
    )
))
