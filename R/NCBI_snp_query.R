#' Query NCBI's dbSNP for information on a set of SNPs
#'
#' This function queries NCBI's dbSNP for information related to the latest
#' dbSNP build and latest reference genome for information on the vector
#' of SNPs submitted.
#' 
#' This function currently pulling data for Assembly 38 - in particular
#' note that if you think the BP position is wrong, that you may be 
#' hoping for the BP position for a different Assembly. With ENTREZ
#' we cannot specify which assembly to pull data from, so it's stuck 
#' with 38.
#'
#' @export
#' @param SNPs (character) A vector of SNPs (rs numbers).
#' @param key (character) NCBI Entrez API key. optional. 
#' See "NCBI Authentication" in [rsnps-package]
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return A dataframe with columns:
#' 
#' - Query: The rs ID that was queried.
#' - Chromosome: The chromosome that the marker lies on.
#' - Marker: The name of the marker. If the rs ID queried
#' has been merged, the up-to-date name of the marker is returned here, and
#' a warning is issued.
#' - Class: The marker's 'class'. See
#' <http://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass>
#' for more details.
#' - Gene: If the marker lies within a gene (either within the exon
#' or introns of a gene), the name of that gene is returned here; otherwise,
#' `NA`. Note that
#' the gene may not be returned if the marker lies too far upstream or downstream
#' of the particular gene of interest.
#' - Alleles: The alleles associated with the SNP if it is a
#' SNV; otherwise, if it is an INDEL, microsatellite, or other kind of
#' polymorphism the relevant information will be available here.
#' - Minor: The allele for which the MAF is computed,
#' given it is an SNV; otherwise, `NA`.
#' - MAF: The minor allele frequency of the SNP, given it is an SNV.
#' This is drawn from the current global reference population used by NCBI (GnomAD).
#' - BP: The chromosomal position, in base pairs, of the marker,
#' as aligned with the current genome used by dbSNP. we add 1 to the base 
#' pair position in the BP column in the output data.frame to agree with 
#' what the dbSNP website has.
#' - AncestralAllele: 
#' - VariationAllele: 
#' 
#' @seealso [ncbi_snp_query2()]
#' 
#' @references <https://www.ncbi.nlm.nih.gov/projects/SNP/>
#' 
#' @details Note that you are limited in the number of SNPs you pass in to one 
#' request because URLs can only be so long. Around 600 is likely the max you 
#' can pass in, though may be somewhat more. Break up your vector of SNP 
#' codes into pieces of 600 or less and do repeated requests to get all data.
#' 
#' @examples \dontrun{
#' ## an example with both merged SNPs, non-SNV SNPs, regular SNPs,
#' ## SNPs not found, microsatellite
#' SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' ncbi_snp_query(SNPs)
#' # ncbi_snp_query("123456") ##invalid: must prefix with 'rs'
#' ncbi_snp_query("rs420358")
#' ncbi_snp_query("rs332") # warning that its merged into another, try that
#' ncbi_snp_query("rs121909001")
#' ncbi_snp_query("rs1837253")
#' ncbi_snp_query("rs1209415715")
#' ncbi_snp_query("rs111068718") 
#' ncbi_snp_query(SNPs='rs9970807')
#'
#' # Curl debugging
#' ncbi_snp_query("rs121909001")
#' ncbi_snp_query("rs121909001", verbose = TRUE)
#' }
ncbi_snp_query <- function(SNPs, key = NULL, ...) {
  ## ensure these are rs numbers of the form rs[0-9]+
  tmp <- sapply( SNPs, function(x) { grep( "^rs[0-9]+$", x) } )
  if (any(sapply( tmp, length ) == 0)) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358", call. = FALSE)
  }

  ## transform all SNPs into numbers (rsid)
  SNPs_num <- gsub("rs", "", SNPs)
  url <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi"
  
  cli <- crul::HttpClient$new(url = url, opts = list(...))
  key <- check_key(key %||% "")
  res <- cli$get(query = rsnps_comp(list(db = 'snp', 
                                         id = paste( SNPs_num, collapse = ","), version = "2.0")), api_key = key)
  res$raise_for_status()
  xml <- res$parse("UTF-8")

  xml_parsed <- XML::xmlInternalTreeParse(xml)
  xml_list_ <- XML::xmlToList(xml_parsed, simplify = TRUE) 

  x2 <- xml2::read_xml(xml)
  xml2::xml_ns_strip(x2)
  x2kids <- xml2::xml_children(x2)

  ## we don't need the first and last element; it's just metadata (DbBuild + .attrs OK)
  xml_list <- xml_list_[-c(1,length(xml_list_))]  

  ## Check which rs numbers were found, and warn if one was not found
  ## one thing that makes our life difficult: there can be multiple
  ## XML entries with the same name. make sure we go through all of them
  found_snps <- unname(unlist(sapply(xml_list, function(x) {
    ## check if the SNP is either in the current rsId, or the merged SNP list
    attr_rsIds <- tryget(x$SNP_ID)
    
    merged <-  tryget(x$TEXT)
    
    if (!is.null(merged)) {
      merge_rsIds <- attr_rsIds
      attr_rsIds <- tryget(x$.attrs["uid"])
    } else {
      merge_rsIds <- NULL
    }
    
    possible_names <- c(attr_rsIds, merge_rsIds)
    return(possible_names)
    
  })))

  found_snps <- found_snps[ !is.na(found_snps) ]
  found_snps <- paste(sep = '', "rs", found_snps)

  if (any(!(SNPs %in% found_snps))) {
    warning("The following rsIds had no information available on NCBI:\n  ",
            paste( SNPs[ !(SNPs %in% found_snps) ], collapse = ", "),
            call. = FALSE)
  }
  SNPs <- SNPs[ SNPs %in% found_snps ]

  out <- as.data.frame(matrix(0, nrow = length(SNPs), ncol = 11))
  names(out) <- c("Query", "Chromosome", "BP", "Marker", "Class", "Gene", "Alleles",
    "Minor", "MAF", "AncestralAllele", "VariationAllele")

  for (i in seq_along(SNPs)) {
    my_list <- xml_list[[i]]
    my_chr <- tryget(my_list$CHR)
    if (is.null(my_chr)) {
      my_chr <- NA
      warning("No chromosomal information for ", SNPs[i], "; may be unmapped", 
              call. = FALSE)
    }
    my_snp <- tryget( my_list$SNP_ID)
   # my_snp_query <- tryget( my_list$.attrs["uid"] ) ## this is the queried SNP
    if ( !is.na(my_snp) ) {
      my_snp <- paste(sep = '', "rs", my_snp)
    }
    if (my_snp != SNPs[i] ) {
      warning(SNPs[i], " has been merged into ", my_snp, call. = FALSE)
    }
    my_snpClass <- tryget(my_list$SNP_CLASS)
    #my_fxnClass <- tryget(my_list$FXN_CLASS)
    
   # my_gene <- xml2::xml_attr(
  #    xml2::xml_find_first(x2kids[[i]], "Assembly//Component/MapLoc/FxnSet"),
   #   "symbol"
    #)
    my_gene <- tryget(
      sapply(my_list$GENES, function(x) x$NAME)
    )
    if (is.null(my_gene)) my_gene <- NA
    
    
    # don't really know whats in $SS, but $DOCSUM contains the alleles  
    # #ALLELE contains...
    # alleles <- my_list$SS$Sequence$Observed
    meta_info_ <- tryget(my_list$DOCSUM) 
    ## pull out what is after SEQ and remove SEQ=[ and ]
    meta_info <- strsplit(meta_info_, "|", fixed=TRUE)[[1]][2]
    alleles_ordered <- gsub("\\]", "", gsub("SEQ=\\[", "", meta_info))
    
    alleles <- strsplit(alleles_ordered, "/")[[1]]
    ancestral_allele <- alleles[1]
    variation_allele <- paste(alleles[-1], collapse = ",")
    ## todo, cases of more than one alternate allele
    
    ## handle true SNPs
    if (my_snpClass %in% c("snp", "snv", "delins", "indel", "del") & any(my_list$GLOBAL_MAFS != "\n\t")) {
   
      ## pull out MAF, and the allele that its computed for. 
      maf_df_ <- do.call("rbind", lapply(my_list$GLOBAL_MAFS, function(x) cbind(x$STUDY, x$FREQ)))
      maf_df_2 <- do.call("rbind", strsplit(maf_df_[,2], "=|/"))
      maf_df <- data.frame(cbind(maf_df_, maf_df_2))
      names(maf_df) <- c("source", "info", "allele", "freq", "n")
      maf_df$source <- as.character( maf_df$source)
      maf_df$info <- as.character( maf_df$info)
      maf_df$allele <- as.character(maf_df$allele)
      maf_df$freq <- as.numeric(as.character(maf_df$freq))
      
      ## for specific source
      maf_df_sub <- maf_df[maf_df$source == "GnomAD", ]
      my_minor <- maf_df_sub$allele
      my_freq <- maf_df_sub$freq
    } else { 
      ## handle the others in a generic way; maybe specialize later
      my_minor <- NA
      my_major <- NA
      my_freq <- NA
    }

    ## pos on most recent build (hg38)
    my_pos <- tryget(my_list$CHRPOS)
    my_pos <- strsplit(my_pos, ":")[[1]][2]
    
    # my_pos <- tryCatch(
    #   my_list$Assembly$Component$MapLoc$.attrs["physMapInt"],
    #   error = function(e) {
    #     my_list$Assembly$Component$MapLoc["physMapInt"]
    #   }
    # )
    
    if (is.null(my_pos)) my_pos <- NA
    
    # Based one NCBI's response, the position data in their XML API output 
    # should be off by one when compared to web display. So we add one here
    # to make them equivalent 
    #if (is.numeric(my_pos)) my_pos <- my_pos + 1
    #my_pos <- as.integer(my_pos) #+ 1
    
    # Ancestral Allele
    anc_all <- ancestral_allele
#    anc_all <- my_list$Sequence$.attrs['ancestralAllele']
    anc_all <- if (is.na(anc_all)) NA else anc_all[[1]]

    out[i, ] <- c(
      SNPs[i], my_chr, as.integer(my_pos), my_snp, unname(my_snpClass),
      paste0(unname(my_gene), collapse = "/"), paste0(unname(alleles), collapse = ","), 
      unname(my_minor),
      as.numeric(my_freq), 
      anc_all, 
      variation_allele
    )
  }

  for (nm in c("MAF", "BP")) {
    out[, nm] <- as.numeric( out[, nm] )
  }
  
  
  ## NCBI limits to a maximum of 1 query per three seconds; we
  ## ensure that this limit is adhered to
  Sys.sleep(3)

  return(out)

}
