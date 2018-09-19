#' Download openSNP genotype data for a user
#'
#' @export
#' @family opensnp-fxns
#' @param url (character) URL for the download. See example below of 
#' function use.
#' @param rows (integer) Number of rows to read in. Useful for getting a 
#' glimpse of  the data. Negative and other invalid values are ignored, 
#' giving back all data.  Default: 100
#' @param filepath (character) If none is given the file is saved to a 
#' temporary file,  which will be lost after your session is closed. Save 
#' to a file if you want to  access it later.
#' @param quiet (logical) Should download progress be suppressed. Default: 
#' `TRUE`
#' @param ... Further args passed on to [download.file()]
#' @return data.frame for a single user, with four columns:
#' 
#' - rsid (character)
#' - chromsome (integer)
#' - position (integer)
#' - genotype (character)
#' 
#' @details Beware, not setting the rows parameter means that you download 
#' the entire file, which can be large (e.g., 15MB), and so take a while 
#' to download depending on your connection speed. Therefore, rows is set to 
#' 10 by default to sort of protect the user. 
#' 
#' Internally, we use [download.file()] to download each file, then 
#' [read.table()] to read the file to a data.frame.
#' 
#' @examples \dontrun{
#' # get a data.frame of the users data
#' data <- users(df = TRUE)
#' head( data[[1]] ) # users with links to genome data
#' mydata <- fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], 
#'   file="~/myfile.txt")
#' 
#' # see some data right away
#' mydata
#' 
#' # Or read in data later separately
#' read.table("~/myfile.txt", nrows=10)
#' }
fetch_genotypes <- function(url, rows = 100, filepath = NULL, quiet = TRUE, ...) {
  if (is.null(filepath)) filepath <- tempfile(fileext = ".txt")
  utils::download.file(url, destfile = filepath, quiet = quiet, ...)
  df <- utils::read.table(filepath, sep = "\t", nrows = rows, header = FALSE, 
                   comment.char = "#", stringsAsFactors = FALSE)
  stats::setNames(df, c("rsid", "chromsome", "position", "genotype"))
}
