library(shiny)
library(datasets)
data(airquality)
airquality <- airquality[1:4]


# Define the overall UI
shinyUI(pageWithSidebar(
    headerPanel('Linear Regression on airquality dataset'),
    sidebarPanel(
        h4("Ozone level prediction"),
        p("Please, select a regression variable to predict the ozone level. Then use
          the sliders to tune the RED regression line. Try to minimise RMSE error to obtain
          the ideal least-squares regression line (wich is shown in BLUE)."),
        selectInput('reg_var', 'Regression Variable', names(airquality)[-1], selected=names(airquality)[[2]]),
        sliderInput("intercept", "Intercept:", 
                    min=-200.0, max=100.0, value=0.00, step = 0.01),
        sliderInput("slope",     "Slope coefficient:", 
                    min=-10.0,  max=10.0, value=1.0, step = 0.01)
    ),
    mainPanel(
        plotOutput('plot1'),
        verbatimTextOutput('output_text')
    )
))