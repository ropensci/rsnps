\name{annotations}
\alias{annotations}
\title{Get all phenotypes, their variations, and how many users have data
		available for a given phenotype.}
\usage{
  annotations(snp = NA,
    output = c("all", "plos", "mendeley", "snpedia", "metadata"),
    url = "http://opensnp.org/snps/json/annotation/")
}
\arguments{
  \item{snp}{SNP name.}

  \item{output}{Name the source or sources you want
  annotations from (options are: 'plos', 'mendeley',
  'snpedia', 'metadata'). 'metadata' gives the metadata for
  the response.}

  \item{url}{Base URL for API method; leave unchanged.}
}
\value{
  Data.frame of results.
}
\description{
  Either return data.frame with all results, or output a
  list, then call the charicteristic by id (paramater =
  "id") or name (paramater = "characteristic").
}
\examples{
\dontrun{
# Get all data
annotations(snp = 'rs7903146', output = 'metadata') # get just the metadata
annotations(snp = 'rs7903146', output = 'plos') # just from plos
annotations(snp = 'rs7903146', output = 'snpedia') # just from snpedia
annotations(snp = 'rs7903146', output = 'all') # get all annotations
}
}

