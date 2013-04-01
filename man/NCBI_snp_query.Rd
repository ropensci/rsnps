\name{NCBI_snp_query}
\alias{NCBI_snp_query}
\title{Query NCBI's dbSNP for information on a set of SNPs}
\usage{
  NCBI_snp_query(SNPs)
}
\arguments{
  \item{SNPs}{A vector of SNPs (rs numbers).}
}
\value{
  A dataframe with columns: \itemize{ \item \code{Query:}
  The rs ID that was queried. \item \code{Chromosome:} The
  chromosome that the marker lies on. \item \code{Marker:}
  The name of the marker. If the rs ID queried has been
  merged, the up-to-date name of the marker is returned
  here, and a warning is issued. \item \code{Class:} The
  marker's 'class'. See
  \url{http://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass}
  for more details. \item \code{Gene:} If the marker lies
  within a gene (either within the exon or introns of a
  gene), the name of that gene is returned here; otherwise,
  \code{NA}. Note that the gene may not be returned if the
  marker lies too far upstream or downstream of the
  particular gene of interest. \item \code{Alleles:} The
  alleles associated with the SNP if it is a SNV;
  otherwise, if it is an INDEL, microsatellite, or other
  kind of polymorphism the relevant information will be
  available here. \item \code{Major:} The major allele of
  the SNP, on the forward strand, given it is an SNV;
  otherwise, \code{NA}. \item \code{Minor:} The minor
  allele of the SNP, on the forward strand, given it is an
  SNV; otherwise, \code{NA}. \item \code{MAF:} The minor
  allele frequency of the SNP, given it is an SNV. This is
  drawn from the current global reference population used
  by NCBI. \item \code{BP:} The chromosomal position, in
  base pairs, of the marker, as aligned with the current
  genome used by dbSNP. }
}
\description{
  This function queries NCBI's dbSNP for information
  related to the latest dbSNP build and latest reference
  genome for information on the vector of SNPs submitted.
}
\examples{
\dontrun{
## an example with both merged SNPs, non-SNV SNPs, regular SNPs,
## SNPs not found, microsatellite
SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
NCBI_snp_query(SNPs)
NCBI_snp_query("123456") ##invalid: must prefix with 'rs'
}
}
\seealso{
  \url{http://www.ncbi.nlm.nih.gov/projects/SNP/}
}

