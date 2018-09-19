#' Get openSNP genotype data for all users at a particular snp.
#'
#' @export
#' @family opensnp-fxns
#' @param snp (character) A SNP name
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return data.frame of genotypes for all users at a certain SNP
#' @examples \dontrun{
#' x <- allgensnp(snp = 'rs7412')
#' head(x)
#' }
allgensnp <- function(snp = NA, ...) {
  url2 <- paste(osnp_base(), "snps/", snp, '.json', sep = '')
  out <- os_GET(url2, list(), ...)
  tt <- jsonlite::fromJSON(out, FALSE)
  rbl(lapply(tt, function(z) {
    snp = data.frame(z$snp, stringsAsFactors = FALSE)
    us_er <- z$user
    us_er$genotypes <- NULL
    us_er <- c(us_er, unlist(z$user$genotypes, FALSE))
    user = data.frame(us_er, stringsAsFactors = FALSE)
    cbind(snp, us_er)
  }))
}

os_GET <- function(url, args, ...) {
  cli <- crul::HttpClient$new(url = url, opts = list(...))
  res <- cli$get(query = args)
  res$raise_for_status()
  res$parse("UTF-8")
}
