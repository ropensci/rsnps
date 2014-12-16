#' Get all phenotypes, their variations, and how many users have data 
#' 		available for a given phenotype.
#' 	
#' Either return data.frame with all results, or output a list, then call 
#' 		the charicteristic by id (paramater = "id") or name (paramater = "characteristic").
#'
#' @import httr plyr
#' @param snp SNP name.
#' @param output Name the source or sources you want annotations from (options 
#' 		are: 'plos', 'mendeley', 'snpedia', 'metadata'). 'metadata' gives the 
#' 		metadata for the response.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return Data.frame of results.
#' @examples \dontrun{
#' # Get all data
#' annotations(snp = 'rs7903146', output = 'metadata') # get just the metadata
#' annotations(snp = 'rs7903146', output = 'plos') # just from plos
#' annotations(snp = 'rs7903146', output = 'snpedia') # just from snpedia
#' annotations(snp = 'rs7903146', output = 'all') # get all annotations
#' }
#' @export 
annotations <- function(snp = NA, output = c('all','plos','mendeley','snpedia','metadata'), ...) 
{
  url = "http://opensnp.org/snps/json/annotation/"
  url2 <- paste(url, snp, '.json', sep='')
  message(url2)
  res <- GET(url2, ...)
  stop_for_status(res)
  out <- content(res)
  source_ <- match.arg(output, c('all','plos','mendeley','snpedia','metadata'), FALSE)
  
  if(source_ == 'metadata'){
    ldply(out$snp[c('name','chromosome','position')])
  } else
    if(source_ == 'all')
    {
      # replace NULL with "none" so that coercing to data.frame will work
      ss <- function(x) { ifelse(is.null(x), "none", x) }
      out <- llply(out$snp$annotations, function(x) llply(x, function(y) llply(y, ss)))
      
      ldply(out, function(x) ldply(x, data.frame, stringsAsFactors=FALSE))
    } else
    {
      out2 <- out$snp$annotations[[source_]] # Get part of list for given source_
      
      # replace NULL with "none" so that coercing to data.frame will work
      ss <- function(x) { ifelse(is.null(x), "none", x) }
      out2 <- llply(out2, function(x) llply(x, ss))
      
      # Get data.frame
      ldply(out2, data.frame, stringsAsFactors=FALSE)
    }
}
