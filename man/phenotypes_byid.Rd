\name{phenotypes_byid}
\alias{phenotypes_byid}
\title{Get all known variations and all users sharing that phenotype for one phenotype(-ID).}
\usage{
  phenotypes_byid(phenotypeid = NA,
    return_ = c("description", "knownvars", "users"),
    url = "http://opensnp.org/phenotypes/json/variations/")
}
\arguments{
  \item{phenotypeid}{ID of openSNP phenotype.}

  \item{return_}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}

  \item{url}{Base URL for API method; leave unchanged.}
}
\value{
  List of description of phenotype, list of known variants,
  or data.frame of variants for each user with that
  phenotype.
}
\description{
  Get all known variations and all users sharing that
  phenotype for one phenotype(-ID).
}
\examples{
\dontrun{
phenotypes_byid(phenotypeid=12, return_ = 'desc')
phenotypes_byid(phenotypeid=12, return_ = 'knownvars')
phenotypes_byid(phenotypeid=12, return_ = 'users')
}
}

