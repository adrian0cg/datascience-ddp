library(shiny)
library(datasets)

# global base data
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))
variables <- colnames(mtcars)

buildFormula <- function (predictor, regressors) {
    regressorPart <- paste(regressors, sep=" + ")
    paste(c(predictor,  regressorPart), sep=" ~ ")
}

shinyServer(function(input, output) {
    
    output$formula <- renderText({
        buildFormula(input$predictor, input$regressors)
    })
    
    output$prediction <- renderText({"bla"})
    
})
