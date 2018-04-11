rsnps
=====



[![Build Status](https://api.travis-ci.org/ropensci/rsnps.png)](https://travis-ci.org/ropensci/rsnps)
[![Build status](https://ci.appveyor.com/api/projects/status/d2lv98726u6t9ut5/branch/master)](https://ci.appveyor.com/project/sckott/rsnps/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/rsnps/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rsnps?branch=master)
[![cran version](http://www.r-pkg.org/badges/version/rsnps)](https://cran.r-project.org/package=rsnps)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rsnps?color=E664A4)](https://github.com/metacran/cranlogs.app)

## NOTE

`rsnps` used to be `ropensnp`


## Data sources

This set of functions/package accesses data from:

+ openSNP.org
	+ <https://opensnp.org>
	+ See documentation on the openSNP API <https://opensnp.org/faq#api>
	+ See blog post about their API <http://opensnp.wordpress.com/2012/01/18/some-progress-on-the-api-json-endpoints>
	+ Relavant functions:
		+ `allgensnp()`, `allphenotypes()`, `annotations()`, `download_users()`, 
		`fetch_genotypes()`, `genotypes()`, `phenotypes()`, `phenotypes_byid()`, `users()`

+ The Broad Institute SNP Annotation and Proxy Search
	+ See <http://www.broadinstitute.org/mpg/snap/index.php> for more details
	+ Relavant functions:
		+ `ld_search()`

+ NCBI's dbSNP SNP database
	+ See <https://www.ncbi.nlm.nih.gov/snp> for more details
	+ Relavant functions:
		+ `ncbi_snp_query()`
		+ `ncbi_snp_query2()`

## Install

Install from CRAN


```r
install.packages("rsnps")
```

Or dev version


```r
install.packages("devtools")
devtools::install_github("ropensci/rsnps")
```


```r
library("rsnps")
```

## Search for SNPs in Linkage Disequilibrium

Using the Broad Institute data


```r
tmp <- ld_search("rs420358")
```

```
#> Querying SNAP...
#> Querying NCBI for up-to-date SNP annotation information...
#> Done!
```

```r
head(tmp)
```

```
#> $rs420358
#>        Proxy      SNP Distance RSquared DPrime Major Minor   MAF NObserved
#> 4   rs420358 rs420358        0    1.000  1.000     C     A 0.167       120
#> 5   rs442418 rs420358      122    1.000  1.000     C     T 0.167       120
#> 8   rs718223 rs420358     1168    1.000  1.000     A     G 0.167       120
#> 6   rs453604 rs420358     2947    1.000  1.000     A     G 0.167       120
#> 3   rs372946 rs420358      -70    0.943  1.000     G     C 0.175       120
#> 1 rs10889290 rs420358     3987    0.800  1.000     G     A 0.200       120
#> 2 rs10889291 rs420358     4334    0.800  1.000     C     T 0.200       120
#> 7  rs4660403 rs420358     7021    0.800  1.000     A     G 0.200       120
#>   marker_NCBI organism_NCBI chromosome_NCBI assembly_NCBI alleles_NCBI
#> 4    rs420358  Homo sapiens               1     GRCh38.p7        A/G/T
#> 5    rs442418  Homo sapiens               1     GRCh38.p7        A/G/T
#> 8    rs718223  Homo sapiens               1     GRCh38.p7          A/G
#> 6    rs453604  Homo sapiens               1     GRCh38.p7          A/G
#> 3    rs372946  Homo sapiens               1     GRCh38.p7        C/G/T
#> 1  rs10889290  Homo sapiens               1     GRCh38.p7        A/C/G
#> 2  rs10889291  Homo sapiens               1     GRCh38.p7          C/T
#> 7   rs4660403  Homo sapiens               1     GRCh38.p7        A/G/T
#>   minor_NCBI maf_NCBI  bp_NCBI
#> 4       <NA>     <NA> 40341239
#> 5          T   0.0723 40341361
#> 8          G   0.0723 40342407
#> 6          G   0.0727 40344186
#> 3       <NA>     <NA> 40341169
#> 1          A   0.0841 40345226
#> 2          T   0.0839 40345573
#> 7          G   0.0827 40348260
```

## Using NCBI dbSNP data


```r
SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
ncbi_snp_query(SNPs)
```

```
#>          Query Chromosome       Marker  Class Gene Alleles Major Minor
#> 1        rs332          7  rs121909001 in-del CFTR   -/TTT  <NA>  <NA>
#> 2     rs420358          1     rs420358    snp <NA>   A,G,T     A     G
#> 3    rs1837253          5    rs1837253    snp <NA>     C/T     C     T
#> 4 rs1209415715          9 rs1209415715    snp <NA>     C,T     C     T
#>      MAF        BP AncestralAllele
#> 1     NA 117559593            <NA>
#> 2     NA  40341239     T,T,T,T,T,T
#> 3 0.3822 111066174     T,T,T,T,T,T
#> 4     NA  41782316            <NA>
```

## Using openSNP data

`genotypes()` function


```r
genotypes('rs9939609', userid='1,6,8', df=TRUE)
```

```
#>    snp_name snp_chromosome snp_position                 user_name user_id
#> 1 rs9939609             16     53786615 Bastian Greshake Tzovaras       1
#> 2 rs9939609             16     53786615              Nash Parovoz       6
#> 3 rs9939609             16     53786615         Samantha B. Clark       8
#>   genotype_id genotype
#> 1           9       AT
#> 2           5       AT
#> 3           2       TT
```

`phenotypes()` function


```r
out <- phenotypes(userid=1)
out$phenotypes$`Hair Type`
```

```
#> $phenotype_id
#> [1] 16
#> 
#> $variation
#> [1] "straight"
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rsnps/issues).
* License: MIT
* Get citation information for `rsnsps` in R doing `citation(package = 'rsnps')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). 
By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
