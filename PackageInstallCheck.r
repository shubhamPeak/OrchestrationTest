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
                 host = Sys.getenv('REDSHIFT_HOST'),
                 port = 5439,
                 user = Sys.getenv('REDSHIFT_USERNAME'),
                 password = Sys.getenv('REDSHIFT_PASSWORD')
)
}


## specifiy packages to test here 
packages_to_test <- c('Anomalydetection', 'aws.s3', 'aws.signature', 'Caret')
           ##  'changepoint', 'data.table', 'DBI', 'dbplyr', 'devtools', 'doParallel', 'DT', 'FeatureHashing', 'flexdashboard', 'Foreach', 'forecast', 'Ggforce', 'ggthemes', 'glmnet', 'httr', 'jsonlite', 'kableExtra', 'Knitr', 'Lme4', 'lubridate', 'Matrix', 'Padr', 'Parallel', 'peaktheme', 'Prophet', 'RColorBrewer', 'RCurl', 'reshape2',
##  'rmarkdown', 'Roxygen2', 'scales', 'Shiny', 'Shinydashboard', 'Slackr', 'Stats', 'Tibble', 'tidyverse', 'tomr', 'Tsintermittent', 'Xfun', 'xgboost', 'Zoo') 


test_packages <- data.frame(package = packages_to_test,
                            installed = NA,
                            test_date = NA)


## RUN check
test_packages <- check_package_installation(test_packages, conn = conn)













