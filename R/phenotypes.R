#' Get phenotype data for one or multiple users.
#'
#' @export
#' @param userid ID of openSNP user.
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return List of phenotypes for specified user(s).
#'
#' @examples \dontrun{
#' phenotypes(userid=1)
#' phenotypes(userid='1,6,8', df=TRUE)
#' phenotypes(userid='1-8', df=TRUE)
#'
#' # coerce to data.frame
#' library(plyr)
#' df <- ldply(phenotypes(userid='1-8', df=TRUE))
#' head(df); tail(df)
#'
#' # pass on curl options
#' library("httr")
#' # phenotypes(1, config=c(verbose(), timeout(1)))
#' phenotypes(1, config=verbose())
#' }

phenotypes <- function(userid = NA, df = FALSE, ...) {
  url2 <- paste0(paste0(osnp_base(), "phenotypes/json/"), userid, '.json')
  message(url2)
  res <- GET(url2, ...)
  stop_for_status(res)
  out <- jsonlite::fromJSON(cuf8(res), FALSE)

  userid <- gsub("-", ",", userid)

  if (df) {
    if (length(str_split(userid, ",")[[1]]) == 1) {
      tmp <- ldply(out[[2]], data.frame, stringsAsFactors = FALSE)
      names(tmp) <- c("phenotype","phenotypeID","variation")
      tmp
    } else {
      outdf <- list()
      for (i in seq_along(out)) {
        if ( class(try(out[[i]][[2]], silent = TRUE)) == "try-error") {
          df <- data.frame("no data", "no data", "no data", 
                           stringsAsFactors = FALSE)
          names(df) <- c("phenotype","phenotypeID","variation")
          outdf[[paste("no info on user", i, sep = "_")]] <- df
        } else {
          if (length(out[[i]][[2]]) == 0) {
            df <- data.frame("no data", "no data", "no data", 
                             stringsAsFactors = FALSE)
            names(df) <- c("phenotype","phenotypeID","variation")
            outdf[[ out[[i]][[1]][["name"]] ]] <- df
          } else {
            df <- ldply(out[[i]][[2]], data.frame, stringsAsFactors = FALSE)
            names(df) <- c("phenotype","phenotypeID","variation")
            outdf[[ out[[i]][[1]][["name"]] ]] <- df
          }
        }
      }
      outdf
    }
  } else { 
    out 
  }
}
