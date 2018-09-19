#' Query NCBI's dbSNP for summary information on a set of SNPs
#' 
#' @export
#' @inheritParams ncbi_snp_query2
#' @seealso \code{\link{ncbi_snp_query2}}
#' @examples \dontrun{
#' SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' ncbi_snp_summary(SNPs)
#' # ncbi_snp_summary("123456") ## invalid: must prefix with 'rs'
#' ncbi_snp_summary("rs420358")
#' ncbi_snp_summary("rs332") # warning, merged into new one
#' ncbi_snp_summary("rs121909001") 
#' ncbi_snp_summary("rs1837253")
#' ncbi_snp_summary("rs1209415715") # no data available
#' ncbi_snp_summary("rs111068718") # chromosomal information may be unmapped
#' }
ncbi_snp_summary <- function(SNPs, ...) {
  tmp <- sapply( SNPs, function(x) { 
    grep( "^rs[0-9]+$", x) 
  })
  if ( any( sapply( tmp, length ) == 0 ) ) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358")
  }
  url <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
  res <- GET(url, query = list(db = 'snp', retmode = 'flt', rettype = 'flt', 
                               id = paste( SNPs, collapse = ",")))
  # res <- GET(url, query = list(db = 'snp', retmode = 'flt', rettype = 'flt', 
  #                              id = paste( SNPs, collapse = ",")), ...)
  stop_for_status(res)
  tmp <- cuf8(res)
  tmpsplit <- strsplit(tmp, "\n\n")[[1]]
  dat <- stats::setNames(lapply(tmpsplit, parse_data), SNPs)
  dfs <- list()
  for (i in seq_along(dat)) {
    z <- dat[[i]]
    ctg <- z$ctg
    dfs[[i]] <- data.frame(query = names(dat[i]), 
                           marker = z$rs$snp,
                           organism = rn(z$rs$organism), 
                           chromosome = rn(ctg$chromosome),
                           assembly = rn(ctg$groupLabel),
                           alleles = rn(z$snp$observed),
                           minor = rn(z$gmaf$allele),
                           maf = rn(z$gmaf$freq),
                           bp = rn(ctg$physmapInt),
                           stringsAsFactors = FALSE)
  }
  dfs <- do.call("rbind.data.frame", dfs)
  row.names(dfs) <- NULL
  dfs$bp <- as.numeric(dfs$bp)
  return(dfs)
  Sys.sleep(0.33)
}
