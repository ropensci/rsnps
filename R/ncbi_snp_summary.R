#' Query NCBI's dbSNP for summary information on a set of SNPs
#' 
#' @export
#' @param x A vector of SNPs (with or without 'rs' prefix)
#' @param key (character) NCBI Entrez API key. optional. 
#' See "NCBI Authenication" in [rsnps-package]
#' @param ... Curl options passed on to [crul::HttpClient]
#' @seealso [ncbi_snp_query2()]
#' @examples \dontrun{
#' # use with 'rs' or without it
#' ncbi_snp_summary("rs420358")
#' ncbi_snp_summary("420358")
#' 
#' # you can pass > 1
#' x <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' ncbi_snp_summary(x)
#' 
#' ncbi_snp_summary("rs420358")
#' ncbi_snp_summary("rs332") # warning, merged into new one
#' ncbi_snp_summary("rs121909001") 
#' ncbi_snp_summary("rs1837253")
#' ncbi_snp_summary("rs1209415715") # no data available
#' ncbi_snp_summary("rs111068718") # chromosomal information may be unmapped
#' }
ncbi_snp_summary <- function(x, key = NULL, ...) {
  stopifnot(inherits(x, "character"))
  x <- gsub("^rs", "", x)
  key <- check_key(key %||% "")
  args <- rsnps_comp(list(db = 'snp', retmode = 'flt', rettype = 'flt',
    id = paste(x, collapse = ","), api_key = key))
  url <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
  cli <- crul::HttpClient$new(url = url, opts = list(...))
  res <- cli$get(query = args)
  res$raise_for_status()
  tmp <- res$parse("UTF-8")
  xml <- xml2::read_xml(tmp)
  docsums <- xml2::xml_find_all(xml, "//DocSum")
  dats <- lapply(docsums, function(w) {
    items <- xml2::xml_find_all(w, "Item")
    unlist(lapply(items, make_named_list), FALSE)
  })
  dats <- lapply(dats, function(z) {
    gn <- stract_(z$docsum, "GENE=[A-Za-z0-9]+:[0-9]+,?([A-Za-z0-9]+:[0-9]+)?")
    gn <- sub("GENE=", "", gn)
    z$gene2 <- gn %||% NA_character_
    z
  })
  rbl(dats)
}

make_named_list <- function(x) {
  as.list(stats::setNames(xml2::xml_text(x), 
    tolower(xml2::xml_attr(x, "Name"))))
}

check_key <- function(key = "") {
  stopifnot(is.character(key))
  if (nzchar(key)) return(key)
  key <- Sys.getenv("ENTREZ_KEY")
  if (!nzchar(key)) NULL else key
}
