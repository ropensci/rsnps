# `rsnps`

## UPDATE! 
We just changed this repo to `rsnps` from `ropensnp`, and haven't yet updated the CRAN version. But you can install from GitHub. 

## Install development versions using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```R
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

+ The Broad Institute SNP Annotation and Proxy Search
	+ See \url{http://www.broadinstitute.org/mpg/snap/index.php} for more details