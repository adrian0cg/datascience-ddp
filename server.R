library(shiny)
library(datasets)

# global base data
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))
variables <- colnames(mtcars)

buildFormula <- function (predictor, regressors) {
    regressorPart <- paste(regressors, collapse = " + ")
    paste(c(predictor,  regressorPart), collapse = " ~ ")
}

except <- function(vector, eltToRemove) {
    vector[- which(vector == eltToRemove)]    
}

shinyServer(function(input, output) {
    
    output$formula <- renderText({
        buildFormula(input$predictor, input$regressors)
    })

    output$prediction <- renderText({"bla"})
    
    output$regressorChoices <- renderUI({
        checkboxGroupInput(
            inputId="regressors", label="Variables to be regressed on:",
            choices=except(variables, input$predictor)
        )
    })
    
    output$ownRegressorInput <- renderUI({
        numericInput(
            "ownWt", "wt", median(mtcars$wt), min=(mtcars$wt),max(mtcars$wt)
        )
    })
    
})
