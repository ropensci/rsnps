#' Get genotype data for one or multiple users.
#' @import RJSONIO
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @return List of openSNP users, their ID numbers, and XX if available.
#' @export 
#' @examples \dontrun{
#' genotypes(df=TRUE)
#' }
genotypes <- 
  
function(df = FALSE, url = "http://opensnp.org/snps/json/") 
{
  users_ <- fromJSON(url)
  if(df == FALSE){users_} else
  {
    lengths <- laply(users_, function(x) length(unlist(x)))
    getdffive <- function(x) {
      if(length(unlist(x)) == 5) data.frame(x)
    }
    getdftwo <- function(x) {
      if(length(unlist(x)) == 2) data.frame(x[1:2])
    }
    withlinks <- ldply(users_, getdffive)
    withoutlinks <- ldply(users_, getdftwo)
    list(withlinks, withoutlinks)
  }
}
# http://opensnp.org/snps/json/$snpname/$userid.json
# http://opensnp.org/snps/json/rs9939609/1.json