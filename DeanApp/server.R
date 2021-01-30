library(shiny)
library(caret)

data(mtcars)

shinyServer(function(input, output) {
    
    mtcars$cyl <- as.factor(mtcars$cyl)
    mtcars$vs <- as.factor(mtcars$vs)
    mtcars$am <- as.factor(mtcars$am)
    mtcars$gear <- as.factor(mtcars$gear)
    
    observeEvent(input$done, {
        newCar <- data.frame(cyl = as.factor(input$cyls), disp = input$displacement,
                             hp = input$horse, drat = input$ratio, 
                             wt = input$weight/1000, qsec = input$quart, 
                             vs = input$eng, am = input$trans, 
                             gear = as.factor(input$gears), carb <- input$carbs)
        if(input$method == "lm"){
            linFit <- lm(mpg ~ . , data = mtcars)
            miles <- predict(linFit, newCar)
        }
        else{
            rfFit <- train(mpg ~ . , data = mtcars, method = "rf")
            miles <- predict(rfFit, newCar)
        }
        
        if(miles >= 5) {
            output$miles <- renderText(miles)
            output$hist <- renderPlot({
                hist(mtcars$mpg, xlab = "Miles per Gallon", col = "blue", 
                     main = "", breaks = 10, xlim = c(5,35))
                abline(v = miles, col = "red")
            })
        }
        else {output$miles <- renderText("Chosen car specifications does not fit model")}
    })    
    
})
