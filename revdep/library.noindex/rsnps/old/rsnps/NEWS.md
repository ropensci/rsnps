rsnps 0.2.0
===========

### NEW FEATURES

* `LDSearch()` is now `ld_search()`, but `LDSearch()` still works until 
the next CRAN release when it will be defunct (#33)
* `NCBI_snp_query()` is now `ncbi_snp_query()`, but `NCBI_snp_query()` still 
works until the next CRAN release when it will be defunct (#33)
* `NCBI_snp_query2()` is now `ncbi_snp_query2()`, but `NCBI_snp_query2()` still 
works until the next CRAN release when it will be defunct (#33)

### MINOR IMPROVEMENTS

* Namespace all base R package function calls (#21)
* Improve `httr::content` call to parse to text, and `encoding = "UTF-8"` 
(#24)
* Added tests for `ld_search()` (#12)
* Added tests for `ncbi_snp_query()` and `ncbi_snp_query2()` (#13)
* Added ancestral allele output to `ncbi_snp_query()` (#23)

### BUG FIXES

* Fix to `fetch_genotypes()`, was failing sometimes when the commented
metadata lines at top varied in length (#22)
* Fix to `ld_search()` (#32)


rsnps 0.1.6
===========

### MINOR IMPROVEMENTS

* All examples now in `\dontrun`. (#11)
* Added additional tests for `LDSearch()` and `NCBI_snp_query()`.
* Added a vignette.

### BUG FIXES

* Bugs fixed in `LDSearch()`, which were actually bugs in `NCBI_snp_query()`. (#9)
* Bug fixed in `NCBI_snp_query()` as chromosome might also be "X". 

rsnps 0.1.0
===========

### NEW FEATURES 

* Bug fixes to all openSNP functions.

rsnps 0.0.5
===========

### NEW FEATURES 

* released to CRAN
