
#' Internal function to get the position, alleles, assembly, hgvs notation
#'
#' @param primary_info refsnp entry read in JSON format
#'
get_placements <- function(primary_info) {
  for (record in primary_info$primary_snapshot_data$placements_with_allele) {
    if (record$is_ptlp & length(record$placement_annot$seq_id_traits_by_assembly) > 0) {
      assembly_name <- record$placement_annot$seq_id_traits_by_assembly[[1]]$assembly_name
      chrom_name <- gsub("NC_[0]+([1-9]+[0-9]?)\\.[[:digit:]]+", "\\1", record$seq_id)
      df_list <- lapply(record$alleles,
                        function(one_allele) {
                          if (one_allele$allele$spdi$deleted_sequence != one_allele$allele$spdi$inserted_sequence) {
                            alleles <-  paste(one_allele$allele$spdi$deleted_sequence,
                                              one_allele$allele$spdi$inserted_sequence,
                                              sep = ",")
                            if (one_allele$allele$spdi$inserted_sequence == "") {
                              VariationAllele <-  paste0("del",
                                                         one_allele$allele$spdi$deleted_sequence)
                              alleles <-  paste(alleles, VariationAllele)
                            } else {
                              VariationAllele <- one_allele$allele$spdi$inserted_sequence
                            }
                            
                            df_snp <- data.frame(Alleles = alleles,
                                                 AncestralAllele = one_allele$allele$spdi$deleted_sequence,
                                                 VariationAllele = VariationAllele,
                                                 BP = one_allele$allele$spdi$position + 1,
                                                 seqname = one_allele$allele$spdi$seq_id,
                                                 hgvs = one_allele$hgvs,
                                                 assembly = assembly_name,
                                                 Chromosome = chrom_name,
                                                 stringsAsFactors = FALSE)
                            return(df_snp)
                          }
                        }
      )
      
      ## remove the NULLs
      df_list <- df_list[lengths(df_list) != 0]
      
      ## if more than one we need to merge the ancestral and variation alleles
      df_all <- do.call(rbind, df_list)
      new_df <- stats::aggregate(. ~ BP, data = df_all,
                          FUN = function(x)
                            paste(unique(x[x != ""]),
                                  collapse = ",")
      )
      new_df$Alleles <- paste(unique(unlist(strsplit(new_df$Alleles, ","))),
                              collapse = ",")
      return(new_df)
    }}
}


#' Internal function to get the frequency of the variants from
#' different studies.
#'
#' @param primary_info refsnp entry read in JSON format
#' @param study Study from which frequency information is obtained. Possibilities
#' include: GnomAD (default), 1000Genomes, ALSPAC, Estonian, NorthernSweden, TWINSUK
#'
get_frequency <- function(primary_info, study = "GnomAD") {
  for (record in  primary_info$primary_snapshot_data$allele_annotations) {
    for (freq_record in record$frequency) {
      if (freq_record$study_name == study & freq_record$observation$deleted_sequence != freq_record$observation$inserted_sequence) {
        if (freq_record$observation$inserted_sequence == "") {
          MAF <-  round(freq_record$allele_count / freq_record$total_count, 4)
          df_freq <- data.frame(ref_seq = freq_record$observation$deleted_sequence,
                                Minor = paste0("del", freq_record$observation$deleted),
                                MAF = MAF,
                                stringsAsFactors = FALSE)
        }
        else if (freq_record$observation$deleted_sequence == "") {
          MAF <-  round(freq_record$allele_count / freq_record$total_count, 4)
          df_freq <- data.frame(ref_seq = freq_record$observation$deleted_sequence,
                                Minor = paste0("dup", freq_record$observation$inserted_sequence),
                                MAF = MAF,
                                stringsAsFactors = FALSE)
        }
        else {
          MAF <-  round(freq_record$allele_count / freq_record$total_count, 4)
          df_freq <- data.frame(ref_seq = freq_record$observation$deleted_sequence,
                                Minor = freq_record$observation$inserted_sequence,
                                MAF = MAF,
                                stringsAsFactors = FALSE)
        }
        return(df_freq)
      }
    }
  }
}

