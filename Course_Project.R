library(shiny)
library(shinyapps)

deployApp("airqualityApp")

rm(list=ls())
setwd("~/Desktop/Courses_Online/Data_Science_Specialization/09_Developing_Data_Products")
runApp("airqualityApp")


