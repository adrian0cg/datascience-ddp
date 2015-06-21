library(shiny)
library(datasets)

# global base data
transmissions <- c("Automatic", "Manual")
mtcars$am <- factor(mtcars$am, labels = transmissions)
variables <- colnames(mtcars)

buildFormula <- function (predictor, regressors) {
    regressorPart <- paste(regressors, collapse = " + ")
    paste(c(predictor,  regressorPart), collapse = " ~ ")
}

conditionalInputFor <- function (regressor) {
    conditionalPanel(
        condition = paste0("input.regressors.indexOf(",regressor,") != -1"),
        switch(
            regressor,
            numericInput(
                paste0("own_",regressor), regressor,
                value = median(mtcars[[regressor]]), min = min(mtcars[[regressor]]), max = max(mtcars[[regressor]])
            ),
            "am" = radioButtons(
                paste0("own_",regressor), regressor,
                choices = transmissions, inline = TRUE
            ),
            "cyl" = numericInput(
                paste0("own_",regressor), regressor,
                value = median(mtcars[[regressor]]), step =1,
                min = min(mtcars[[regressor]]), max = max(mtcars[[regressor]])
            )
        )
    )
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
        lapply(input$regressors, conditionalInputFor)
    })
    
})
