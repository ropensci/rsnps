\name{allphenotypes}
\alias{allphenotypes}
\title{Get all phenotypes, their variations, and how many users have data
		available for a given phenotype.}
\usage{
  allphenotypes(df = FALSE,
    url = "http://opensnp.org/phenotypes.json")
}
\arguments{
  \item{df}{Return a data.frame of all data. The column
  known_variations can take multiple values, so the other
  columns id, characteristic, and number_of_users are
  replicated in the data.frame. (default = FALSE)}

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
allphenotypes(df = TRUE)

# Output a list, then call the characterisitc of interest by 'id' or 'characteristic'
datalist <- allphenotypes()
names(datalist) # get list of all characteristics you can call
datalist[["ADHD"]] # get data.frame for 'ADHD'
datalist[c("mouth size","SAT Writing")] # get data.frame for 'ADHD'
}
}

