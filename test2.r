library(RPostgreSQL);
library(dplyr);

USERNAME = Sys.getenv('REDSHIFT_USERNAME')
PASSWORD = Sys.getenv('REDSHIFT_PASSWORD')
HOST = Sys.getenv('REDSHIFT_HOST')
print(USERNAME)
print(PASSWORD)
print(HOST)

con <- dbConnect(dbDriver("RPostgreSQL"),
                 dbname = "shubhamjupy",
                 host = HOST,
                 port = 5439,
                 user = USERNAME,
                 password = PASSWORD
)
dbGetQuery(con,"INSERT INTO publish.shubham2 (id, name) VALUES (1,'R1');")
