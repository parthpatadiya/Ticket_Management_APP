box::use(
  
  shiny[...],shinyauthr,dplyr[...],lubridate[...],shinydashboard[...],
)

box::use(
  app/logic/login_backend[...],
)

#' @export
ui<-function(id){
  
  ns<-NS(id)
  cookie_expiry <- 7 # Days until session expires
  tagList(
    
    dashboardPage(dashboardHeader(title = "Help Desk Dashboard"),dashboardSidebar(disable = TRUE),dashboardBody(
    fluidPage(
      
      # add logout button UI
      div(class = "pull-right", shinyauthr::logoutUI(id = ns("logout"))),
      # add login panel UI function
      shinyauthr::loginUI(id = ns("login"), user_title = "User Email",cookie_expiry = cookie_expiry),
      # setup table output to show user info after login
      tableOutput(ns("user_table"))
    )
    
  )))
}

#' @export
server<-function(id){
  
  moduleServer(id,function(input,output,session){
    # call the logout module with reactive trigger to hide/show
    logout_init <- shinyauthr::logoutServer(
      id = "logout",
      active = reactive(credentials()$user_auth)
    )
    
    # call login module supplying data frame, user and password cols
    # and reactive trigger
    credentials <- shinyauthr::loginServer(
      id = "login",
      data = user_base(),
      user_col = user_email,
      pwd_col = password,
      cookie_logins = TRUE,
      sodium_hashed = TRUE,
      sessionid_col = sessionid,
      cookie_getter = get_sessionids_from_db,
      cookie_setter = add_sessionid_to_db,
      log_out = reactive(logout_init())
    )
    
    # pulls out the user information returned from login module
    user_data <- reactive({
      credentials()$info
    })
    
    output$user_table <- renderTable({
      # use req to only render results when credentials()$user_auth is TRUE
      req(credentials()$user_auth)
      user_data() %>%
        dplyr::mutate(across(starts_with("login_time"), as.character))
    })
    
  })
}