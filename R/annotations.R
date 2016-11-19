#' Get all phenotypes, their variations, and how many users have data
#' 		available for a given phenotype.
#'
#' Either return data.frame with all results, or output a list, then call
#' 		the charicteristic by id (paramater = "id") or 
#' 		name (paramater = "characteristic").
#'
#' @export
#' @param snp SNP name.
#' @param output Name the source or sources you want annotations from (options
#' 		are: 'plos', 'mendeley', 'snpedia', 'metadata'). 'metadata' gives the
#' 		metadata for the response.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return Data.frame of results.
#' @examples \dontrun{
#' # Get all data
#' ## get just the metadata
#' annotations(snp = 'rs7903146', output = 'metadata')
#' 
#' ## just from plos
#' annotations(snp = 'rs7903146', output = 'plos') 
#' 
#' ## just from snpedia
#' annotations(snp = 'rs7903146', output = 'snpedia')
#' 
#' ## get all annotations
#' annotations(snp = 'rs7903146', output = 'all') 
#' }
annotations <- function(snp = NA, 
  output = c('all','plos','mendeley','snpedia','metadata'), ...) {
  
  url <- paste0(osnp_base(), "snps/json/annotation/", snp, '.json')
  message(url)
  res <- httr::GET(url, ...)
  httr::stop_for_status(res)
  out <- jsonlite::fromJSON(cuf8(res), FALSE)
  source_ <- match.arg(output, c('all','plos','mendeley','snpedia','metadata'), 
                       FALSE)

  if (source_ == 'metadata') {
    ldply(out$snp[c('name','chromosome','position')])
  } else
    if (source_ == 'all') {
      # replace NULL with "none" so that coercing to data.frame will work
      ss <- function(x) { ifelse(is.null(x), "none", x) }
      out <- llply(out$snp$annotations, function(x) llply(x, function(y) 
        llply(y, ss)))

      ldply(out, function(x) ldply(x, data.frame, stringsAsFactors = FALSE))
    } else {
      out2 <- out$snp$annotations[[source_]] # Get part of list for given source_

      # replace NULL with "none" so that coercing to data.frame will work
      ss <- function(x) { ifelse(is.null(x), "none", x) }
      out2 <- llply(out2, function(x) llply(x, ss))

      # Get data.frame
      ldply(out2, data.frame, stringsAsFactors = FALSE)
    }
}
