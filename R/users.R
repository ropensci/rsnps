#' Get openSNP users.
#'
#' @export
#' @family opensnp-fxns
#' @param df Return data.frame (`TRUE`) or not (`FALSE`). Default: `FALSE`
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return List of openSNP users, their ID numbers, and genome data if available.
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
  

  tryCatch(
    {
      res <- os_GET(paste0(osnp_base(), "users.json"), list(), ...)
      ## need to check what it returns
      # Process the data or perform any desired operations
    },
    error = function(e) {
      message("Failed to retrieve data from OpenSNP. Please check the URL or try again later.")
      stop("Error - Failed to retrieve data from OpenSNP or connection is interrupted")
    }
    ,
    warning = function(w) {
      message("Warning: Data retrieval resulted in a warning.")
      # Handle warnings if necessary
      stop("Warning - Failed to retrieve data from OpenSNP or connection is interrupted")
    }
  )
  
  users_ <- jsonlite::fromJSON(res, FALSE)
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
