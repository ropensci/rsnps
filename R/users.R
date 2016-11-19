#' Get openSNP users.
#'
#' @export
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return List of openSNP users, their ID numbers, and XX if available.
#' @examples \dontrun{
#' # just the list
#' data <- users(df = FALSE)
#' data
#'
#' # get a data.frame of the users data
#' data <- users(df = TRUE)
#' data[[1]] # users with links to genome data
#' data[[2]] # users without links to genome data
#' }

users <- function(df = FALSE, ...) {
  res <- GET(paste0(osnp_base(), "users.json"), ...)
  stop_for_status(res)
  users_ <- jsonlite::fromJSON(cuf8(res), FALSE)
  if (!df) { 
    users_ 
  } else {
    lengths <- laply(users_, function(x) length(unlist(x)))
    getdffive <- function(x) {
      if (length(unlist(x)) == 5) data.frame(x, stringsAsFactors = FALSE)
    }
    getdftwo <- function(x) {
      if (length(unlist(x)) == 2) data.frame(x[1:2], stringsAsFactors = FALSE)
    }
    withlinks <- ldply(users_, getdffive)
    withoutlinks <- ldply(users_, getdftwo)
    list(withlinks, withoutlinks)
  }
}
