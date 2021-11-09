## library(shiny)
## library(shiny386)

## ui <- page_386(
##  card_386(
##   title = "oolong",
##   "Topic 1 of 10",
##   br(),
##    checkbox_group_input_386("variable", "Which of the following is an intruder word?",
##    c("self" = "self",
##      "frame" = "frame",
##      "stori" = "stori",
##      "newspaper" = "newspaper",
##      "news" = "news",
##      "coverage" = "coverage")),
##   footer = "oolong 386"
##  )
## )

## server <- function(input, output, session) {}
## shinyApp(ui, server)
