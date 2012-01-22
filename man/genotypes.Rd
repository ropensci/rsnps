\name{genotypes}
\alias{genotypes}
\title{Get genotype data for one or multiple users.}
\usage{
  genotypes(df = FALSE,
    url = "http://opensnp.org/snps/json/")
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
genotypes(df=TRUE)
}
}

