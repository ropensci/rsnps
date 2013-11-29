rsnps
=======

[![Build Status](https://api.travis-ci.org/ropensci/rsnps.png)](https://travis-ci.org/ropensci/rsnps)

## NOTE
`rsnps` used to be `ropensnp`

## Install 
Install the development versions using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```coffee
install.packages("devtools")
require(devtools)
install_github("rsnps", "rOpenSci")
require(rsnps)
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

```coffee
tmp <- LDSearch("rs420358")
Querying SNAP...
Querying NCBI for up-to-date SNP annotation information...
Done!

head(tmp)
```

```coffee
$rs420358
       Proxy      SNP Distance RSquared DPrime GeneVariant GeneName GeneDescription Major Minor   MAF
4   rs420358 rs420358        0    1.000  1.000  INTERGENIC      N/A             N/A     C     A 0.167
5   rs442418 rs420358      122    1.000  1.000  INTERGENIC      N/A             N/A     C     T 0.167
8   rs718223 rs420358     1168    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167
6   rs453604 rs420358     2947    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167
3   rs372946 rs420358      -70    0.943  1.000  INTERGENIC      N/A             N/A     G     C 0.175
1 rs10889290 rs420358     3987    0.800  1.000  INTERGENIC      N/A             N/A     G     A 0.200
2 rs10889291 rs420358     4334    0.800  1.000  INTERGENIC      N/A             N/A     C     T 0.200
7  rs4660403 rs420358     7021    0.800  1.000  INTERGENIC      N/A             N/A     A     G 0.200
  NObserved Chromosome_NCBI Marker_NCBI Class_NCBI Gene_NCBI Alleles_NCBI Major_NCBI Minor_NCBI MAF_NCBI
4       120               1    rs420358        snp      <NA>          G/T          G          T   0.0891
5       120               1    rs442418        snp      <NA>          A/G          G          A   0.0891
8       120               1    rs718223        snp      <NA>          A/G          A          G   0.0891
6       120               1    rs453604        snp      <NA>          A/G          A          G   0.0836
3       120               1    rs372946        snp      <NA>          C/G          G          C   0.0891
1       120               1  rs10889290        snp      <NA>          A/G          G          A   0.1015
2       120               1  rs10889291        snp      <NA>          C/T          C          T   0.1015
7       120               1   rs4660403        snp      <NA>          A/G          A          G   0.0969
   BP_NCBI
4 40806910
5 40807032
8 40808078
6 40809857
3 40806840
1 40810897
2 40811244
7 40813931
```

### Using NCBI dbSNP data

```coffee
SNPs <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
NCBI_snp_query(SNPs)
```

```coffee
        Query Chromosome      Marker          Class Gene   Alleles Major Minor    MAF        BP
1       rs332          7 rs121909001         in-del CFTR     -/TTT  <NA>  <NA>     NA 117199646
2    rs420358          1    rs420358            snp <NA>       G/T     G     T 0.0891  40806910
3   rs1837253          5   rs1837253            snp <NA>       C/T     C     T 0.3627 110401871
4 rs111068718       <NA> rs111068718 microsatellite <NA> (GT)21/24  <NA>  <NA>     NA        NA
```


### Using openSNP data

`genotypes()` function

```coffee
genotypes('rs9939609', userid='1,6,8', df=TRUE)
```

```coffee
http://opensnp.org/snps/json/rs9939609/1,6,8.json
   snp_name snp_chromosome snp_position        user_name user_id genotype_id genotype
1 rs9939609             16     52378028 Bastian Greshake       1           9       AT
2 rs9939609             16     52378028     Nash Parovoz       6           5       AT
3 rs9939609             16     52378028         Samantha       8           2       TT
```

`phenotypes()` function

```coffee
out <- phenotypes(userid=1)
out$phenotypes$`Hair Type`
```

```coffee
$phenotype_id
[1] 16

$variation
[1] "straight"
```

---

Please report any issues or bugs](https://github.com/ropensci/rsnps/issues).

License: CC0

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

To cite package `rsnps` in publications use:

```coffee
To cite package ‘rsnps’ in publications use:

  Scott Chamberlain and Kevin Ushey (2013). rsnps: Get SNP
  (Single-Nucleotide Polymorphism) data on the web.. R package version
  0.0.5. https://github.com/ropensci/rsnps

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {rsnps: Get SNP (Single-Nucleotide Polymorphism) data on the web.},
    author = {Scott Chamberlain and Kevin Ushey},
    year = {2013},
    note = {R package version 0.0.5},
    url = {https://github.com/ropensci/rsnps},
  }
```

Get citation information for `rsnps` in R doing `citation(package = 'rsnps')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)