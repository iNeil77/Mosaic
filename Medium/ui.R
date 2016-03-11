library(shiny)
library(ggplot2)
library(productplots)
load("./happy.RData")
happy<-na.omit(happy)

shinyUI(fluidPage(
  titlePanel("Responsive Mosaic Plot"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose any two categorical variables to generate mosaicplot."),
      
      selectInput("var1", 
                  label = "Choose a variable to display",
                  choices = c("marital", "degree", "happy"),
                  selected = "marital"),

      
      selectInput("var2", 
                  label = "Choose a variable to display",
                  choices = c("marital", "degree", "happy"),
                  selected = "happy"),
      
      sliderInput("obs", 
                  label = "Number of observations:",
                  min = 0, max = nrow(happy), value =nrow(happy))
    ),
    
    mainPanel(plotOutput("distribution"),
    textOutput("ot"))
  )
))