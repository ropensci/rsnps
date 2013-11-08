rsnps
=======

[![Build Status](https://api.travis-ci.org/ropensci/rsnps.png)](https://travis-ci.org/ropensci/rsnps)

## NOTE
`rsnps` used to be `ropensnp` - we haven't yet updated the CRAN version. But you can install from GitHub. 

## Install 
Install the development versions using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```coffee
install.packages("devtools")
require(devtools)
install_github("rsnps", "rOpenSci")
require(rsnps)
```

## Data sources
This set of functions/package will access data from: 

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

```coffee
"coming soon..."
```

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)