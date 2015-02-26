#' Query NCBI's dbSNP for information on a set of SNPs
#' 
#' This function queries NCBI's dbSNP for information related to the latest
#' dbSNP build and latest reference genome for information on the vector
#' of SNPs submitted.
#' 
#' @param SNPs A vector of SNPs (rs numbers).
#' @param ... Further named parameters passed on to \code{\link[httr]{config}} to debug curl.
#' See examples.
#' @export
#' @return A dataframe with columns:
#' \itemize{
#' \item \code{Query:} The rs ID that was queried.
#' \item \code{Chromosome:} The chromosome that the marker lies on.
#' \item \code{Marker:} The name of the marker. If the rs ID queried
#' has been merged, the up-to-date name of the marker is returned here, and
#' a warning is issued.
#' \item \code{Class:} The marker's 'class'. See
#' \url{http://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass}
#' for more details.
#' \item \code{Gene:} If the marker lies within a gene (either within the exon
#' or introns of a gene), the name of that gene is returned here; otherwise,
#' \code{NA}. Note that
#' the gene may not be returned if the marker lies too far upstream or downstream
#' of the particular gene of interest.
#' \item \code{Alleles:} The alleles associated with the SNP if it is a
#' SNV; otherwise, if it is an INDEL, microsatellite, or other kind of
#' polymorphism the relevant information will be available here.
#' \item \code{Major:} The major allele of the SNP, on the forward strand,
#' given it is an SNV; otherwise, \code{NA}.
#' \item \code{Minor:} The minor allele of the SNP, on the forward strand,
#' given it is an SNV; otherwise, \code{NA}.
#' \item \code{MAF:} The minor allele frequency of the SNP, given it is an SNV.
#' This is drawn from the current global reference population used by NCBI.
#' \item \code{BP:} The chromosomal position, in base pairs, of the marker, 
#' as aligned with the current genome used by dbSNP.
#' }
#' @references \url{http://www.ncbi.nlm.nih.gov/projects/SNP/}
#' @details Note that you are limited in the number of SNPs you pass in to one request because
#' URLs can only be so long. Around 600 is likely the max you can pass in, though may be somewhat
#' more. Break up your vector of SNP codes into pieces of 600 or less and do repeated requests 
#' to get all data.
#' @examples \dontrun{
#' ## an example with both merged SNPs, non-SNV SNPs, regular SNPs,
#' ## SNPs not found, microsatellite
#' SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' NCBI_snp_query(SNPs)
#' NCBI_snp_query("123456") ##invalid: must prefix with 'rs'
#' NCBI_snp_query("rs420358")
#' NCBI_snp_query("rs332") # warning that its merged into another, try that
#' NCBI_snp_query("rs121909001") 
#' NCBI_snp_query("rs1837253")
#' NCBI_snp_query("rs1209415715") # warning that no data available, returns 0 length data.frame
#' NCBI_snp_query("rs111068718") # warning that chromosomal information may be unmapped
#' 
#' NCBI_snp_query(SNPs='rs9970807')$BP
#' 
#' # Curl debugging
#' NCBI_snp_query("rs121909001")
#' library("httr")
#' NCBI_snp_query("rs121909001", config=verbose())
#' snps <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' NCBI_snp_query(snps, config=progress())
#' }
NCBI_snp_query <- function(SNPs, ...) {
  
  ## ensure these are rs numbers of the form rs[0-9]+
  tmp <- sapply( SNPs, function(x) { grep( "^rs[0-9]+$", x) } )
  if( any( sapply( tmp, length ) == 0 ) ) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ", 
         "'rs', e.g. rs420358")
  }
  
  # query <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=snp&mode=xml&id="
  # query <- paste( sep='', query, paste( SNPs, collapse="," ) )
  
  url <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
  res <- GET(url, query = list(db = 'snp', mode = 'xml', id = paste( SNPs, collapse=",")), ...)
  stop_for_status(res)
  xml <- content(res, "text")
  # xml <- getURL( query )
  xml_parsed <- xmlInternalTreeParse( xml )
  xml_list_ <- xmlToList( xml_parsed )
  
  ## we don't need the last element; it's just metadata
  xml_list <- xml_list_[ 1:(length(xml_list_)-1) ]
  
  ## Check which rs numbers were found, and warn if one was not found
  ## one thing that makes our life difficult: there can be multiple
  ## XML entries with the same name. make sure we go through all of them
  found_snps <- unname( unlist( sapply( xml_list, function(x) {
    
    ## check if the SNP is either in the current rsId, or the merged SNP list
    attr_rsIds <- tryget( x$.attrs["rsId"] )
    
    merge_indices <- which( names(x) == "MergeHistory" )
    if (length(merge_indices)) {
      merge_rsIds <- sapply(x[merge_indices], "[[", "rsId")
    } else {
      merge_rsIds <- NULL
    }
    
    possible_names <- c(attr_rsIds, merge_rsIds)
    return(possible_names)
    
  }) ) )
  
  found_snps <- found_snps[ !is.na(found_snps) ]
  found_snps <- paste( sep='', "rs", found_snps )
  
  if( any( !(SNPs %in% found_snps) ) ) {
    warning("The following rsIds had no information available on NCBI:\n  ",
            paste( SNPs[ !(SNPs %in% found_snps) ], collapse=", ")
            )
  }
  SNPs <- SNPs[ SNPs %in% found_snps ]
  
  out <- as.data.frame( matrix(0, nrow=length(SNPs), ncol=10) )
  names(out) <- c("Query", "Chromosome", "Marker", "Class", "Gene", "Alleles",
    "Major", "Minor", "MAF", "BP")
  
  for( i in seq_along(SNPs) ) {
    
    my_list <- xml_list[[i]]
    my_chr <- tryget(my_list$Assembly$Component$.attrs["chromosome"])
    if( is.null(my_chr) ) {
      my_chr <- NA
      warning("No chromosomal information for ", SNPs[i], "; may be unmapped")
    }
    my_snp <- tryget( my_list$.attrs["rsId"] )
    if( !is.na(my_snp) ) {
      my_snp <- paste( sep='', "rs", my_snp )
    }
    if( my_snp != SNPs[i] ) {
      warning( SNPs[i], " has been merged into ", my_snp )
    }
    my_snpClass <- tryget(my_list$.attrs["snpClass"])
    
    my_gene <- tryget( my_list$Assembly$Component$MapLoc$FxnSet['symbol'] )
    if( is.null(my_gene) ) my_gene <- NA
    alleles <- my_list$Ss$Sequence$Observed
    
    ## handle true SNPs
    if( my_snpClass %in% c("snp", "snv") ) {
      tmp <- c( my_list$Ss$Sequence$Observed, my_list$Ss$.attrs["orient"] )
      if( tmp[2] != "forward" ) {
        tmp[1] <- flip( tmp[1], sep="/" )
      }
      alleles_split <- strsplit( tmp[1], "/" )[[1]]
      
      ## check which of the two alleles grabbed is actually the minor allele
      ## we might have to 'flip' the minor allele if there is no match
      maf_allele <- my_list$Frequency['allele']
      if(is.null(maf_allele)){
        maf_allele <- alleles <- strsplit(my_list$Sequence$Observed, "/")[[1]]
        my_major <- alleles[1]
        my_minor <- alleles[2]
        my_freq <- NA
      } else {
        my_minor <- alleles_split[ maf_allele == alleles_split ]
        my_major <- alleles_split[ maf_allele != alleles_split ]        
        my_freq <- my_list$Frequency["freq"]
      }
      if( all(maf_allele != alleles_split) ) {
        maf_allele <- swap( maf_allele, c("A", "C", "G", "T"), c("T", "G", "C", "A") )
      }

    } else { ## handle the others in a generic way; maybe specialize later
      my_minor <- NA
      my_major <- NA
      my_freq <- NA
    }
    
    my_pos <- tryCatch(
      my_list$Assembly$Component$MapLoc$.attrs["physMapInt"],
      error=function(e) { 
        my_list$Assembly$Component$MapLoc["physMapInt"]
      }
    )
    if( is.null( my_pos ) ) my_pos <- NA
    
    out[i, ] <- c( 
      SNPs[i], as.integer(my_chr), my_snp, unname(my_snpClass),
      unname(my_gene), paste0(unname(alleles),collapse=","), unname(my_major), unname(my_minor),
      as.numeric(my_freq), as.integer(my_pos)
    )
    
  }
  
  for (nm in c("MAF", "BP")) {
    out[, nm] <- as.numeric( out[, nm] )
  }
  
  return(out)
  
  ## NCBI limits to a maximum of 1 query per three seconds; we
  ## ensure that this limit is adhered to
  Sys.sleep(3)
  
}
