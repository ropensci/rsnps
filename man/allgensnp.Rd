\name{allgensnp}
\alias{allgensnp}
\title{Get genotype data for all users at a particular snp.}
\usage{
  allgensnp(snp = NA, df = FALSE)
}
\arguments{
  \item{snp}{SNP name.}

  \item{df}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}
}
\value{
  List of genotypes for all users at a certain SNP, or
  data.frame
}
\description{
  Get genotype data for all users at a particular snp.
}
\examples{
\dontrun{
allgensnp(snp='rs7412')
allgensnp('rs7412', df=TRUE)
}
}

