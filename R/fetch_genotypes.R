#' Download genotype data for a user from 23andme or other repo.
#'
#' @import httr stringr
#' @param url URL for the download. See example below of function use.
#' @param rows Number of rows to read in. Useful for getting a glimpse of the data.
#' @return Dataset for a single user.
#' @examples \dontrun{
#' # get a data.frame of the users data
#' data <- users(df=TRUE)
#' head( data[[1]] ) # users with links to genome data
#' mydata <- fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15)
#' mydata
#' }
#' @export 
fetch_genotypes <- function(url = url, rows = NULL) 
{
	if(is.null(rows)){
  	df <- read.table(as.character(url), skip=13, sep="\t", nrows = rows, header=F)
  	names(df) <- c("rsid","chromsome","position","genotype")
  	df
	} else
		{
			df <- read.table(as.character(url), skip=13, sep="\t", nrows = rows, header=F)
			names(df) <- c("rsid","chromsome","position","genotype")
			df
		}
}