#' Get genotype data for one or multiple users.
#'
#' @export
#' @param snp SNP name.
#' @param userid ID of openSNP user.
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return List (or data.frame) of genotypes for specified user(s) at a 
#' certain SNP.
#' @examples \dontrun{
#' genotypes(snp='rs9939609', userid=1)
#' genotypes('rs9939609', userid='1,6,8', df=TRUE)
#' genotypes('rs9939609', userid='1-2', df=FALSE)
#' }

genotypes <- function(snp = NA, userid = NA, df = FALSE, ...) {
  url2 <- paste0(paste0(osnp_base(), "snps/json/"), snp, "/", userid, '.json')
  message(url2)
  res <- GET(url2, ...)
  stop_for_status(res)
  genotypes_ <- jsonlite::fromJSON(cuf8(res), FALSE)

  if (df) {
    if (length(str_split(userid, '[-,]')[[1]]) == 1) { 
      genotypes_ 
    } else{
      getdfseven <- function(x) {
        if (length(unlist(x)) == 7) t(data.frame(unlist(x), 
                                                 stringsAsFactors = FALSE))
      }
      df <- ldply(genotypes_, getdfseven)
      names(df) <- c("snp_name","snp_chromosome","snp_position","user_name",
                     "user_id","genotype_id","genotype")
      return( df )
    }
  } else { 
    genotypes_ 
  }
}
