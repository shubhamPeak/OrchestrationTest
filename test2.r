library(RPostgreSQL);
library(dplyr);

USERNAME = Sys.getenv('REDSHIFT_USERNAME')
PASSWORD = Sys.getenv('REDSHIFT_PASSWORD')
HOST = Sys.getenv('REDSHIFT_HOST')
print(USERNAME)
print(PASSWORD)
print(HOST)

con <- dbConnect(dbDriver("PostgreSQL"),
                 dbname = "punit_test_001",
                 host = HOST,
                 port = 5439,
                 user = USERNAME,
                 password = PASSWORD
)
dbGetQuery(con,"INSERT INTO publish.q1 (firstname, email) VALUES ('name5','mail5@mail.com');")
