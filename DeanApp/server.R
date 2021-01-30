library(shiny)
library(caret)

data(mtcars)

shinyServer(function(input, output) {
    
    mtcars$vs <- as.factor(mtcars$vs)
    mtcars$am <- as.factor(mtcars$am)
    mtcars$gear <- as.factor(mtcars$gear)
    
    observeEvent(inpute$done, {
        if(input$method == "lm"){
            linFit <- lm(mpg ~ . , data = mtcars)
        
        }
        else{
            
        }
    })    
    
})
