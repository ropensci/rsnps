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
#' genotypes(snp='rs9939609', userid=1)
#' genotypes('rs9939609', userid='1,6,8', df=TRUE)
#' genotypes('rs9939609', userid='1-2', df=FALSE)
#' }

genotypes <- function(snp = NA, userid = NA, df = FALSE, ...) {
  url2 <- paste0(paste0(osnp_base(), "snps/json/"), snp, "/", userid, '.json')
  res <- os_GET(url2, list(), ...)
  genotypes_ <- jsonlite::fromJSON(res, FALSE)

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
