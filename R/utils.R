#' Swap Elements in a Vector
#'
#' @param vec A character vector, or vector coercable to character.
#' @param from A vector of elements to map from.
#' @param to A vector of elements to map to.
#' @param ... Optional arguments passed to [match()]
#' @keywords internal
swap <- function( vec, from, to=names(from), ... ) {
  tmp <- to[ match( vec, from, ... ) ]
  tmp[ is.na(tmp) ] <- vec[ is.na(tmp) ]
  return( tmp )
}

#' Flip Genotypes
#'
#' Given a set of genotypes, flip them.
#' @param SNP A vector of genotypes for a particular locus.
#' @param sep The separator between each allele.
#' @param outSep The output separator to use.
#' @keywords internal
flip <- function( SNP, sep="", outSep=sep ) {

  base1 <- c("A","C","G","T")
  base2 <- c("T","G","C","A")

  from <- do.call(
    function(...) { paste(..., sep=sep) },
    expand.grid(
      base1, base1
    ) )

  to <- do.call( function(...) { paste(..., sep=outSep) }, expand.grid(
    base2, base2
  ) )

  return( swap( SNP, from, to ) )

}

#' Split a Vector of Strings Following a Regular Structure
#'
#' This function takes a vector of strings following a regular
#' structure, and converts that vector into a `data.frame`, split
#' on that delimiter. A nice wrapper to [strsplit()], essentially
#' - the primary bonus is the automatic coersion to a `data.frame`.
#' @param x a vector of strings.
#' @param sep the delimiter / [regex] you wish to split your strings on.
#' @param fixed logical. If `TRUE`, we match `sep` exactly;
#' otherwise, we use regular expressions. Has priority over \code{perl}.
#' @param perl logical. Should perl-compatible regexps be used?
#' @param useBytes logical. If `TRUE`, matching is done byte-by-byte rather than
#' character-by-character.
#' @param names optional: a vector of names to pass to the returned `data.frame`.
#' @seealso [strsplit()]
#' @keywords internal
split_to_df <- function(x, sep, fixed=FALSE, perl=TRUE, useBytes=FALSE, names=NULL) {

  x <- as.character(x)

  if( fixed ) {
    perl <- FALSE
  }

  tmp <- strsplit( x, sep, fixed=fixed, perl=perl, useBytes=useBytes )
  if( length( unique( unlist( lapply( tmp, length ) ) ) ) > 1 ) {
    stop("non-equal lengths for each entry of x post-splitting")
  }
  tmp <- unlist( tmp )
  tmp <- as.data.frame(
    matrix( tmp, ncol = (length(tmp) / length(x)), byrow=TRUE ),
    stringsAsFactors=FALSE, optional=TRUE
  )

  if( !is.null(names) ) {
    names(tmp) <- names
  } else {
    names(tmp) <- paste( "V", 1:ncol(tmp), sep="" )
  }

  return(tmp)
}

#' Tryget
#'
#' @export
#' @keywords internal
tryget <- function(x) {
  return( tryCatch( return(x), error = function(e) return(NA) ) )
}

strtrim <- function(str) {
  gsub("^\\s+|\\s+$", "", str)
}

rsnps_comp <- function(x) Filter(Negate(is.null), x)

osnp_base <- function() "https://opensnp.org/"

stract_ <- function(string, pattern) {
  regmatches(string, regexpr(pattern, string))
}

rbl <- function(x) {
  (xxxxx <- data.table::setDF(
    data.table::rbindlist(x, use.names = TRUE, fill = TRUE)
  ))
}

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0) y else x

#' For use with usethis::use_release_issue()
#'
release_bullets <- function() {
  c(
    "Update vignette by running `vignettes/precompile.R`.",
    "update codemeta.json using `codemetar::write_codemeta('.')` (from within project folder on dev branch)",
    "Tag release",
    "Bump dev version"
  )
}
