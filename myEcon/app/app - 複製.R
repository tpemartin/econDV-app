# makecondition -----------

library(shiny)
library(ggplot2)
library(plotly)

sample <- read.csv("./SampleData.csv")
sample$TARGET <- as.character(sample$TARGET)



# server --------

server <- function(input, output) {
  
  select1<-select(sample,reactive(input$varible1))
  select2<-select(sample,reactive(input$varible2))
  
  output$distPlot <- renderPlotly({
    if (is.character(select1[1,1])) {
      if (is.character(select2[1,1])){
        output_distPlot <- ggplot(data = sample) + geom_count(
          aes(x=get(input$varible1), y = get(input$varible2))
        )
      } else {
        output_distPlot <- ggplot(data = sample) + geom_col(
          aes(x=get(input$varible1), y = get(input$varible2))
        )
      }
    } else {
      if (is.character(select2[1,1])){
        output_distPlot <- ggplot(data = sample) + geom_col(
          aes(x=get(input$varible1), y = get(input$varible2))
        )
      }else{
        output_distPlot <- ggplot(data = sample) + geom_smooth(
          aes(x=get(input$varible1), y = get(input$varible2))
        )
      }
    }
})
}

shinyApp(
  ui = shiny::htmlTemplate("www/index.html"),
  server
)
