library(shiny)
library(datasets)

# global base data
transmissions <- c("Automatic", "Manual")
mtcars$am <- factor(mtcars$am, labels = transmissions)
variables <- colnames(mtcars)

conditionalInputForRegressors <- function (regressor) {
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

getInputForRegressors <- function (data, regressor) {
    data[[paste0("own_",regressor)]]
}

except <- function(vector, eltToRemove) {
    vector[- which(vector == eltToRemove)]    
}

shinyServer(function(input, output) {

    buildFormula <- reactive({
        regressorPart <- paste(input$regressors, collapse = " + ")
        paste(c(input$predictor,  regressorPart), collapse = " ~ ")
    })
    
    buildModel <- reactive({
        lm(buildFormula(), data=mtcars)
    })
    
    output$formula <- renderText({
        buildFormula()
    })
    
    output$model <- renderPrint({
        print(buildModel())
        summary(buildModel())
    })

    output$prediction <- renderText({
        myCar <- data.frame(lapply(input$regressors, function(x) {getInputForRegressors(input,x)}))
        names(myCar) <- input$regressors
        paste(
            input$predictor,
            predict(
                buildModel(),
                newdata = myCar
            ), sep=" = "
        )
    })
    
    output$regressorChoices <- renderUI({
        checkboxGroupInput(
            inputId="regressors", label="Variables to be regressed on:",
            choices=except(variables, input$predictor)
        )
    })
    
    output$ownRegressorInput <- renderUI({
        lapply(input$regressors, conditionalInputForRegressors)
    })
    
})
