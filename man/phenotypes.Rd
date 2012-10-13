\name{phenotypes}
\alias{phenotypes}
\title{Get phenotype data for one or multiple users.}
\usage{
  phenotypes(userid = NA, df = FALSE,
    url = "http://opensnp.org/phenotypes/json/")
}
\arguments{
  \item{userid}{ID of openSNP user.}

  \item{df}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}

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
phenotypes(userid='1,6,8', df=TRUE)
phenotypes(userid='1-8', df=TRUE)

# coerce to data.frame
library(plyr)
ldply(phenotypes(userid='1-8', df=TRUE))
}
}

