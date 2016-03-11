library(shiny)
library(ggplot2)
library(productplots)
load("./happy.RData")
happy<-na.omit(happy)


shinyServer(
  function(input, output) {
    output$distribution <- renderPlot({
      happyset<-happy[sample(1:nrow(happy),input$obs),]
      if(input$var1=="marital" && input$var2=="marital")
        prodplot(happyset,~marital+marital)
      else if(input$var1=="marital" && input$var2=="happy")
        prodplot(happyset,~marital+happy)
      else if(input$var1=="marital" && input$var2=="degree")
        prodplot(happyset,~marital+degree)
      else if(input$var1=="happy" && input$var2=="happy")
        prodplot(happyset,~happy+happy)
      else if(input$var1=="happy" && input$var2=="degree")
        prodplot(happyset,~happy+degree)
      else if(input$var1=="happy" && input$var2=="marital")
        prodplot(happyset,~happy+marital)
      else if(input$var1=="degree" && input$var2=="degree")
        prodplot(happyset,~degree+degree)
      else if(input$var1=="degree" && input$var2=="happy")
        prodplot(happyset,~degree+happy)
      else if(input$var1=="degree" && input$var2=="marital")
        prodplot(happyset,~degree+marital)
    })
    output$ot <- renderText(input$obs)
  }
)