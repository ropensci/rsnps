#' Get openSNP genotype data for all users at a particular snp.
#'
#' @export
#' @family opensnp-fxns
#' @param snp (character) A SNP name
#' @param usersubset Get a subset of users, integer numbers, e.g. 1-8 (default: none)
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return data.frame of genotypes for all users at a certain SNP
#' @examples \dontrun{
#' x <- allgensnp(snp = "rs7412")
#' head(x)
#' }
allgensnp <- function(snp = NA, usersubset = FALSE, ...) {
  ## add possibilty to get a subset of users
  
  if(!usersubset == FALSE) {
    url2 <- paste(osnp_base(), "snps/json/", snp,"/", usersubset, ".json", sep = "")
  }else{
    url2 <- paste(osnp_base(), "snps/", snp, ".json", sep = "")
  }
  out <- os_GET(url2, list(), ...)
  tt <- jsonlite::fromJSON(out, FALSE)
  rbl(lapply(tt, function(z) {
    snp <- data.frame(z$snp, stringsAsFactors = FALSE)
    us_er <- z$user
    us_er$genotypes <- NULL
    us_er <- c(us_er, unlist(z$user$genotypes, FALSE))
    user <- data.frame(us_er, stringsAsFactors = FALSE)
    ## snp data frame also has a column called "name"
    names(user)[names(user) == "name"] <- "user_name"
    cbind(snp, user)
  }))
}

os_GET <- function(url, args, ...) {
  cli <- crul::HttpClient$new(url = url, opts = list(...))
  res <- cli$get(query = args)
  res$raise_for_status()
  res$parse("UTF-8")
}
