# makecondition -----------

library(shiny)
library(ggplot2)
library(plotly)

sample <- read.csv("./SampleData.csv")
sample$TARGET = as.character(sample$TARGET)



# server --------

server <- function(input, output){
output$distPlot <- renderPlotly({
    ggplot(data = sample) + geom_count(aes(x = get(input$varible1), 
        y = get(input$varible2))) + scale_size_area(max_size = 15)
})
}
