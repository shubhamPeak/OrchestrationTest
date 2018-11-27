library(RPostgreSQL);
library(dplyr);
library(DBI)
## Script to test package installation
# Requires a connection to Redshift. 

## Connection type (ODBC, POSTGRESQL)
CONNECTION = 'POSTGRESQL'

## functions 
check_package_installation <- function(test_packages = NULL, conn = NULL) {
  
  test_packages$installed <- unlist(lapply(test_packages$package, FUN = function(x) {
    as.character(require(x, character.only = TRUE))
  }))
  
  test_packages$test_date <- as.character(Sys.Date())

  if(!is.null(conn)) {
   ace <-  DBI::dbWriteTable(conn = conn,
                       name = "package_check",
                       value = test_packages,
                       append = TRUE
                      )
  }
  
  return(test_packages)
}



### set up db connection

if (CONNECTION == 'ODBC') {
conn <- DBI::dbConnect(odbc::odbc(), "common")
} else if (CONNECTION == 'POSTGRESQL'){
  ### NEED to ADD alternative connection type here
    conn <- dbConnect(dbDriver("PostgreSQL"),
                 dbname = "tenant912",
                 host = HOST,
                 port = 5439,
                 user = USERNAME,
                 password = PASSWORD
)
}


## specifiy packages to test here 
packages_to_test <- c('dplyr', 'fake_package') 


test_packages <- data.frame(package = packages_to_test,
                            installed = NA,
                            test_date = NA)


## RUN check
test_packages <- check_package_installation(test_packages, conn = conn)













