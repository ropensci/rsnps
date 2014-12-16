#' Download openSNP user files.
#'
#' @param name User name
#' @param id User id
#' @param dir Directory to save file to
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return File downloaded to directory you specify (or default), nothing returned
#' in R.
#' @export
#' @examples \dontrun{
#' # Download a single user file, by id
#' download_users(id = 14)
#'
#' # Download a single user file, by user name
#' download_users(name = 'kevinmcc')
#'
#' # Download many user files
#' lapply(c(14,22), function(x) download_users(id=x))
#' read_users(id=14, nrows=5)
#' }
download_users <- function(name = NULL, id = NULL, dir = "~/", ...)
{
  if(is.null(name) && is.null(id))
    stop("You must specify one of name or id")

  data <- users(df=TRUE)
  tmp <- data[[1]]
  if(is.null(name)){
    fileurl <- as.character(tmp[tmp$id %in% id, "genotypes.download_url"])
    meta <- tmp[tmp$id %in% id, c("name","id")]
  } else
  {
    fileurl <- as.character(tmp[tmp$name %in% name, "genotypes.download_url"])
    meta <- tmp[tmp$name %in% name, c("name","id")]
  }
  fileend <- strsplit(fileurl, "/")[[1]][length(strsplit(fileurl, "/")[[1]])]
  dir2 <- paste(dir, fileend, '.txt', sep="")
  get_write(fileurl, dir2, ...)

  assign(as.character(meta[,1]), dir2, envir = rsnps::rsnpsCache) # name
  assign(as.character(meta[,2]), dir2, envir = rsnps::rsnpsCache) # id

  message(sprintf("File downloaded - saved to %s", dir2))
}

get_write <- function(x, y, ...){
  res <- GET(x, ...)
  txt <- content(res, as = "text")
  write(txt, file = y)
}

#' Read in openSNP user files from local storage.
#'
#' Beware, these tables can be large. Check your RAM before executing. Or possibly
#' read in a subset of the data. This function reads in the whole kitten kaboodle.
#'
#' @param name User name
#' @param id User id
#' @param path Path to file to read from.
#' @param ... Parameters passed on to read.table.
#' @details
#' If you specify a name or id, this function reads environment variables written
#' in the function download_users, and then searches against those variables for the
#' path to the file saved. Alternatively, you can supply the path.
#' @return A data.frame.
#' @export
#' @examples \dontrun{
#' dat <- read_users(name = "kevinmcc")
#' head(dat)
#' dat <- read_users(id = 285)
#' }
read_users <- function(name = NULL, id = NULL, path = NULL, ...)
{
  if(is.null(name) && is.null(id) && is.null(path))
    stop("You must specify one of name, id, or path")

  if(!is.null(path)){
    dir <- path
  } else
  {
    cache <- mget(ls(rsnps::rsnpsCache), envir=rsnps::rsnpsCache)
    by <- compact(list(name=name, id=id))
    dir <- cache[names(cache) %in% by[[1]]][[1]]
  }
  message(sprintf("Reading data from %s", dir))
  dat <- read.table(dir, skip=14, ...)
  names(dat) <- c('rsid','chromsome','position','genotype')
  dat
}

#' rsnps environment
#' @export
#' @keywords internal
rsnpsCache <- new.env(hash=TRUE)
