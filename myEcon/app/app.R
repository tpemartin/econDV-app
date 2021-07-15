# makecondition -----------

library(econR)
library(shiny)
library(ggplot2)
library(plotly)

sample <- read.csv(. %//% "support/SampleData.csv")
sample$TARGET <- as.character(sample$TARGET)

input <- "AMT_ANNUITY"
input2 <- "CONTRACT_TYPE"

select1 <- select(sample, input)
select2 <- select(sample, input2)



# server --------

server <- function(input, output) {
  output$distPlot <- plotly::renderPlotly({
    if (is.character(select1[1, 1])) {
      if (is.character(select2[1, 1])) {
        plotOutcome <- ggplot(data = sample) +
          geom_count(aes(
            x = get(input$varible1),
            y = get(input$varible2)
          ))
      }
      else {
        plotOutcome <- ggplot(data = sample) +
          geom_col(aes(
            x = get(input$varible1),
            y = get(input$varible2)
          ))
      }
    }
    else {
      if (is.character(select2[1, 1])) {
        plotOutcome <- ggplot(data = sample) +
          geom_col(aes(
            x = get(input$varible1),
            y = get(input$varible2)
          ))
      }
      else {
        plotOutcome <- ggplot(data = sample) +
          geom_smooth(aes(
            x = get(input$varible1),
            y = get(input$varible2)
          ))
      }
    }
    plotly::ggplotly(plotOutcome)
  })
}

shinyApp(
  ui = shiny::htmlTemplate("www/index.html"),
  server
)
