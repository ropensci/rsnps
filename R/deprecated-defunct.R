#' This function is defunct.
#' @export
#' @rdname LDSearch-defunct
#' @keywords internal
LDSearch <- function(...) {
  .Defunct(new = "ld_search", package = "rsnps", msg = "the LDSearch() function name has been changed to ld_search()")
}

#' This function is defunct.
#' @export
#' @rdname NCBI_snp_query-defunct
#' @keywords internal
ncbi_snp_summary <- function(...) {
  .Defunct(new = "ncbi_snp_summary", package = "rsnps", msg = "the ncbi_snp_summary() function name has been changed to ncbi_snp_query()")
}


#' This function is defunct.
#' @export
#' @rdname NCBI_snp_query-defunct
#' @keywords internal
ncbi_snp_query2 <- function(...) {
  .Defunct(new = "ncbi_snp_query2", package = "rsnps", msg = "the ncbi_snp_query2() function name has been changed to ncbi_snp_query()")
}

#' This function is defunct.
#' @export
#' @rdname NCBI_snp_query-defunct
#' @keywords internal
NCBI_snp_query <- function(...) {
  .Defunct(new = "ncbi_snp_query", package = "rsnps", msg = "the NCBI_snp_query() function name has been changed to ncbi_snp_query()")
}

#' This function is defunct.
#' @export
#' @rdname NCBI_snp_query2-defunct
#' @keywords internal
NCBI_snp_query2 <- function(...) {
  .Defunct(new = "ncbi_snp_query2", package = "rsnps", msg = "the NCBI_snp_query2() function name has been changed to ncbi_snp_query()")
}

#' Defunct functions in rsnps
#'
#' - `LDSearch()`: Function name changed to [ld_search]
#' - `ld_search()`: The Broad Institute took the service down, see
#' https://www.broadinstitute.org/snap/snap
#' - `NCBI_snp_query()`: Function name changed to [ncbi_snp_query]
#' - `NCBI_snp_query2()`: Function name changed to [ncbi_snp_query]
#' - `ncbi_snp_summary()`: Function name changed to [ncbi_snp_query]
#' - `ncbi_snp_query2()`: Function name changed to [ncbi_snp_query]
#'
#' @name rsnps-defunct
NULL
