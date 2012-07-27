#' Get phenotype data for one or multiple users.
#'
#' @import RJSONIO plyr
#' @param userid ID of openSNP user. 
#' @param df Return data.frame (TRUE) or not (FALSE) - default = FALSE.
#' @param url Base URL for API method; leave unchanged. 
#' @return List of phenotypes for specified user(s).
#' @export 
#' @examples \dontrun{
#' phenotypes(userid=1)
#' phenotypes(userid='1,6,8', df=TRUE)
#' phenotypes(userid='1-8', df=TRUE)
#' 
#' # coerce to data.frame
#' library(plyr)
#' ldply(phenotypes(userid='1-8', df=TRUE))
#' }
phenotypes <- function(userid = NA, df = FALSE, 
			url = "http://opensnp.org/phenotypes/json/") 
{
  url2 <- paste(url, userid, '.json', sep='')
  message(url2)
  out <- fromJSON(url2)
  
  outdf <- list()
  if(df == TRUE)
  {
  	for(i in 1:length(out)) {
  		if( class(try(out[[i]][[2]], silent=T)) == "try-error"){
  			df <- data.frame("no data", "no data", "no data")
  			names(df) <- c("phenotype","phenotypeID","variation")
  			outdf[[paste("no info on user", i, sep="_")]] <- df
  			} else
  		{
  			if( length(out[[i]][[2]]) == 0){
  				df <- data.frame("no data", "no data", "no data")
  				names(df) <- c("phenotype","phenotypeID","variation")
  				outdf[[ out[[i]][[1]][["name"]] ]] <- df
  			} else
  				{
  					df <- ldply(out[[i]][[2]], function(x) as.data.frame(x))
  					names(df) <- c("phenotype","phenotypeID","variation")
  					outdf[[ out[[i]][[1]][["name"]] ]] <- df
  				}
  		}
  	}
  	outdf
  } else
  	{out}
}
# outdf <- list()
# x <- 1
# df <- ldply(out[[x]][[2]], function(x) as.data.frame(x))
# names(df) <- c("phenotype","phenotypeID","variation")
# outdf[["adfsd"]] <- df
# outdf[[ out[[1]][[1]][["name"]] ]] <- df