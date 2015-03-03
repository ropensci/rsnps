rsnps
=======



[![Build Status](https://api.travis-ci.org/ropensci/rsnps.png)](https://travis-ci.org/ropensci/rsnps)
[![Build status](https://ci.appveyor.com/api/projects/status/d2lv98726u6t9ut5/branch/master)](https://ci.appveyor.com/project/sckott/rsnps/branch/master)

## NOTE

`rsnps` used to be `ropensnp`

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

## Data sources

This set of functions/package accesses data from:

+ openSNP.org
	+ [Their website](http://opensnp.org/)
	+ See documentation on the openSNP API [here](http://opensnp.org/faq#api) and [here](https://github.com/gedankenstuecke/snpr/wiki/JSON-API).
	+ See blog post about their API [here](http://opensnp.wordpress.com/2012/01/18/some-progress-on-the-api-json-endpoints/).
	+ Relavant functions:
		+ `allgensnp`, `allphenotypes`, `annotations`, `download_users`, `fetch_genotypes`, `genotypes`, `phenotypes`, `phenotypes_byid`, `users`


+ The Broad Institute SNP Annotation and Proxy Search
	+ See [http://www.broadinstitute.org/mpg/snap/index.php](http://www.broadinstitute.org/mpg/snap/index.php) for more details
	+ Relavant functions:
		+ `LDSearch`

+ NCBI's dbSNP SNP database
	+ See [http://www.ncbi.nlm.nih.gov/snp](http://www.ncbi.nlm.nih.gov/snp) for more details
	+ Relavant functions:
		+ `NCBI_snp_query`

## Quick start

### Search for SNPs in Linkage Disequilibrium

Using the Broad Institute data


```r
tmp <- LDSearch("rs420358")
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
#>        Proxy      SNP Distance RSquared DPrime GeneVariant GeneName
#> 4   rs420358 rs420358       NA    1.000  1.000  INTERGENIC      N/A
#> 5   rs442418 rs420358       NA    1.000  1.000  INTERGENIC      N/A
#> 8   rs718223 rs420358       NA    1.000  1.000  INTERGENIC      N/A
#> 6   rs453604 rs420358       NA    1.000  1.000  INTERGENIC      N/A
#> 3   rs372946 rs420358       NA    0.943  1.000  INTERGENIC      N/A
#> 1 rs10889290 rs420358       NA    0.800  1.000  INTERGENIC      N/A
#> 2 rs10889291 rs420358       NA    0.800  1.000  INTERGENIC      N/A
#> 7  rs4660403 rs420358       NA    0.800  1.000  INTERGENIC      N/A
#>   GeneDescription Major Minor   MAF NObserved Chromosome_NCBI Marker_NCBI
#> 4             N/A     C     A 0.167       120              NA          NA
#> 5             N/A     C     T 0.167       120              NA          NA
#> 8             N/A     A     G 0.167       120              NA          NA
#> 6             N/A     A     G 0.167       120              NA          NA
#> 3             N/A     G     C 0.175       120              NA          NA
#> 1             N/A     G     A 0.200       120              NA          NA
#> 2             N/A     C     T 0.200       120              NA          NA
#> 7             N/A     A     G 0.200       120              NA          NA
#>   Class_NCBI Gene_NCBI Alleles_NCBI Major_NCBI Minor_NCBI MAF_NCBI BP_NCBI
#> 4         NA        NA           NA         NA         NA       NA      NA
#> 5         NA        NA           NA         NA         NA       NA      NA
#> 8         NA        NA           NA         NA         NA       NA      NA
#> 6         NA        NA           NA         NA         NA       NA      NA
#> 3         NA        NA           NA         NA         NA       NA      NA
#> 1         NA        NA           NA         NA         NA       NA      NA
#> 2         NA        NA           NA         NA         NA       NA      NA
#> 7         NA        NA           NA         NA         NA       NA      NA
```

### Using NCBI dbSNP data


```r
SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
NCBI_snp_query(SNPs)
```

```
#>         Query Chromosome      Marker          Class Gene   Alleles Major
#> 1       rs332          7 rs121909001         in-del CFTR     -/TTT  <NA>
#> 2    rs420358          1    rs420358            snp <NA>       G,T     G
#> 3   rs1837253          5   rs1837253            snp <NA>       C/T     C
#> 4 rs111068718       <NA> rs111068718 microsatellite <NA> (GT)21/24  <NA>
#>   Minor    MAF        BP
#> 1  <NA>     NA 117559592
#> 2     T     NA  40341238
#> 3     T 0.3822 111066173
#> 4  <NA>     NA        NA
```

### Using openSNP data

`genotypes()` function


```r
genotypes('rs9939609', userid='1,6,8', df=TRUE)
```

```
#>    snp_name snp_chromosome snp_position         user_name user_id
#> 1 rs9939609             16     53786615  Bastian Greshake       1
#> 2 rs9939609             16     53786615      Nash Parovoz       6
#> 3 rs9939609             16     53786615 Samantha B. Clark       8
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

* Please [report any issues or bugs](https://github.com/ropensci/rsnsps/issues).
* License: MIT
* Get citation information for `rsnsps` in R doing `citation(package = 'rsnsps')`

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
