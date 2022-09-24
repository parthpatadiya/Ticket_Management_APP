
box::use(
  
  shiny[...],shinyauthr,dplyr[...],lubridate[...],shinydashboard[...],
)


ui<-function(id){
  ns<-NS(id)
  
  tagList(

    header <- dashboardHeader(title="Help Desk"),
    
    sidebar <- dashboardSidebar(),
    
    body <- dashboardBody(),
    
    dashboardPage(header, sidebar, body),
        
  )
  
}