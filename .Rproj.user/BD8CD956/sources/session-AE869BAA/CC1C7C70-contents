

box::use(
  DBI[dbConnect,dbCreateTable,dbWriteTable,dbReadTable], RSQLite[SQLite,],dplyr[...],lubridate[...], purrr,sodium
)



# connect to, or setup and connect to local SQLite db
db<-function(){
  if (file.exists("app/database/ticket_mgmt_db")) {
    db <- dbConnect(SQLite(), "app/database/ticket_mgmt_db")
  } else {
    db <- dbConnect(SQLite(), "app/database/ticket_mgmt_db")
    dbCreateTable(db, "sessionids", c(user_email = "TEXT", sessionid = "TEXT", login_time = "TEXT"))
  }
  return(db)
}
# This function must accept two parameters: user and sessionid. It will be called whenever the user
# successfully logs in with a password.  This function saves to your database.
#' @export
add_sessionid_to_db <- function(user_email, sessionid, conn = db()) {
  tibble(user_email = user_email, sessionid = sessionid, login_time = as.character(now())) %>%
    dbWriteTable(conn, "sessionids", ., append = TRUE)
}
cookie_expiry <- 7 # Days until session expires
# This function must return a data.frame with columns user and sessionid  Other columns are also okay
# and will be made available to the app after log in as columns in credentials()$user_auth
#' @export
get_sessionids_from_db <- function(conn = db(), expiry = cookie_expiry) {
  dbReadTable(conn, "sessionids") %>%
    mutate(login_time = ymd_hms(login_time)) %>%
    as_tibble() %>%
    filter(login_time > now() - days(expiry))
}

# dataframe that holds usernames, passwords and other user data
#' @export
user_base <- function(){
  
  data<-as_tibble(dbReadTable(db(),"users"))
  print(data)
  return(data)
  }


