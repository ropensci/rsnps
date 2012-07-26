#' Get genotype data for all users at a particular snp.
#'
#' @import RJSONIO plyr
#' @param snp SNP name. 
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param url Base URL for API method; leave unchanged.
#' @return List of genotypes for all users at a certain SNP, or data.frame
#' @export 
#' @examples \dontrun{
#' allgensnp('rs7412')
#' allgensnp('rs7412', df=TRUE)
#' }
allgensnp <- function(snp = NA, df = FALSE, url = "http://opensnp.org/snps/") 
{
	message(paste(url, snp, '.json', sep=''))
  out <- fromJSON(paste(url, snp, '.json', sep=''))
  if(df == TRUE)
    {
     df <- ldply(out, function(x) t(data.frame(unlist(x))))
     names(df) <- c("snp_name","snp_chromosome","snp_position","user_name",
                    "user_id","genotype_id","genotype")
     df
    } else
    {out}
}