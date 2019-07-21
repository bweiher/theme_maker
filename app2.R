library(shiny)
library(miniUI)

themes <- rstudioapi::getThemes()
chr <- character(length = length(themes))
for(g in seq_along(themes)){
  chr[g] <- themes[[g]]$name  
}
initial_theme <- rstudioapi::getThemeInfo()$editor

ui <- miniPage(
  gadgetTitleBar("RStudio Theme Editor"),
  miniTabstripPanel(
    miniTabPanel("Choose Theme", icon = icon("sliders"),
                   selectInput(inputId = "theme_choice", 
                               label = "Choose Theme",
                               choices = chr,
                               selected = initial_theme)
    ),
    miniTabPanel("Create Theme", icon = icon("table")
  )
    
  )
)

server <- function(input, output, session) {
  
  
  observeEvent(input$theme_choice, {
    rstudioapi::applyTheme(input$theme_choice)
})
  

  observeEvent(input$done, {
    stopApp(TRUE)
  })
  
  
  
  
  
}

runGadget(shinyApp(ui, server), viewer = paneViewer())
