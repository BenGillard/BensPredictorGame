library(shiny)
library(tidyverse)
library(kableExtra)
library(dplyr)

PredictorData<- readRDS("AllResults.RDS")

shinyApp(
  
  ui <- fluidPage(
    
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "PlayerID", label = "Select Player", choices = names(PredictorData)), #drop down player menu
        actionButton(inputId = "UpdateTable", label = "Update Table"), #button to initiate observeEvent() below
      ),
      mainPanel(
        htmlOutput(outputId = "table1")
      )
    )
  ),
  
  server <- function(input, output) {
    
    observeEvent(input$UpdateTable, {
      
      table1<- PredictorData[[which(names(PredictorData) == input$PlayerID)]]
      
      output$table1 <- renderText({
        table1[,-5] %>% kableExtra::kbl(caption = paste0(input$PlayerID,"'s Guesses"), align = "c", escape = FALSE, col.names = c("Team1", "  ", "  ", "Team2")) %>%  kableExtra::kable_classic(full_width = T, html_font = "Cambria") %>% kable_styling(bootstrap_options = c("striped", "hover")) %>% scroll_box(width = "100%", height = "500px")
      })
    }
    )
    
  }
)
