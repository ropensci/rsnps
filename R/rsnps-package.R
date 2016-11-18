#' Get SNP (Single-Nucleotide Polymorphism) Data on the Web
#'
#' This package gives you access to data from OpenSNP (https://opensnp.org)
#' via their API (https://opensnp.org/faq#api).
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom plyr ldply llply laply compact
#' @importFrom stringr str_split str_replace_all str_trim
#' @importFrom XML xmlInternalTreeParse xmlToList
#' @name rsnps-package
#' @aliases rsnps
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @author Kevin Ushey \email{kevinushey@@gmail.com}
#' @author Hao Zhu \email{haozhu233@@gmail.com}
NULL
