library(shiny)
library(datasets)
data(airquality)
airquality <- airquality[1:4]
for (i in 1:4)
    airquality <- airquality[ !is.na(airquality[[i]]), ]

# Define a server for the Shiny app
shinyServer(function(input, output, session) {
    
    # Combine the selected variables into a new data frame
    selected_regvar <- reactive({
        input$reg_var
    })
    
    fit_results <- reactive({
        x <- airquality[[selected_regvar()]]
        y <- airquality[["Ozone"]]
        intercept <- input$intercept
        slope <- input$slope
        ypred <- intercept + slope*x
        RMSE  <- sqrt( sum( (y-ypred)^2 ) )
        print( paste("(selected reg line) current RMSE:", as.character(RMSE),collapse="") )
    })
    
    output$plot1 <- renderPlot({
        formula <- paste(c("Ozone ~ ", selected_regvar()), collapse="")
        plot_data <- airquality[, c(selected_regvar(), "Ozone")]
        plot(plot_data, main=formula)
        intercept <- input$intercept
        slope     <- input$slope
        abline(a=intercept, b=slope, col="red", lwd=3)
        perfect_fit <- lm( formula, data=airquality)
        abline(perfect_fit, col="blue", lwd=3)
        legend("topright", c(formula, "selected reg line", "perfect reg line"), pch = c(1,NA_integer_,NA_integer_), lty=c(0,1,1), lwd=c(1,3,3), col=c("black","red","blue") )
    })
    
    output$output_text <- renderPrint( fit_results() )
})