#' Get SNP (Single-Nucleotide Polymorphism) Data on the Web
#'
#' This package gives you access to data from OpenSNP (https://opensnp.org)
#' via their API (https://opensnp.org/faq#api) and NCBI's dbSNP SNP database 
#' (https://www.ncbi.nlm.nih.gov/snp).
#' 
#' @section NCBI Authenication:
#' This applies the function [ncbi_snp_query()]:
#' 
#' You can optionally use an API key, if you do it will 
#' allow higher rate limits (more requests per time period)
#' 
#' If you don't have an NCBI API key, get one at 
#' https://www.ncbi.nlm.nih.gov/account/
#' 
#' Create your key from your account. After generating your key 
#' set an environment variable as `ENTREZ_KEY` in .Renviron. 
#' 
#' `ENTREZ_KEY='youractualkeynotthisstring'`
#' 
#' You can optionally pass in your API key to the key parameter in NCBI 
#' functions in this package. However, it's much better from a security
#' perspective to set an environment variable.
#'
#' @importFrom crul HttpClient
#' @importFrom plyr ldply llply laply compact
#' @importFrom stringr str_split str_replace_all str_trim
#' @name rsnps-package
#' @aliases rsnps
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @author Kevin Ushey \email{kevinushey@@gmail.com}
#' @author Hao Zhu \email{haozhu233@@gmail.com}
#' @author Sina Rüeger \email{sina.rueeger@gmail.com}
#' @author Julia Gustavsen \email{j.gustavsen@gmail.com}
NULL

