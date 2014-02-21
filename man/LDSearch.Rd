\name{LDSearch}
\alias{LDSearch}
\title{Search for SNPs in Linkage Disequilibrium with a set of SNPs}
\usage{
LDSearch(SNPs, dataset = "onekgpilot", panel = "CEU", RSquaredLimit = 0.8,
  distanceLimit = 500, GeneCruiser = TRUE, quiet = FALSE)
}
\arguments{
  \item{SNPs}{A vector of SNPs (rs numbers).}

  \item{dataset}{The dataset to query. Must be one of:
  \itemize{ \item{\code{rel21: }}{HapMap Release 21}
  \item{\code{rel22: }}{HapMap Release 22}
  \item{\code{hapmap3r2: }}{HapMap 3 (release 2)}
  \item{\code{onekgpilot: }}{1000 Genomes Pilot 1} }}

  \item{panel}{The panel to use from the queried data set.
  Must be one of: \itemize{ \item{\code{CEU}}
  \item{\code{YRI}} \item{\code{JPT+CHB}} } If you are
  working with \code{hapmap3r2}, you can choose the
  additional panels: \itemize{ \item{\code{ASW}}
  \item{\code{CHD}} \item{\code{GIH}} \item{\code{LWK}}
  \item{\code{MEK}} \item{\code{MKK}} \item{\code{TSI}}
  \item{\code{CEU+TSI}} \item{\code{JPT+CHB+CHD}} }}

  \item{RSquaredLimit}{The R Squared limit to specify as a
  filter for returned SNPs; that is, only SNP pairs with
  R-squared greater than \code{RSquaredLimit} will be
  returned.}

  \item{distanceLimit}{The distance (in kilobases) upstream
  and downstream to search for SNPs in LD with each set of
  SNPs.}

  \item{GeneCruiser}{boolean; if \code{TRUE} we attempt to
  get gene info through GeneCruiser for each SNP. This can
  slow the query down substantially.}

  \item{quiet}{boolean; if \code{TRUE} progress updates are
  written to the console.}
}
\value{
A list of data frames, one for each SNP queried, containing
information about the SNPs found to be in LD with that SNP.
A description of the columns follows: \itemize{
\item{\code{Proxy:} The proxy SNP matched to the queried
SNP.} \item{\code{SNP:} The SNP queried.}
\item{\code{Distance:} The distance, in base pairs, between
the queried SNP and the proxy SNP. This distance is
calculated according to up-to-date position information
returned from NCBI.} \item{\code{RSquared:} The measure of
LD between the SNP and the proxy.} \item{\code{DPrime:}
Another measure of LD between the SNP and the proxy.}
\item{\code{GeneVariant:} Present if \code{GeneCruiser} is
\code{TRUE}. This will identify where the SNP lies relative
to its 'parent' SNP.} \item{\code{GeneName:} Present if
\code{GeneCruiser} is \code{TRUE}. If the proxy SNP found
lies within a gene, the name of that gene will be returned
here. Otherwise, the field is \code{N/A}.}
\item{\code{GeneDescription:} Present if \code{GeneCruiser}
is \code{TRUE}. If the proxy SNP lies within a gene,
information about that gene (as obtained from GeneCruiser)
will be available here.} \item \code{Major:} The major
allele, as reported by SNAP. \item \code{Minor:} The minor
allele, as reported by SNAP. \item{\code{MAF:} The minor
allele frequency corresponding to the reference panel
queried, as obtained through SNAP.} \item{\code{NObserved:}
The number of individuals from which the MAF information is
generated, for column \code{MAF}.} \item
\code{Chromosome_NCBI:} The chromosome that the marker lies
on. \item \code{Marker_NCBI:} The name of the marker. If
the rs ID queried has been merged, the up-to-date name of
the marker is returned here, and a warning is issued. \item
\code{Class_NCBI:} The marker's 'class'. See
\url{http://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass}
for more details. \item \code{Gene_NCBI:} If the marker
lies within a gene (either within the exon or introns of a
gene), the name of that gene is returned here; otherwise,
\code{NA}. Note that the gene may not be returned if the
marker lies too far upstream or downstream of the
particular gene of interest. \item \code{Alleles_NCBI:} The
alleles associated with the SNP if it is a SNV; otherwise,
if it is an INDEL, microsatellite, or other kind of
polymorphism the relevant information will be available
here. \item \code{Major_NCBI:} The major allele of the SNP,
on the forward strand, given it is an SNV; otherwise,
\code{NA}. \item \code{Minor_NCBI:} The minor allele of the
SNP, on the forward strand, given it is an SNV; otherwise,
\code{NA}. \item \code{MAF_NCBI:} The minor allele
frequency of the SNP, given it is an SNV. This is drawn
from the current global reference population used by NCBI.
\item \code{BP_NCBI:} The chromosomal position, in base
pairs, of the marker, as aligned with the current genome
used by dbSNP. }
}
\description{
This function queries the SNP Annotation and Proxy tool
(SNAP) for SNPs in high linkage disequilibrium with a set
of SNPs, and also merges in up-to-date SNP annotation
information available from NCBI.
}
\details{
For more details, please see
\url{http://www.broadinstitute.org/mpg/snap/ldsearch.php}.

Information on the HapMap populations:
\url{http://ccr.coriell.org/Sections/Collections/NHGRI/hapmap.aspx?PgId=266&coll=HG}

Information on the 1000 Genomes populations:
\url{http://www.1000genomes.org/category/frequently-asked-questions/population}
}
\examples{
\dontrun{
LDSearch("rs420358")
}
}

