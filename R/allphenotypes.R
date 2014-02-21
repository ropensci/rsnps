#' Get all phenotypes, their variations, and how many users have data 
#' 		available for a given phenotype.
#' 	
#' Either return data.frame with all results, or output a list, then call 
#' 		the charicteristic by id (paramater = "id") or name (paramater = "characteristic").
#'
#' @import httr plyr stringr
#' @param df Return a data.frame of all data. The column known_variations 
#' 		can take multiple values, so the other columns id, characteristic, and 
#' 		number_of_users are replicated in the data.frame. (default = FALSE)
#' @return Data.frame of results, or list if df=FALSE
#' @export 
#' @examples \dontrun{
#' # Get all data
#' allphenotypes(df = TRUE)
#' 
#' # Output a list, then call the characterisitc of interest by 'id' or 'characteristic'
#' datalist <- allphenotypes()
#' names(datalist) # get list of all characteristics you can call
#' datalist[["ADHD"]] # get data.frame for 'ADHD'
#' datalist[c("mouth size","SAT Writing")] # get data.frame for 'ADHD' 
#' }

allphenotypes <- function(df = FALSE) 
{
  url = "http://opensnp.org/phenotypes.json"
  res <- GET(url)
  stop_for_status(res)
  out <- content(res)
  if(df == TRUE){
    ldply(out, function(x) data.frame(do.call(cbind, x), stringsAsFactors = FALSE))
  } else
  {
    myfunc <- function(x) str_replace_all(x, "\\(|\\)", "")
    out <- llply(out, function(y) llply(y, myfunc))
    temp <- llply(out, function(x) data.frame(do.call(cbind, x), stringsAsFactors = FALSE))
    cs <- str_replace_all(sapply(out, function(x) x$characteristic), '\\(|\\)', '')
    names(temp) <- cs
    temp
  }
}