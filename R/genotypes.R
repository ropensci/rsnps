#' Get genotype data for one or multiple users.
#'
#' @import RJSONIO plyr stringr
#' @param snp SNP name.
#' @param userid ID of openSNP user. 
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param url Base URL for API method; leave unchanged. 
#' @return List (or data.frame) of genotypes for specified user(s) at a certain SNP.
#' @export 
#' @examples \dontrun{
#' genotypes(snp='rs9939609', userid=1)
#' genotypes('rs9939609', userid='1,6,8', df=TRUE)
#' genotypes('rs9939609', userid='1-2', df=FALSE)
#' }
genotypes <- function(snp = NA, userid = NA, df = FALSE,
         url = "http://opensnp.org/snps/json/") 
{
  url2 <- paste(url, snp, "/", userid, '.json', sep='')
  message(url2)
  genotypes_ <- fromJSON(url2)

  if(df == TRUE)
  {
    if(length(str_split(userid, '[-,]')[[1]]) == 1){genotypes_} else{
    getdfseven <- function(x) {
      if(length(unlist(x)) == 7) t(data.frame(unlist(x)))
    }
    df <- ldply(genotypes_, getdfseven)
    names(df) <- c("snp_name","snp_chromosome","snp_position","user_name",
                  "user_id","genotype_id","genotype")
    df
    }
  } else
    {genotypes_}
}