#' Search for SNPs in Linkage Disequilibrium with a set of SNPs
#'
#' This function queries the SNP Annotation and Proxy tool (SNAP) for SNPs
#' in high linkage disequilibrium with a set of SNPs, and also merges in
#' up-to-date SNP annotation information available from NCBI.
#'
#' For more details, please see
#' \url{http://archive.broadinstitute.org/mpg/snap/ldsearch.php}.
#'
#' Information on the HapMap populations:
#' \url{https://catalog.coriell.org/0/Sections/Collections/NHGRI/hapmap.aspx?PgId=266&coll=HG}
#'
#' Information on the 1000 Genomes populations:
#' \url{http://www.internationalgenome.org/category/population}
#'
#' @note \code{ld_search} is a synonym of \code{LDSearch} - we'll make
#' \code{LDSearch} defunct in the next version
#'
#' @export
#' @param SNPs A vector of SNPs (rs numbers).
#' @param dataset The dataset to query. Must be one of: \itemize{
#'   \item{\code{rel21: }}{HapMap Release 21}
#'   \item{\code{rel22: }}{HapMap Release 22}
#'   \item{\code{hapmap3r2: }}{HapMap 3 (release 2)}
#'   \item{\code{onekgpilot: }}{1000 Genomes Pilot 1}
#'   }
#' @param panel The panel to use from the queried data set.
#' Must be one of: \itemize{
#'  \item{\code{CEU}}
#'  \item{\code{YRI}}
#'  \item{\code{JPT+CHB}}
#'  }
#' If you are working with \code{hapmap3r2}, you can choose
#' the additional panels: \itemize{
#'  \item{\code{ASW}}
#'  \item{\code{CHD}}
#'  \item{\code{GIH}}
#'  \item{\code{LWK}}
#'  \item{\code{MEK}}
#'  \item{\code{MKK}}
#'  \item{\code{TSI}}
#'  \item{\code{CEU+TSI}}
#'  \item{\code{JPT+CHB+CHD}}
#'  }
#' @param RSquaredLimit The R Squared limit to specify as a filter for returned
#' SNPs; that is, only SNP pairs with R-squared greater than \code{RSquaredLimit}
#' will be returned.
#' @param distanceLimit The distance (in kilobases) upstream and downstream
#' to search for SNPs in LD with each set of SNPs.
#' @param GeneCruiser boolean; if \code{TRUE} we attempt to get gene info through
#' GeneCruiser for each SNP. This can slow the query down substantially.
#' @param quiet boolean; if \code{TRUE} progress updates are written to the
#' console.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return A list of data frames, one for each SNP queried, containing
#' information about the SNPs found to be in LD with that SNP. A description
#' of the columns follows:
#' \itemize{
#' \item{\code{Proxy:} The proxy SNP matched to the queried SNP.}
#' \item{\code{SNP:} The SNP queried.}
#' \item{\code{Distance:} The distance, in base pairs, between the queried SNP
#' and the proxy SNP. This distance is calculated according to up-to-date position
#' information returned from NCBI.}
#' \item{\code{RSquared:} The measure of LD between the SNP and the proxy.}
#' \item{\code{DPrime:} Another measure of LD between the SNP and the proxy.}
#' \item{\code{GeneVariant:} Present if \code{GeneCruiser} is \code{TRUE}.
#' This will identify where the SNP lies relative to its 'parent' SNP.}
#' \item{\code{GeneName:} Present if \code{GeneCruiser} is \code{TRUE}.
#' If the proxy SNP found lies within a gene, the name of that
#' gene will be returned here. Otherwise, the field is \code{N/A}.}
#' \item{\code{GeneDescription:} Present if \code{GeneCruiser} is \code{TRUE}. If
#' the proxy SNP lies within a gene, information about that gene (as
#' obtained from GeneCruiser) will be available here.}
#' \item \code{Major:} The major allele, as reported by SNAP.
#' \item \code{Minor:} The minor allele, as reported by SNAP.
#' \item{\code{MAF:} The minor allele frequency corresponding to the reference
#' panel queried, as obtained through SNAP.}
#' \item{\code{NObserved:} The number of individuals from which the MAF
#' information is generated, for column \code{MAF}.}
#' \item \code{Chromosome_NCBI:} The chromosome that the marker lies on.
#' \item \code{Marker_NCBI:} The name of the marker. If the rs ID queried
#' has been merged, the up-to-date name of the marker is returned here, and
#' a warning is issued.
#' \item \code{Class_NCBI:} The marker's 'class'. See
#' \url{https://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass}
#' for more details.
#' \item \code{Gene_NCBI:} If the marker lies within a gene (either within the exon
#' or introns of a gene), the name of that gene is returned here; otherwise,
#' \code{NA}. Note that
#' the gene may not be returned if the marker lies too far upstream or downstream
#' of the particular gene of interest.
#' \item \code{Alleles_NCBI:} The alleles associated with the SNP if it is a
#' SNV; otherwise, if it is an INDEL, microsatellite, or other kind of
#' polymorphism the relevant information will be available here.
#' \item \code{Major_NCBI:} The major allele of the SNP, on the forward strand,
#' given it is an SNV; otherwise, \code{NA}.
#' \item \code{Minor_NCBI:} The minor allele of the SNP, on the forward strand,
#' given it is an SNV; otherwise, \code{NA}.
#' \item \code{MAF_NCBI:} The minor allele frequency of the SNP, given it is an SNV.
#' This is drawn from the current global reference population used by NCBI.
#' \item \code{BP_NCBI:} The chromosomal position, in base pairs, of the marker,
#' as aligned with the current genome used by dbSNP.
#' }
#' @examples \dontrun{
#' ld_search("rs420358")
#' ld_search('rs2836443')
#' ld_search('rs113196607')
#' }

