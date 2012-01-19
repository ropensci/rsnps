\name{users}
\alias{users}
\title{THIS FUNCTION DOESN'T WORK YET.......
 THIS FUNCTION DOESN'T WORK YET.......
 THIS FUNCTION DOESN'T WORK YET.......
 THIS FUNCTION DOESN'T WORK YET.......
 THIS FUNCTION DOESN'T WORK YET.......
 THIS FUNCTION DOESN'T WORK YET.......}
\usage{
  users(df = FALSE, url = "http://opensnp.org/users.json")

  users(df = FALSE, url = "http://opensnp.org/users.json")
}
\arguments{
  \item{df}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}

  \item{df}{Return data.frame (TRUE) or not (FALSE) -
  default = FALSE.}
}
\value{
  List of openSNP users, their ID numbers, and XX if
  available.

  List of openSNP users, their ID numbers, and XX if
  available.
}
\description{
  Get genotype data for one or multiple users.

  Get openSNP users.
}
\examples{
\dontrun{
# just the list
data <- users(df=FALSE)
data

# get a data.frame of the users data
data <- users(df=TRUE)
data[[1]] # users with links to genome data
data[[2]] # users without links to genome data
}
\dontrun{
# just the list
data <- users(df=FALSE)
data

# get a data.frame of the users data
data <- users(df=TRUE)
data[[1]] # users with links to genome data
data[[2]] # users without links to genome data
}
}

