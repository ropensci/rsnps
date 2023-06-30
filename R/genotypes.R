#' Get openSNP genotype data for one or multiple users.
#'
#' @export
#' @family opensnp-fxns
#' @param snp SNP name.
#' @param userid ID of openSNP user.
#' @param df Return data.frame (`TRUE`) or not (`FALSE`). Default: `FALSE`
#' @param ... Curl options passed on to [crul::HttpClient]]
#' @return List (or data.frame) of genotypes for specified user(s) at a
#' certain SNP.
#' @examples \dontrun{
#' genotypes(snp = "rs9939609", userid = 1)
#' genotypes("rs9939609", userid = "1,6,8", df = TRUE)
#' genotypes("rs9939609", userid = "1-2", df = FALSE)
#' }
genotypes <- function(snp = NA, userid = NA, df = FALSE, ...) {
  url2 <- paste0(paste0(osnp_base(), "snps/json/"), snp, "/", userid, ".json")
  
 tryCatch(
    {
      res <- os_GET(url2, list(), ...)
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
  genotypes_ <- jsonlite::fromJSON(res, FALSE)

  if (df) {
    if (length(str_split(userid, "[-,]")[[1]]) == 1) {
      genotypes_
    } else {
      getdfseven <- function(x) {
        if (length(unlist(x)) == 7) {
          t(data.frame(unlist(x),
            stringsAsFactors = FALSE
          ))
        }
      }
      df <- ldply(genotypes_, getdfseven)
      names(df) <- c(
        "snp_name", "snp_chromosome", "snp_position", "user_name",
        "user_id", "genotype_id", "genotype"
      )
      return(df)
    }
  } else {
    genotypes_
  }
}
