\name{phenotypes}
\alias{phenotypes}
\title{Get phenotype data for one or multiple users.}
\usage{
  phenotypes(userid = NA,
    url = "http://opensnp.org/phenotypes/json/")
}
\arguments{
  \item{userid}{ID of openSNP user.}

  \item{url}{Base URL for API method; leave unchanged.}
}
\value{
  List of phenotypes for specified user(s).
}
\description{
  Get phenotype data for one or multiple users.
}
\examples{
\dontrun{
phenotypes(userid=1)
phenotypes(userid='1,6,8')
phenotypes(userid='1-8')
}
}

