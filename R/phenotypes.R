#' Get phenotype data for one or multiple users.
#'
#' @import RJSONIO
#' @param userid ID of openSNP user. 
#' @param url Base URL for API method; leave unchanged. 
#' @return List of phenotypes for specified user(s).
#' @export 
#' @examples \dontrun{
#' phenotypes(userid=1)
#' phenotypes(userid='1,6,8')
#' phenotypes(userid='1-8')
#' }
phenotypes <- function(userid = NA, url = "http://opensnp.org/phenotypes/json/") 
{
  url2 <- paste(url, userid, '.json', sep='')
  fromJSON(url2)
}
# http://opensnp.org/phenotypes/json/$userid.json
# http://opensnp.org/phenotypes/json/1.json