#' Internal function to get gene names.
#' 
#' If multiple gene names are encountered they are collapsed with a 
#' "/".
#' @param primary_info refsnp entry read in JSON format
#' 
get_gene_names <- function(primary_info) {
  gene_list <- c()
  for (record in  primary_info$primary_snapshot_data$allele_annotations) {
    for (annotations in record$assembly_annotation) {
      for (genes in annotations$genes) {
        gene <- genes$locus
        gene_list <- c(gene_list, gene)
      }
    }
  }
  gene_list <- paste(unique(gene_list), collapse = "/")
  return(gene_list)
}


#' Query NCBI's refSNP for information on a set of SNPs via the API
#'
#' This function queries NCBI's refSNP for information related to the latest
#' dbSNP build and latest reference genome for information on the vector
#' of SNPs submitted.
#' 
#' This function currently pulling data for Assembly 38 - in particular
#' note that if you think the BP position is wrong, that you may be 
#' hoping for the BP position for a different Assembly. 
#'
#' @export
#' @param SNPs (character) A vector of SNPs (rs numbers).
#' @param ... Curl options passed on to [crul::HttpClient]
#' @return A dataframe with columns:
#' 
#' - Query: The rs ID that was queried.
#' - Chromosome: The chromosome that the marker lies on.
#' - BP: The chromosomal position, in base pairs, of the marker,
#' as aligned with the current genome used by dbSNP. we add 1 to the base 
#' pair position in the BP column in the output data.frame to agree with 
#' what the dbSNP website has.
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
#' - AncestralAllele: allele as described in the current assembly
#' - VariationAllele: difference to the current assembly
#' - seqname - Chromosome RefSeq reference.
#' - hgvs -  full hgvs notation for variant
#' - assembly - which assembly was used for the annotations
#' - ref_seq - sequence in reference assembly
#'
#' @seealso [ncbi_snp_query()]
#'
#' @references <https://www.ncbi.nlm.nih.gov/projects/SNP/>
#' @references <https://www.ncbi.nlm.nih.gov/pubmed/31738401> SPDI model
#'
#' @details Note that you are limited in the to a max of one query per second
#' and concurrent queries are not allowed.
#'
#' @examples \dontrun{
#' ## an example with both merged SNPs, non-SNV SNPs, regular SNPs,
#' ## SNPs not found, microsatellite
#' SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
#' ncbi_snp_query_api (SNPs)
#' # ncbi_snp_query_api ("123456") ##invalid: must prefix with 'rs'
#' ncbi_snp_query_api ("rs420358")
#' ncbi_snp_query_api ("rs332") # warning that its merged into another, try that
#' ncbi_snp_query_api ("rs121909001")
#' ncbi_snp_query_api ("rs1837253")
#' ncbi_snp_query_api ("rs1209415715")
#' ncbi_snp_query_api ("rs111068718")
#' ncbi_snp_query_api (SNPs='rs9970807')
#'
#' ncbi_snp_query_api ("rs121909001")
#' ncbi_snp_query_api ("rs121909001", verbose = TRUE)
#' }
ncbi_snp_query_api <- function(SNPs, ...) {
  ## ensure these are rs numbers of the form rs[0-9]+
  tmp <- sapply(SNPs, function(x) {
    grep("^rs[0-9]+$", x)
  })
  if (any(sapply(tmp, length) == 0)) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358", call. = FALSE)
  }
  
  message(paste0("Getting info about the following rsIDs: ",
                 paste(SNPs,
                       collapse = ", ")))
  ## transform all SNPs into numbers (rsid)
  SNPs_num <- gsub("rs", "", SNPs)
  
  out <- as.data.frame(matrix(0, nrow = length(SNPs_num), ncol = 15))
  names(out) <- c("Query", "Chromosome", "BP", "Class", "Marker", "Gene", "Alleles", "AncestralAllele", "VariationAllele", "seqname", "hgvs", "assembly", "ref_seq", "Minor", "MAF")
  
  ## as far as I understand from https://api.ncbi.nlm.nih.gov/variation/v0/#/RefSNP/ we
  ## can only send one query at a time and max 1 per second.
  for (i in seq_along(SNPs_num)) {
    
    variant.url <- paste0("https://api.ncbi.nlm.nih.gov/variation/v0/refsnp/", SNPs_num[i])
    variant.response <-  httr::GET(variant.url)
    variant.response.content <-  RJSONIO::fromJSON(rawToChar(variant.response$content),
                                                   simplifyWithNames = TRUE)
    
    if ("error" %in% names(variant.response.content)) {
      if (variant.response.content$error$message == "RefSNP not found") {
        warning("The following rsId had no information available on NCBI:\n  ",
                paste0("rs", SNPs_num[i]),
                call. = FALSE)
        next()
      } else {
        warning("The following error was received from NCBI:\n  ",
                variant.response.content$error$message,
                call. = FALSE)
        next()
      }
    }
    
    if ("withdrawn_snapshot_data" %in% names(variant.response.content) & length(variant.response.content$present_obs_movements) == 0) {
      warning("The following rsId has been withdrawn from NCBI:\n  ",
              paste0("rs", SNPs_num[i]),
              call. = FALSE)
      next()
    }
    Query <- as.character(paste0("rs", variant.response.content$refsnp_id))
    
    ## if merged into another id
    if (is.null(variant.response.content$primary_snapshot_data)) {
      
      Marker <- as.character(paste0("rs", variant.response.content$merged_snapshot_data$merged_into))
      no_rs_Marker <-  as.character(variant.response.content$merged_snapshot_data$merged_into)
      
      warning(Query, " has been merged into ", Marker, call. = FALSE)
      
      variant.url <- paste0("https://api.ncbi.nlm.nih.gov/variation/v0/refsnp/", no_rs_Marker)
      variant.response <- httr::GET(variant.url)
      variant.response.content <- RJSONIO::fromJSON(rawToChar(variant.response$content),
                                                    simplifyWithNames = TRUE)
      Class <- as.character(variant.response.content$primary_snapshot_data$variant_type)
      placement_SNP <- get_placements(variant.response.content)
      
      if (Class %in% c("snv", "snp", "delins")) {
        ## frequence of minor allele
        frequency_SNP <- get_frequency(variant.response.content)
        
        ## if there is no frequency information
        if (is.null(frequency_SNP)) {
          frequency_SNP <- data.frame(ref_seq = NA,
                                      Minor = NA,
                                      MAF = NA,
                                      stringsAsFactors = FALSE)
        }
        
      } else {
        frequency_SNP <- data.frame(ref_seq = NA,
                                    Minor = NA,
                                    MAF = NA,
                                    stringsAsFactors = FALSE)
      }
      
      Gene <- get_gene_names(variant.response.content)
    } else {
      Marker <- as.character(paste0("rs",
                                    variant.response.content$refsnp_id))
      Class <- as.character(variant.response.content$primary_snapshot_data$variant_type)
      placement_SNP <- get_placements(variant.response.content)
      
      if (Class %in% c("snv", "snp", "delins")) {
        ## frequency of minor allele
        frequency_SNP <- get_frequency(variant.response.content)
        if (is.null(frequency_SNP)) {
          frequency_SNP <- data.frame(ref_seq = NA,
                                      Minor = NA,
                                      MAF = NA,
                                      stringsAsFactors = FALSE)
        }
      } else {
        frequency_SNP <- data.frame(ref_seq = NA,
                                    Minor = NA,
                                    MAF = NA,
                                    stringsAsFactors = FALSE)
      }
      Gene <- get_gene_names(variant.response.content)
    }
    
    out[i, ] <- c(Query,
                  placement_SNP$Chromosome,
                  placement_SNP$BP,
                  Class,
                  Marker,
                  Gene,
                  placement_SNP$Alleles,
                  placement_SNP$AncestralAllele,
                  placement_SNP$VariationAllele,
                  placement_SNP$seqname,
                  placement_SNP$hgvs,
                  placement_SNP$assembly,
                  frequency_SNP$ref_seq,
                  frequency_SNP$Minor,
                  frequency_SNP$MAF)
    
  }
  Sys.sleep(1)
  
  ## remove missing rsnumbers
  out <- out[out$Query != 0, ]
  
  for (nm in c("MAF", "BP")) {
    out[, nm] <- as.numeric(out[, nm])
  }
  return(out)
}
