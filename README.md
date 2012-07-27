# `ropensnp`

Install using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```R
install.packages("devtools")
require(devtools)
install_github("ropensnp", "rOpenSci")
require(ropensnp)
```

This set of functions/package will access data from [openSNP.org](http://opensnp.org/) using their API methods. 

See documentation on the openSNP API [here](http://opensnp.org/faq#api) and [here](https://github.com/gedankenstuecke/snpr/wiki/JSON-API).

See blog post about their API [here](http://opensnp.wordpress.com/2012/01/18/some-progress-on-the-api-json-endpoints/).