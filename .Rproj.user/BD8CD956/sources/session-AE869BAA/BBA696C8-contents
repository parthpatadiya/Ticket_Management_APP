
box::use(
  DBI[dbConnect,dbCreateTable,dbWriteTable,dbSendQuery,dbReadTable,dbDisconnect], RSQLite[SQLite,],dplyr[...],lubridate[...], purrr,sodium
)



dbListTables(db)

if (file.exists("app/database/ticket_mgmt_db")) {
  db <- dbConnect(SQLite(), "app/database/ticket_mgmt_db")
} else {
  db <- dbConnect(SQLite(), "app/database/ticket_mgmt_db")
  dbCreateTable(db, "sessionids", c(user_email = "varchar(255)", sessionid = "TEXT", login_time = "TEXT"))
  
  
  dbSendQuery(db,"create table users (user_id int AUTO_INCREMENT UNIQUE,
                                      user_name varchar(255) NOT NULL,
                                      user_email varchar(255) UNIQUE,
                                      password varchar(255),
                                      country varchar(255),
                                      profile_pic varchar(255),
                                      permissions varchar(255),
                                      PRIMARY KEY (user_id)
              
              )")
  
  
  dbSendQuery(db,"create table tickets (id int AUTO_INCREMENT UNIQUE,
                                      ticket_id varchar(255),
                                      user_id int ,
                                      description TEXT,
                                      msg_seq_id int UNIQUE,
                                      ticket_status  varchar(255),
                                      attachment_path TEXT,
                                      post_date DATE,
                                      FOREIGN KEY (user_id) references users(user_id),
                                      PRIMARY KEY (ticket_id) 
              )")
}

tibble::tibble(
  user_id=c(1,2,3,4),
  user_name = c("user1", "user2","parth soni","karan bhuva"),
  user_email= c("user1@gmail.com","user2@gmail.com","parth@gmail.com","karan@gmail.com"),
  password =purrr::map_chr(c("pass1", "pass2","pass3","pass4"), sodium::password_store),
  profile_pic=c("app/database/profile_pics/pic1.jpg","app/database/profile_pics/pic1.jpg","app/database/profile_pics/pic1.jpg","app/database/profile_pics/pic1.jpg"),
  permissions = c("admin", "standard","admin","standard")
  
)%>%dbWriteTable(db, "users", ., append = TRUE)

dbReadTable(db,"users")

DBI::dbDisconnect(db)
