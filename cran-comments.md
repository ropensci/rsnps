## Test environments

* local OS X install, R 3.6.2
* ubuntu 14.04 (on travis-ci), R 4.0.0
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* Maintainer: 'Julia Gustavsen <j.gustavsen@gmail.com>'

New maintainer:
  Julia Gustavsen <j.gustavsen@gmail.com>
Old maintainer(s):
  Scott Chamberlain <myrmecocystus@gmail.com>
  
 This is an expected change as the maintainers of this package have changed. 
 
* Also noted in win-builder were the following changes where we updated to https from http:

Found the following (possibly) invalid URLs:
  URL: http://opensnp.wordpress.com/2012/01/18/some-progress-on-the-api-json-endpoints (moved to https://opensnp.wordpress.com/2012/01/18/some-progress-on-the-api-json-endpoints/)
    From: README.md
    Status: 200
    Message: OK
  URL: http://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass (moved to https://www.ncbi.nlm.nih.gov/projects/SNP/snp_legend.cgi?legend=snpClass)
    From: man/ncbi_snp_query.Rd
    Status: 200
    Message: OK
  URL: https://github.com/metacran/cranlogs.app (moved to https://github.com/r-hub/cranlogs.app)
    From: README.md
    Status: 200
    Message: OK
  URL: https://www.ncbi.nlm.nih.gov/projects/SNP (moved to https://www.ncbi.nlm.nih.gov/projects/SNP/)
    From: DESCRIPTION
    Status: 200
    Message: OK
  URL: https://www.ncbi.nlm.nih.gov/pubmed/31738401 (moved to https://pubmed.ncbi.nlm.nih.gov/31738401/)
    From: man/ncbi_snp_query.Rd
    Status: 200
    Message: OK
  URL: https://www.ncbi.nlm.nih.gov/snp (moved to https://www.ncbi.nlm.nih.gov/snp/)
    From: README.md
    Status: 200
    Message: OK
  
## Reverse dependencies

* We have run R CMD check on the 1 downstream dependency
(<https://github.com/ropensci/rsnps/blob/master/revdep/README.md>).
No problems were found related to this package.

---

This version includes a bug fix, major and minor improvements of the function `ncbi_snp_query` and updated documentation.


Thanks!
Julia Gustavsen and Sina Rüeger