LDSearch <- function(SNPs,
                      dataset="onekgpilot",
                      panel="CEU",
                      RSquaredLimit=0.8,
                      distanceLimit=500,
                      GeneCruiser=TRUE,
                      quiet=FALSE, ...) {

  if (grepl("NCBI", deparse(sys.call()))) {
    .Deprecated("ld_search", package = "rsnps",
      "use ld_search instead - LDSearch removed in next version")
  }

  ## ensure these are rs numbers of the form rs[0-9]+
  tmp <- sapply( SNPs, function(x) { grep( "^rs[0-9]+$", x) } )
  if ( any( sapply( tmp, length ) == 0 ) ) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358", call. = FALSE)
  }

  ## RSquaredLimit
  if ( RSquaredLimit < 0 || RSquaredLimit > 1 ) {
    stop("RSquaredLimit must be between 0 and 1", call. = FALSE)
  }

  ## distanceLimit
  if ( is.character(distanceLimit) ) {
    n <- nchar(distanceLimit)
    stopifnot( substring( distanceLimit, n - 1, n ) == "kb" )
    distanceLimit <- as.integer( gsub("kb", "", distanceLimit) )
  }

  valid_distances <- c(0, 10, 25, 50, 100, 250, 500)
  if ( !(distanceLimit %in% valid_distances) ) {
    stop("invalid distanceLimit. distanceLimit must be one of: ",
         paste( valid_distances, collapse = ", "), call. = FALSE)
  }

  url <- "http://archive.broadinstitute.org/mpg/snap/ldsearch.php"
  columnList_query <- if (GeneCruiser) "DP,GA,MAF" else "DP,MAF"
  args <- rsnps_comp(list(snpList = paste(SNPs, collapse = ","), hapMapRelease = dataset,
      hapMapPanel = panel, RSquaredLimit = RSquaredLimit,
      distanceLimit = as.integer( distanceLimit * 1E3 ), downloadType = "file",
      includeQuerySnp = "on", submit = "search", `columnList[]` = columnList_query))

  if ( !quiet ) cat("Querying SNAP...\n")
  dat_tmp <- GET(url, query = args, ...)
  stop_for_status(dat_tmp)
  dat <- cuf8(dat_tmp)

  ## check for validation error
  if ( length( grep( "validation error", dat ) ) > 0 ) {
    stop(dat, call. = FALSE)
  }

  ## search through for missing SNPs and remove them from output
  tmp <- unlist( strsplit( dat, "\r\n", fixed = TRUE ) )
  warning_SNPs <- grep( "WARNING", tmp, value = TRUE )
  for (line in warning_SNPs ) {
    warning( line, call. = FALSE )
  }

  bad_lines <- grep( "WARNING", tmp )
  if ( length( bad_lines ) > 0 ) {
    tmp <- tmp[ -bad_lines ]
  }

  out <- split_to_df( tmp, sep = "\t", fixed = TRUE )
  names( out ) <- unlist( unclass( out[1,] ) )
  out <- out[2:nrow(out),]

  out_split <- split(out, out$SNP)
  for (i in 1:length(out_split) ) {
    rownames( out_split[[i]] ) <- 1:nrow( out_split[[i]] )
  }

  # check whether any real data or not
  if (all(unlist(out_split$SNP[1,], use.names = FALSE) %in% names(out_split$SNP)) &&
      NROW(out_split$SNP) == 1) {
    stop("no valid data found", call. = FALSE)
  }

  if ( !quiet ) {
    cat("Querying NCBI for up-to-date SNP annotation information...\n")
  }

  ## query NCBI for additional SNP information
  SNP_info <- vector("list", length(out_split))

  ## get all the proxy SNP information in one query
  proxy_SNPs <- unique( unname( unlist( sapply( out_split, "[", "Proxy" ) ) ) )
  ncbi_info <- ncbi_snp_query2(proxy_SNPs)$summary
  names(ncbi_info) <- paste(sep = '', names(ncbi_info), "_NCBI")

  ## quick function for adding NCBI info to SNPs queried
  add_ncbi_info <- function(x) {
    x$ORDER <- 1:nrow(x)
    x <- merge( x, ncbi_info,
                by.x = "Proxy", by.y = "query_NCBI",
                all.x = TRUE
    )
    x <- x[ order( x$ORDER ), ]
    x <- x[ !(names(x) %in% "ORDER") ]
    x$Distance[ x$Distance == 0 ] <- NA
    x$Distance <- x$bp_NCBI - rep( x$bp_NCBI[1], nrow(x) )
    x[ order( x$RSquared, decreasing = TRUE ), ]
  }

  out <- lapply(out_split, add_ncbi_info)

  if (!quiet ) {
    on.exit( cat("Done!\n") )
  }

  return( out )
}

#' @export
#' @rdname LDSearch
ld_search <- LDSearch
