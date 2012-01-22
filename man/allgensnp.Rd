\name{allgensnp}
\alias{allgensnp}
\title{Get genotype data for one or multiple users.}
\usage{
  allgensnp(snp = NA, df = FALSE,
    url = "http://opensnp.org/snps/")
}
\arguments{
  \item{df}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}
}
\value{
  List of openSNP users, their ID numbers, and XX if
  available.
}
\description{
  Get genotype data for one or multiple users.
}
\examples{
\dontrun{
allgensnp('rs7412')
allgensnp('rs7412', df=TRUE)
}
}

