#' Get SNP (Single-Nucleotide Polymorphism) Data on the Web
#'
#' This package gives you access to data from OpenSNP (https://opensnp.org)
#' via their API (https://opensnp.org/faq#api).
#'
#' @importFrom crul HttpClient
#' @importFrom plyr ldply llply laply compact
#' @importFrom stringr str_split str_replace_all str_trim
#' @importFrom xml2 read_xml xml_find_all xml_text xml_attr
#' @importFrom XML xmlInternalTreeParse xmlToList
#' @name rsnps-package
#' @aliases rsnps
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @author Kevin Ushey \email{kevinushey@@gmail.com}
#' @author Hao Zhu \email{haozhu233@@gmail.com}
NULL
