box::use(
  shiny[bootstrapPage, moduleServer, NS, renderText, tags, textOutput],
)

box::use(
  
  app/view/login,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
  
    
    login$ui(ns("login_page"))
      
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    login$server("login_page")
    
  })
}
