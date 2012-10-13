#' Get openSNP users.
#'
#' @import RJSONIO plyr
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param url Base URL for API method; leave unchanged. 
#' @return List of openSNP users, their ID numbers, and XX if available.
#' @export 
#' @examples \dontrun{
#' # just the list
#' data <- users(df=FALSE)
#' data 
#' 
#' # get a data.frame of the users data
#' data <- users(df=TRUE)
#' data[[1]] # users with links to genome data
#' data[[2]] # users without links to genome data
#' }
users <- function(df = FALSE, url = "http://opensnp.org/users.json") 
{
  users_ <- fromJSON(url)
  if(df == FALSE){users_} else
  {
    lengths <- laply(users_, function(x) length(unlist(x)))
    getdffive <- function(x) {
      if(length(unlist(x)) == 5) data.frame(x)
      }
    getdftwo <- function(x) {
      if(length(unlist(x)) == 2) data.frame(x[1:2])
      }
    withlinks <- ldply(users_, getdffive)
    withoutlinks <- ldply(users_, getdftwo)
    list(withlinks, withoutlinks)
  }
}