#' Get all openSNP known variations and all users sharing that phenotype for
#' one phenotype(-ID).
#'
#' @export
#' @family opensnp-fxns
#' @param phenotypeid ID of openSNP phenotype.
#' @param return_ Return data.frame (`TRUE`) or not (`FALSE`). Default: `FALSE`
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return List of description of phenotype, list of known variants, or
#' data.frame of variants for each user with that phenotype.
#'
#' @examples \dontrun{
#' phenotypes_byid(phenotypeid = 12, return_ = "desc")
#' phenotypes_byid(phenotypeid = 12, return_ = "knownvars")
#' phenotypes_byid(phenotypeid = 12, return_ = "users")
#'
#' # pass on curl options
#' phenotypes_byid(phenotypeid = 12, return_ = "desc", verbose = TRUE)
#' }
phenotypes_byid <- function(phenotypeid = NA,
                            return_ = c("description", "knownvars", "users"), ...) {
  url2 <- paste0(
    paste0(osnp_base(), "phenotypes/json/variations/"),
    phenotypeid, ".json"
  )
  res <- os_GET(url2, list(), ...)
  out <- jsonlite::fromJSON(res, FALSE)

  return_2 <- match.arg(return_, c("description", "knownvars", "users"), FALSE)

  if (return_2 == "description") {
    out[c("id", "characteristic", "description")]
  } else if (return_2 == "knownvars") {
    out[c("known_variations")]
  } else {
    ldply(out$users, data.frame, stringsAsFactors = FALSE)
  }
}
