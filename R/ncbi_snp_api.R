
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
#' @param Class What kind of variant is the rsid. Accepted options are "snv", "snp" and "delins".
#' @param primary_info refsnp entry read in JSON format
#' @param study Study from which frequency information is obtained. Possibilities
#' include: GnomAD (default), 1000Genomes, ALSPAC, Estonian, NorthernSweden, TWINSUK
#'
get_frequency <- function(Class, primary_info, study = "GnomAD") {
  if (Class %in% c("snv", "snp", "delins")) {
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
        }
      }
    }
    if (exists("df_freq")) {
      return(df_freq)
    }
    else {
      df_freq <- data.frame(ref_seq = NA,
                            Minor = NA,
                            MAF = NA,
                            stringsAsFactors = FALSE)
    }
  } else {
    df_freq <- data.frame(ref_seq = NA,
                          Minor = NA,
                          MAF = NA,
                          stringsAsFactors = FALSE)
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
#' of snps submitted.
#' 
#' This function currently pulling data for Assembly 38 - in particular
#' note that if you think the BP position is wrong, that you may be 
#' hoping for the BP position for a different Assembly. 
#'
#' @export
#' @param snps (character) A vector of SNPs (rs numbers).
#' @return A dataframe with columns:
#' 
#' - query: The rs ID that was queried.
#' - chromosome: The chromosome that the marker lies on.
#' - bp: The chromosomal position, in base pairs, of the marker,
#' as aligned with the current genome used by dbSNP. we add 1 to the base 
#' pair position in the BP column in the output data.frame to agree with 
#' what the dbSNP website has.
#' - rsid: Reference SNP cluster ID. If the rs ID queried
#' has been merged, the up-to-date name of the ID is returned here, and
#' a warning is issued.
#' - class: The rsid's 'class'. See
#' <https://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass>
#' for more details.
#' - gene: If the rsid lies within a gene (either within the exon
#' or introns of a gene), the name of that gene is returned here; otherwise,
#' `NA`. Note that
#' the gene may not be returned if the rsid lies too far upstream or downstream
#' of the particular gene of interest.
#' - alleles: The alleles associated with the SNP if it is a
#' SNV; otherwise, if it is an INDEL, microsatellite, or other kind of
#' polymorphism the relevant information will be available here.
#' - minor: The allele for which the MAF is computed,
#' given it is an SNV; otherwise, `NA`.
#' - maf: The minor allele frequency of the SNP, given it is an SNV.
#' This is drawn from the current global reference population used by NCBI (GnomAD).
#' - ancestral_allele: allele as described in the current assembly
#' - variation_allele: difference to the current assembly
#' - seqname - Chromosome RefSeq reference.
#' - hgvs -  full hgvs notation for variant
#' - assembly - which assembly was used for the annotations
#' - ref_seq - sequence in reference assembly
#'
#'
#' @references <https://www.ncbi.nlm.nih.gov/projects/SNP/>
#' @references <https://pubmed.ncbi.nlm.nih.gov/31738401/> SPDI model
#'
#' @details Note that you are limited in the to a max of one query per second
#' and concurrent queries are not allowed.
#' If users want to set curl options when querying for the SNPs they can do so by using
#'  httr::set_config/httr::with_config
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
#' ncbi_snp_query(snps='rs9970807')
#'
#' ncbi_snp_query("rs121909001")
#' ncbi_snp_query("rs121909001", verbose = TRUE)
#' }
ncbi_snp_query <- function(snps) {
  ## ensure these are rs numbers of the form rs[0-9]+
  tmp <- sapply(snps, function(x) {
    grep("^rs[0-9]+$", x)
  })
  if (any(sapply(tmp, length) == 0)) {
    stop("not all items supplied are prefixed with 'rs';\n",
         "you must supply rs numbers and they should be prefixed with ",
         "'rs', e.g. rs420358", call. = FALSE)
  }
  
  message(paste0("Getting info about the following rsIDs: ",
                 paste(snps,
                       collapse = ", ")))
  ## transform all SNPs into numbers (rsid)
  snps_num <- gsub("rs", "", snps)
  
  out <- as.data.frame(matrix(0, nrow = length(snps_num), ncol = 15))
  names(out) <- c("query", "chromosome", "bp", "class", "rsid", "gene", "alleles", "ancestral_allele", "variation_allele", "seqname", "hgvs", "assembly", "ref_seq", "minor", "maf")

  ## as far as I understand from https://api.ncbi.nlm.nih.gov/variation/v0/#/RefSNP/ we
  ## can only send one query at a time and max 1 per second.
  for (i in seq_along(snps_num)) {
    
    variant.url <- paste0("https://api.ncbi.nlm.nih.gov/variation/v0/refsnp/", snps_num[i])
    variant.response <-  httr::GET(variant.url)
    variant.response.content <-  RJSONIO::fromJSON(rawToChar(variant.response$content),
                                                   simplifyWithNames = TRUE)
    
    if ("error" %in% names(variant.response.content)) {
      if (variant.response.content$error$message == "RefSNP not found") {
        warning("The following rsId had no information available on NCBI:\n  ",
                paste0("rs", snps_num[i]),
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
              paste0("rs", snps_num[i]),
              call. = FALSE)
      next()
    }
    Query <- as.character(paste0("rs", variant.response.content$refsnp_id))
    
    ## if merged into another id
    if (is.null(variant.response.content$primary_snapshot_data)) {
      
      rsid <- as.character(paste0("rs", variant.response.content$merged_snapshot_data$merged_into))
      no_rsid <-  as.character(variant.response.content$merged_snapshot_data$merged_into)
      
      warning(Query, " has been merged into ", rsid, call. = FALSE)
      
      variant.url <- paste0("https://api.ncbi.nlm.nih.gov/variation/v0/refsnp/", no_rsid)
      variant.response <- httr::GET(variant.url)
      variant.response.content <- RJSONIO::fromJSON(rawToChar(variant.response$content),
                                                    simplifyWithNames = TRUE)
    } else {
      rsid <- as.character(paste0("rs",
                                  variant.response.content$refsnp_id))
    }
    
    Class <- as.character(variant.response.content$primary_snapshot_data$variant_type)
    placement_SNP <- get_placements(variant.response.content)
    ## frequency of minor allele
    frequency_SNP <- get_frequency(Class, variant.response.content)
    Gene <- get_gene_names(variant.response.content)
    
    out[i, ] <- c(Query,
                  placement_SNP$Chromosome,
                  placement_SNP$BP,
                  Class,
                  rsid,
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
  out <- out[out$query != 0, ]
  
  for (nm in c("maf", "bp")) {
    out[, nm] <- as.numeric(out[, nm])
  }
  return(out)
}
