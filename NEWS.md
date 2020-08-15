
rsnps 0.4.0
===========

### MAJOR IMPROVEMENTS

NCBI / dbSNP changed their API:

* Rewrote `ncbi_snp_query` to accommodate the new API (#86, #88). 
* Removed the functions `ncbi_snp_query2` an `ncbi_snp_summary`. 

### MINOR IMPROVEMENTS

* Reordered `ncbi_snp_query` dataframe output to have chromosome and bp beside each other (#70).
* Changed `ncbi_snp_query` parameter (`SNPs`) to lower case (`snps`). 

### DOCUMENTATION FIXES

* Restructured and fixed a typo in `README.Rmd` and added link to vignette (#63).
* Added info of two new maintainers to `DESCRIPTION`. 
* Added relevant API links to vignette. 

### BUG FIXES

* Fixed the test for `allphenotypes` function by making it less specific (#72). 


rsnps 0.3.0
===========

### DEPRECATED AND DEFUNCT

* `ld_search()` is now defunct. The Broad Institute has taken down the SNAP service behind the function. (#46) (#53) (#60)

### NEW FEATURES

* the three NCBI functions gain a new parameter `key` for passing in an NCBI Entrez API key. You can alternatively (and we encourage this) store your key as an environment variable and we'll use that instead. The key allows you to have higher rate limits than without a key (#58)
* gains new function `ncbi_snp_summary()` for summary data on a SNP (#31)

### MINOR IMPROVEMENTS

* http requests are now done using `crul` instead of `httr` (#44)
* now using markdown formatted documentation (#56)
* documented in `ncbi_snp_query()` that we can not change the assembly (#49)

### BUG FIXES

* fix to `ncbi_snp_query2()`: when many IDs passed in, we were failing with a "URI too long" message. We now check how many Ids are passed in and do a POST request as needed  (#39)
* fixed problem in `ncbi_snp_query()` where it wasn't pulling out correctly the gene name and BP position (#25)



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
