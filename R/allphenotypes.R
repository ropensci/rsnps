#' Get all openSNP phenotypes, their variations, and how many users have data
#' 		available for a given phenotype.
#'
#' Either return data.frame with all results, or output a list, then call
#' 		the characteristic by id (parameter = "id") or name (parameter =
#' 		"characteristic").
#'
#' @export
#' @family opensnp-fxns
#' @param df Return a data.frame of all data. The column known_variations
#' can take multiple values, so the other columns id, characteristic, and
#' number_of_users are replicated in the data.frame. Default: `FALSE`
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return data.frame of openSNP phenotypes, variants and users per phenotype, or list if `df=FALSE`
#' @examples \donttest{
#' # Get all data
#' allphenotypes(df = TRUE)
#'
#' # Output a list, then call the characteristic of interest by 'id' or
#' # 'characteristic'
#' datalist <- allphenotypes()
#' names(datalist) # get list of all characteristics you can call
#' datalist[["ADHD"]] # get data.frame for 'ADHD'
#' datalist[c("mouth size", "SAT Writing")] # get data.frame for 'ADHD'
#' }
allphenotypes <- function(df = FALSE, ...) {
  tryCatch(
    {
      out <- os_GET(paste0(osnp_base(), "phenotypes.json"), list(), ...)
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

  out <- jsonlite::fromJSON(out, simplifyVector = FALSE)
  if (df) {
    ldply(out, function(x) {
      data.frame(do.call(cbind, x),
        stringsAsFactors = FALSE
      )
    })
  } else {
    temp <- lapply(out, function(x) {
      data.frame(do.call(cbind, x),
        stringsAsFactors = FALSE
      )
    })
    cs <- str_trim(
      str_replace_all(
        sapply(out, function(x) x$characteristic), "\\(|\\)", ""
      ),
      side = "both"
    )
    names(temp) <- cs
    temp
  }
}
