The `ropensnp` package interacts with the API services of [OpenSNP](http://opensnp.org/). No API key is needed. 

This tutorial will go through three use cases to demonstrate the kinds of things possible in `ropensnp`.

+ Get genotype data for all users at a particular snp.
+ Get genotype data for one or multiple users.
+ Get phenotype data for one or multiple users.
+ Get openSNP user information.

***
### Load package from GitHub

```r
# install_github('ropensnp', 'ropensci')
library(ropensnp)
```

```
## Loading required package: RJSONIO
```

```
## Loading required package: plyr
```

```
## Loading required package: stringr
```


***

#### Get genotype data for all users at a particular snp.

```r
head(allgensnp("rs7412", df = TRUE))
```

```
##   snp_name snp_chromosome snp_position        user_name user_id
## 1   rs7412             19     50103919 Bastian Greshake       1
## 2   rs7412             19     50103919     Nash Parovoz       6
## 3   rs7412             19     50103919         Samantha       8
## 4   rs7412             19     50103919             Svan      10
## 5   rs7412             19     50103919 Daniel Goldowitz      11
## 6   rs7412             19     50103919            sagan      13
##   genotype_id genotype
## 1           9       CC
## 2           5       CC
## 3           2       CC
## 4           3       CC
## 5         176       CC
## 6           4       CC
```


***

#### Get genotype data for one or multiple users.

```r
genotypes(snp = "rs9939609", userid = 1)
```

```
## $snp
##        name  chromosome    position 
## "rs9939609"        "16"  "52378028" 
## 
## $user
## $user$name
## [1] "Bastian Greshake"
## 
## $user$id
## [1] 1
## 
## $user$genotypes
## $user$genotypes[[1]]
## $user$genotypes[[1]]$genotype_id
## [1] 9
## 
## $user$genotypes[[1]]$local_genotype
## [1] "AT"
## 
## 
## 
## 
```

```r
genotypes("rs9939609", userid = "1,6,8", df = TRUE)
```

```
##    snp_name snp_chromosome snp_position        user_name user_id
## 1 rs9939609             16     52378028 Bastian Greshake       1
## 2 rs9939609             16     52378028     Nash Parovoz       6
## 3 rs9939609             16     52378028         Samantha       8
##   genotype_id genotype
## 1           9       AT
## 2           5       AT
## 3           2       TT
```


***

### Get phenotype data for one or multiple users.

```r
phenotypes(userid = "1,6,8", df = TRUE)
```

```
## Error: unused argument(s) (df = TRUE)
```

```r
head(phenotypes(userid = "1-8", df = TRUE)[[1]])
```

```
## Error: unused argument(s) (df = TRUE)
```

```r

library(plyr)
head(ldply(phenotypes(userid = "1-8", df = TRUE)))
```

```
## Error: unused argument(s) (df = TRUE)
```



***

### Get openSNP user information.

```r
# just the list
data <- users(df = FALSE)
data[1:2]
```

```
## [[1]]
## [[1]]$name
## [1] "gigatwo"
## 
## [[1]]$id
## [1] 31
## 
## [[1]]$genotypes
## list()
## 
## 
## [[2]]
## [[2]]$name
## [1] "Dan Fornika"
## 
## [[2]]$id
## [1] 21
## 
## [[2]]$genotypes
## list()
## 
## 
```

```r

# get a data.frame of the users data
data <- users(df = TRUE)
head(data[[1]])  # users with links to genome data
```

```
##           name  id genotypes.id genotypes.filetype
## 1     Samantha   8            2            23andme
## 2 Nash Parovoz   6            5            23andme
## 3         Svan  10            3            23andme
## 4    Mom to AG 387          173            23andme
## 5 R.M. Holston  22            8            23andme
## 6   Little bit  14            6            23andme
##                    genotypes.download_url
## 1     http://opensnp.org/data/8.23andme.2
## 2     http://opensnp.org/data/6.23andme.5
## 3    http://opensnp.org/data/10.23andme.3
## 4 http://opensnp.org/data/387.23andme.173
## 5    http://opensnp.org/data/22.23andme.8
## 6    http://opensnp.org/data/14.23andme.6
```

```r
head(data[[2]])  # users without links to genome data
```

```
##               name  id
## 1          gigatwo  31
## 2      Dan Fornika  21
## 3      Anu Acharya 385
## 4 richard randazzo   9
## 5 Martin Rodriguez 386
## 6       mrrredith   29
```

