library(shiny)
library(datasets)

# global base data
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))
variables <- colnames(mtcars)


shinyServer(function(input, output) {
    
    output$computation <- renderText({
        paste0(c("predictor: ",input$predictor))
    })
    
})
