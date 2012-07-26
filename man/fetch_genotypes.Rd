\name{fetch_genotypes}
\alias{fetch_genotypes}
\title{Download genotype data for a user from 23andme or other repo.}
\usage{
  fetch_genotypes(url = url, rows = NULL)
}
\arguments{
  \item{url}{URL for the download. See example below of
  function use.}

  \item{rows}{Number of rows to read in. Useful for getting
  a glimpse of the data.}
}
\value{
  Dataset for a single user.
}
\description{
  Download genotype data for a user from 23andme or other
  repo.
}
\examples{
\dontrun{
# get a data.frame of the users data
data <- users(df=TRUE)
head( data[[1]] ) # users with links to genome data
mydata <- fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15)
mydata
}
}

