library(shiny)

# global data
variables <- colnames(mtcars)


shinyUI(fluidPage(
    
    # title
    titlePanel("MCPC: My Car Performace Calculator"),
    p("Simple calculator for car performance variables data based on a model made from the ",code("mtcars")," dataset."),
    
    
    # sidebar
    sidebarLayout(
        # config panel
        sidebarPanel(
            h3("Config"),
            p(strong("1"), " - Please choose one of the variables to be predicted by the others"),
            p(em("The only static input element.")),
            selectInput(
                inputId="predictor", label="Variable to be predicted:",
                choices=variables
            ),
            p(strong("2"), " - Now pick a subset of the remaining variables to regress on"),
            p(em("These checkboxes are dynamically created.")),
            uiOutput("regressorChoices"),
            hr(),
            h3("Your Car"),
            p(strong("3")," - Now, please enter the characteristics of your car:"),
            p(em("For each selected regressor above, you are now required to enter a value. The ranges are set within the range of the existing data to provide sensible results.")),
            uiOutput("ownRegressorInput")
        ),
        
        # generate computation here
        mainPanel(
            h3("Model"),
            p(strong("1 & 2 -> "),"The prediction of your car's performance will be based on the following (linear) model:"),
            p(em("This model will be created and calculated reactively only once the variables are picked.")),
            h4(textOutput("formula")),
            p(verbatimTextOutput("model")),
            hr(),
            h3("Prediction"),
            p(strong("3 -> "),"Based on your input and the afforementioned model, we predict the performance of your car as follows:"),
            h4(textOutput("prediction")),
            p(em("This value gets updated as soon as you enter new values on the right."))
        )
    )
))
