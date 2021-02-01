library(shiny)
library(shinyhelper)

shinyUI(fluidPage(

    # Application title
    titlePanel("How Fuel Efficient Is It?"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("method", "Select Prediction Model (Choose One)",
                        c("Linear (Fast but less accurate)" = "lm", 
                          "Random Forest (More Accurate but slow)" = "rf")),
            selectInput("cyls", "Number of Cylinders", c(4, 6, 8)),
            sliderInput("displacement", "Displayment (cubic inches)", 
                        min(mtcars$disp) - 25, max(mtcars$disp) + 25, 
                        mean(mtcars$disp)),
            sliderInput("horse", "Horsepower",
                        min(mtcars$hp) - 10, max(mtcars$hp) + 50,
                        mean(mtcars$hp)),
            sliderInput("ratio", "Rear Axle Ratio",
                        min(mtcars$drat) - .5, max(mtcars$drat) + .5,
                        mean(mtcars$drat)),
            sliderInput("weight", "Weight (lbs)",
                        (min(mtcars$wt) * 1000) - 200, 
                        (max(mtcars$wt) * 1000) + 200,
                        mean(mtcars$wt) * 1000),
            sliderInput("quart", "Quarter Mile Time",
                        min(mtcars$qsec) - .25, max(mtcars$qsec) + .25  ,
                        mean(mtcars$qsec)),
            sliderInput("carbs", "Number of Carburetors", 1 , 8, 4),
            selectInput("trans", "Transmission Type", 
                        c("Automatic" = 0, "Manual" = 1)),
            selectInput("eng", "Engine Shape",
                        c("V-shaped" = 0, "Straight" = 1)),
            numericInput("gears", "Number of Gears", 4, 3, 5),
            actionButton("done", "Submit")            
        ),

        mainPanel(
            helper(textOutput("help"), icon = "question-circle", colour = "red",
                   type = "markdown", content = "README", size = "l"),
            p(),
            p("Lets see how many miles your car will get per gallon."),
            textOutput("miles"),
            p(),
            p("Here's how your car compares to others."),
            plotOutput("hist")
        )
    )
))
