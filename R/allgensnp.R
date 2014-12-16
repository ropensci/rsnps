#' Get genotype data for all users at a particular snp.
#'
#' @import httr plyr
#' @param snp SNP name. 
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return List of genotypes for all users at a certain SNP, or data.frame
#' @export 
#' @examples \dontrun{
#' allgensnp(snp='rs7412')
#' allgensnp('rs7412', df=TRUE)
#' }

allgensnp <- function(snp = NA, df = FALSE, ...)
{
  url = "http://opensnp.org/snps/"
  url2 <- paste(url, snp, '.json', sep='')
  message(url2)
  res <- GET(url2, ...)
  stop_for_status(res)
  out <- content(res)
  if(df == TRUE)
  {
    df <- ldply(out, function(x) t(data.frame(unlist(x), stringsAsFactors = FALSE)))
    names(df) <- c("snp_name","snp_chromosome","snp_position","user_name",
                   "user_id","genotype_id","genotype")
    df
  } else { out }
}
