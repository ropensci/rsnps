#' Query NCBI's dbSNP for information on a set of SNPs
#' 
#' 
#' @export
#' @param SNPs A vector of SNPs (rs numbers).
#' @param ... Further named parameters passed on to 
#' \code{\link[httr]{config}} to debug curl.
#' 
#' @note \code{ncbi_snp_query2} is a synonym of \code{NCBI_snp_query2} - we'll 
#' make \code{NCBI_snp_query2} defunct in the next version
#' 
#' @seealso \code{\link{ncbi_snp_query}}
#' 
#' @examples \dontrun{
#' SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' ncbi_snp_query2(SNPs)
#' # ncbi_snp_query2("123456") ## invalid: must prefix with 'rs'
#' ncbi_snp_query2("rs420358")
#' ncbi_snp_query2("rs332") # warning, merged into new one
#' ncbi_snp_query2("rs121909001") 
#' ncbi_snp_query2("rs1837253")
#' ncbi_snp_query2("rs1209415715") # no data available
#' ncbi_snp_query2("rs111068718") # chromosomal information may be unmapped
#' }

NCBI_snp_query2 <- function(SNPs, ...) {
  if (grepl("NCBI", deparse(sys.call()))) {
    .Deprecated("ncbi_snp_query2", package = "rsnps", 
      "use ncbi_snp_query2 instead - NCBI_snp_query2 removed in next version")
  }
  
  tmp <- sapply( SNPs, function(x) { 
    grep( "^rs[0-9]+$", x) 
  })
  if ( any( sapply( tmp, length ) == 0 ) ) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358")
  }
  url <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
  res <- GET(url, query = list(db = 'snp', retmode = 'flt', rettype = 'flt', 
                               id = paste( SNPs, collapse = ",")), ...)
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
  return( structure(list(summary = dfs, data = dat), class = "dbsnp") )
  Sys.sleep(0.33)
}

#' @export
#' @rdname NCBI_snp_query2
ncbi_snp_query2 <- NCBI_snp_query2

#' @export
print.dbsnp <- function(x, ...) {
  cat("<dbsnp>", sep = "\n")
  cat(sprintf("   SNPs: %s", paste0(names(x), collapse = ", ")), sep = "\n")
  cat("   Summary:", sep = "\n")
  print(x$summary)
}

rn <- function(x) {
  if (is.null(x)) {
    NA
  } else {
    x
  }
}

parse_data <- function(x) {
  bits <- strsplit(x, "\n")[[1]]
  rs <- pull_vars(rs_vars, "rs", bits)
  ss <- pull_vars(ss_vars, "ss", bits, multi = TRUE)
  snp <- pull_vars(var_set = SNP_vars, line_start = "SNP", line = bits)
  clinsig <- pull_vars(CLINSIG_vars, "CLINSIG", bits)
  gmaf <- pull_vars(GMAF_vars, "GMAF", bits)
  ctg <- pull_vars(CTG_vars, "CTG", bits, TRUE)
  loc <- pull_vars(LOC_vars, "LOC", bits, TRUE)
  seq <- pull_vars(SEQ_vars, "SEQ", bits, TRUE)
  list(rs = rs, ss = ss, snp = snp, clinsig = clinsig, gmaf = gmaf, 
       ctg = ctg, loc = loc, seq = seq)
}

pull_line <- function(var_set, x) {
  line_set <- list()
  for (j in seq_along(var_set)) {
    if (inherits(var_set[[j]], "numeric")) {
      line_set[[ names(var_set[j]) ]] <- strtrim(x[ var_set[[j]] ])
    } else if (inherits(var_set[[j]], "character")) {
      line_set[[ names(var_set[j]) ]] <- strtrim(sub(
        var_set[[j]], "", grep(var_set[[j]], x, value = TRUE)))
    }
  }
  line_set[vapply(line_set, length, numeric(1)) == 0] <- NULL
  return(line_set)
}

pull_vars <- function(var_set, line_start, line, multi = FALSE) {
  lineset <- strsplit(line[grep(line_start, substring(line, 0, 4))], "\\|")
  if (length(lineset) == 0) {
    NULL
  } else {
    if (multi) {
      pulled_vars <- list()
      for (i in seq_along(lineset)) {
        pulled_vars[[i]] <- pull_line(var_set, lineset[[i]])
      }
      if (length(pulled_vars) == 1) {
        pulled_vars[[1]]
      } else {
        pulled_vars
      }
    } else {
      line <- lineset[[1]]
      pull_line(var_set, line)
    }
  }
}

rs_vars <- list("snp" = 1,
                "organism" = 2,
                "taxId" = 3,
                "snpClass" = 4,
                "genotype" = "genotype=",
                "rsLinkout" = "submitterlink=",
                "date" = "updated ")

ss_vars <- list("ssId" = 1,
                "handle" = 2,
                "locSnpId" = 3,
                "orient" = "orient=",
                "exemplar" = "ss_pick=")

SNP_vars <- list("observed" = "alleles=",
                 "value" = "het=",
                 "stdError" = "se\\(het\\)=",
                 "validated" = "validated=",
                 "validProbMin" = "min_prob=",
                 "validProbMax" = "max_prob=",
                 "validation" = "suspect=",
                 "AlleleOrigin_unknown" = 'unknown',
                 "AlleleOrigin_germline" = 'germline',
                 "AlleleOrigin_somatic" = 'somatic',
                 "AlleleOrigin_inherited" = 'inherited',
                 "AlleleOrigin_paternal" = 'paternal',
                 "AlleleOrigin_maternal" = 'maternal',
                 "AlleleOrigin_de-novo" = 'de-novo',
                 "AlleleOrigin_bipaternal" = 'bipaternal',
                 "AlleleOrigin_unipaternal" = 'unipaternal',
                 "AlleleOrigin_not-tested" = 'not-tested',
                 "AlleleOrigin_tested-inconclusive" = 'tested-inconclusive',
                 "snpType_notwithdrawn" = 'notwithdrawn',
                 "snpType_artifact" = 'artifact',
                 "snpType_gene-duplication" = 'gene-duplication',
                 "snpType_duplicate-submission" = 'duplicate-submission',
                 "snpType_notspecified" = 'notspecified',
                 "snpType_ambiguous-location" = 'ambiguous-location',
                 "snpType_low-map-quality" = 'low-map-quality')

CLINSIG_vars <- list(
  "ClinicalSignificance" = 'probable-pathogenic',
  "ClinicalSignificance" = 'pathogenic',
  "ClinicalSignificance" = 'other'
)

GMAF_vars = list("allele" = "allele=",
                 "sampleSize" = "count=",
                 "freq" = "MAF=")

CTG_vars <- list("groupLabel" = "assembly=",
                 "chromosome" = "chr=",
                 "physmapInt" = "chr-pos=",
                 "asnFrom" = "ctg-start=",
                 "asnTo" = "ctg-end=",
                 "loctype" = "loctype=",
                 "orient" = "orient=")

LOC_vars <- list("symbol" = 2,
                 "geneId" = "locus_id=",
                 "fxnClass" = "fxn-class=",
                 "allele" = "allele=",
                 "readingFrame" = "frame=",
                 "residue" = "residue=",
                 "aaPosition" = "aa_position=",
                 "mrna_acc" = "mrna_acc=")

SEQ_vars <- list("gi" = 1,
                 "source" = "source-db=",
                 "asnFrom" = "seq-pos=",
                 "orient" = "orient=")
