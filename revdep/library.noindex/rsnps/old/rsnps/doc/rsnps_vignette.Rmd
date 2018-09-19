<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rsnps tutorial}
%\VignetteEncoding{UTF-8}
-->



rsnps tutorial
==============

## Install and load library

When available on CRAN


```r
install.packages("rsnps")
```

Or get from Github


```r
install.packages("devtools")
devtools::install_github("ropensci/rsnps")
```



```r
library(rsnps)
```

## OpenSNP data

### All Genotypes

Get genotype data for all users at a particular SNP


```r
allgensnp(snp='rs7412')[1:3]
#> [[1]]
#> [[1]]$snp
#> [[1]]$snp$name
#> [1] "rs7412"
#> 
#> [[1]]$snp$chromosome
#> [1] "19"
#> 
#> [[1]]$snp$position
#> [1] "44908822"
#> 
#> 
#> [[1]]$user
#> [[1]]$user$name
#> [1] "JS"
#> 
#> [[1]]$user$id
#> [1] 5450
#> 
#> [[1]]$user$genotypes
#> [[1]]$user$genotypes[[1]]
#> [[1]]$user$genotypes[[1]]$genotype_id
#> [1] 3948
#> 
#> [[1]]$user$genotypes[[1]]$local_genotype
#> [1] "CC"
#> 
#> 
#> 
#> 
#> 
#> [[2]]
#> [[2]]$snp
#> [[2]]$snp$name
#> [1] "rs7412"
#> 
#> [[2]]$snp$chromosome
#> [1] "19"
#> 
#> [[2]]$snp$position
#> [1] "44908822"
#> 
#> 
#> [[2]]$user
#> [[2]]$user$name
#> [1] "Stinky Jerome"
#> 
#> [[2]]$user$id
#> [1] 5443
#> 
#> [[2]]$user$genotypes
#> [[2]]$user$genotypes[[1]]
#> [[2]]$user$genotypes[[1]]$genotype_id
#> [1] 3943
#> 
#> [[2]]$user$genotypes[[1]]$local_genotype
#> [1] "CC"
#> 
#> 
#> 
#> 
#> 
#> [[3]]
#> [[3]]$snp
#> [[3]]$snp$name
#> [1] "rs7412"
#> 
#> [[3]]$snp$chromosome
#> [1] "19"
#> 
#> [[3]]$snp$position
#> [1] "44908822"
#> 
#> 
#> [[3]]$user
#> [[3]]$user$name
#> [1] "Brittany"
#> 
#> [[3]]$user$id
#> [1] 5386
#> 
#> [[3]]$user$genotypes
#> [[3]]$user$genotypes[[1]]
#> [[3]]$user$genotypes[[1]]$genotype_id
#> [1] 3900
#> 
#> [[3]]$user$genotypes[[1]]$local_genotype
#> [1] "CC"
```


```r
allgensnp('rs7412', df=TRUE)[1:10,]
#>    snp_name snp_chromosome snp_position      user_name user_id genotype_id genotype
#> 1    rs7412             19     44908822             JS    5450        3948       CC
#> 2    rs7412             19     44908822  Stinky Jerome    5443        3943       CC
#> 3    rs7412             19     44908822       Brittany    5386        3900       CC
#> 4    rs7412             19     44908822         andorp    5385        3899       CC
#> 5    rs7412             19     44908822          isaac    5383        3897       CC
#> 6    rs7412             19     44908822     Li Xinquan    5382        3896       CC
#> 7    rs7412             19     44908822 Kimberly Clark    5380        3894       CC
#> 8    rs7412             19     44908822        christi    5379        3893       CC
#> 9    rs7412             19     44908822    Phil Shirts    5378        3891       CC
#> 10   rs7412             19     44908822    Jeff Wright    5376        3890       CC
```


### All Phenotypes

Get all phenotypes, their variations, and how many users have data available for a given phenotype

Get all data


```r
allphenotypes(df = TRUE)[1:10,]
#>    id characteristic                   known_variations number_of_users
#> 1   1      Eye color                              Brown            1004
#> 2   1      Eye color                        Brown-green            1004
#> 3   1      Eye color                         Blue-green            1004
#> 4   1      Eye color                          Blue-grey            1004
#> 5   1      Eye color                              Green            1004
#> 6   1      Eye color                               Blue            1004
#> 7   1      Eye color                              Hazel            1004
#> 8   1      Eye color                              Mixed            1004
#> 9   1      Eye color                          Gray-blue            1004
#> 10  1      Eye color Blue-grey; broken amber collarette            1004
```

Output a list, then call the characterisitc of interest by 'id' or 'characteristic'


```r
datalist <- allphenotypes()
```

Get a list of all characteristics you can call


```r
names(datalist)[1:10]
#>  [1] "Eye color"                        "Lactose intolerance"              "Handedness"                       "white skin"                       "Ability to find a bug in openSNP"
#>  [6] "Beard Color"                      "Hair Color"                       "Ability to Tan"                   "Height"                           "Hair Type"
```

Get data.frame for _ADHD_


```r
datalist[["ADHD"]]
#>   id characteristic                            known_variations number_of_users
#> 1 29           ADHD                                       False             232
#> 2 29           ADHD                                        True             232
#> 3 29           ADHD              Undiagnosed, but probably true             232
#> 4 29           ADHD                                          No             232
#> 5 29           ADHD                                         Yes             232
#> 6 29           ADHD                               Not diagnosed             232
#> 7 29           ADHD Diagnosed as not having but with some signs             232
#> 8 29           ADHD                                 Mthfr c677t             232
#> 9 29           ADHD                                   Rs1801260             232
```

Get data.frame for _mouth size_ and _SAT Writing_


```r
datalist[c("mouth size","SAT Writing")]
#> $`mouth size`
#>    id characteristic     known_variations number_of_users
#> 1 120     mouth size               Medium             150
#> 2 120     mouth size                Small             150
#> 3 120     mouth size                Large             150
#> 4 120     mouth size Slightly wide mouth              150
#> 
#> $`SAT Writing`
#>    id characteristic                                        known_variations number_of_users
#> 1  41    SAT Writing                                                     750              87
#> 2  41    SAT Writing                                      Tested before 2005              87
#> 3  41    SAT Writing                                                     800              87
#> 4  41    SAT Writing                                     Country with no sat              87
#> 5  41    SAT Writing                                                     N/a              87
#> 6  41    SAT Writing                                 Never & have ba & above              87
#> 7  41    SAT Writing                                                     720              87
#> 8  41    SAT Writing                         Did well - don't remember score              87
#> 9  41    SAT Writing                                                     511              87
#> 10 41    SAT Writing                                                     700              87
#> 11 41    SAT Writing                                                     760              87
#> 12 41    SAT Writing                                                     780              87
#> 13 41    SAT Writing Not part of sat when i took test in august 1967 at uiuc              87
#> 14 41    SAT Writing                                 Not part of sat in 1961              87
#> 15 41    SAT Writing                                                     620              87
```

### Annotations

Get just the metadata


```r
annotations(snp = 'rs7903146', output = 'metadata')
#>          .id        V1
#> 1       name rs7903146
#> 2 chromosome        10
#> 3   position 112998590
```

Just from PLOS journals


```r
annotations(snp = 'rs7903146', output = 'plos')[c(1:2),]
#>                   author                                                                                                                                    title
#> 1        Maggie C. Y. Ng Meta-Analysis of Genome-Wide Association Studies in African Americans Provides Insights into the Genetic Architecture of Type 2 Diabetes
#> 2 André Gustavo P. Sousa                                  Genetic Variants of Diabetes Risk and Incident Cardiovascular Events in Chronic Coronary Artery Disease
#>           publication_date number_of_readers                                            url                          doi
#> 1 2014-08-07T00:00:00.000Z              7783 http://dx.doi.org/10.1371/journal.pgen.1004517 10.1371/journal.pgen.1004517
#> 2 2011-01-20T00:00:00.000Z              2080 http://dx.doi.org/10.1371/journal.pone.0016341 10.1371/journal.pone.0016341
```

Just from SNPedia


```r
annotations(snp = 'rs7903146', output = 'snpedia')
#>                                               url                                                          summary
#> 1 http://www.snpedia.com/index.php/Rs7903146(C;C) Normal (lower) risk of Type 2 Diabetes and Gestational Diabetes.
#> 2 http://www.snpedia.com/index.php/Rs7903146(C;T)     1.4x increased risk for diabetes (and perhaps colon cancer).
#> 3 http://www.snpedia.com/index.php/Rs7903146(T;T)                            2x increased risk for Type-2 diabetes
```

Get all annotations


```r
annotations(snp = 'rs7903146', output = 'all')[1:5,]
#>        .id              author                                                                                                                              title publication_year
#> 1 mendeley           T E Meyer                                                Diabetes genes and prostate cancer in the Atherosclerosis Risk in Communities study             2010
#> 2 mendeley      Camilla Cervin                                                        Diabetes in Adults , Type 1 Diabetes , and Type 2 Diabetes GENETICS OF LADA             2008
#> 3 mendeley Nicholette D Palmer                                Association of TCF7L2 gene polymorphisms with reduced acute insulin response in Hispanic Americans.             2008
#> 4 mendeley      Ashis K Mondal                  Genotype and tissue-specific effects on alternative splicing of the transcription factor 7-like 2 gene in humans.             2010
#> 5 mendeley        Julian Munoz Polymorphism in the transcription factor 7-like 2 (TCF7L2) gene is associated with reduced insulin secretion in nondiabetic women.             2006
#>   number_of_readers open_access                                                                                                                                    url
#> 1                 3        TRUE                              http://www.mendeley.com/research/diabetes-genes-prostate-cancer-atherosclerosis-risk-communities-study-4/
#> 2                 2       FALSE                                        http://www.mendeley.com/research/diabetes-adults-type-1-diabetes-type-2-diabetes-genetics-lada/
#> 3                 8       FALSE              http://www.mendeley.com/research/association-tcf7l2-gene-polymorphisms-reduced-acute-insulin-response-hispanic-americans/
#> 4                13        TRUE        http://www.mendeley.com/research/genotype-tissuespecific-effects-alternative-splicing-transcription-factor-7like-2-gene-humans/
#> 5                10        TRUE http://www.mendeley.com/research/polymorphism-transcription-factor-7like-2-tcf7l2-gene-associated-reduced-insulin-secretion-nondiabet/
#>                                              doi publication_date summary first_author pubmed_link journal trait pvalue pvalue_description confidence_interval
#> 1 19/2/558 [pii]\\r10.1158/1055-9965.EPI-09-0902             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA               <NA>                <NA>
#> 2                         10.2337/db07-0299.Leif             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA               <NA>                <NA>
#> 3                           10.1210/jc.2007-1225             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA               <NA>                <NA>
#> 4                           10.1210/jc.2009-2064             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA               <NA>                <NA>
#> 5                              10.2337/db06-0574             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA               <NA>                <NA>
```

### Download

Download genotype data for a user from 23andme or other repo. (not evaluated in this example)


```r
data <- users(df=TRUE)
head( data[[1]] )
fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15)
```

### Genotype user data

Genotype data for one or multiple users


```r
genotypes(snp='rs9939609', userid=1)
#> $snp
#> $snp$name
#> [1] "rs9939609"
#> 
#> $snp$chromosome
#> [1] "16"
#> 
#> $snp$position
#> [1] "53786615"
#> 
#> 
#> $user
#> $user$name
#> [1] "Bastian Greshake"
#> 
#> $user$id
#> [1] 1
#> 
#> $user$genotypes
#> $user$genotypes[[1]]
#> $user$genotypes[[1]]$genotype_id
#> [1] 9
#> 
#> $user$genotypes[[1]]$local_genotype
#> [1] "AT"
```


```r
genotypes('rs9939609', userid='1,6,8', df=TRUE)
#>    snp_name snp_chromosome snp_position         user_name user_id genotype_id genotype
#> 1 rs9939609             16     53786615  Bastian Greshake       1           9       AT
#> 2 rs9939609             16     53786615      Nash Parovoz       6           5       AT
#> 3 rs9939609             16     53786615 Samantha B. Clark       8           2       TT
```


```r
genotypes('rs9939609', userid='1-2', df=FALSE)
#> [[1]]
#> [[1]]$snp
#> [[1]]$snp$name
#> [1] "rs9939609"
#> 
#> [[1]]$snp$chromosome
#> [1] "16"
#> 
#> [[1]]$snp$position
#> [1] "53786615"
#> 
#> 
#> [[1]]$user
#> [[1]]$user$name
#> [1] "Bastian Greshake"
#> 
#> [[1]]$user$id
#> [1] 1
#> 
#> [[1]]$user$genotypes
#> [[1]]$user$genotypes[[1]]
#> [[1]]$user$genotypes[[1]]$genotype_id
#> [1] 9
#> 
#> [[1]]$user$genotypes[[1]]$local_genotype
#> [1] "AT"
#> 
#> 
#> 
#> 
#> 
#> [[2]]
#> [[2]]$snp
#> [[2]]$snp$name
#> [1] "rs9939609"
#> 
#> [[2]]$snp$chromosome
#> [1] "16"
#> 
#> [[2]]$snp$position
#> [1] "53786615"
#> 
#> 
#> [[2]]$user
#> [[2]]$user$name
#> [1] "Senficon"
#> 
#> [[2]]$user$id
#> [1] 2
#> 
#> [[2]]$user$genotypes
#> list()
```

### Phenotype user data

Get phenotype data for one or multiple users


```r
phenotypes(userid=1)$phenotypes[1:3]
#> $`white skin`
#> $`white skin`$phenotype_id
#> [1] 4
#> 
#> $`white skin`$variation
#> [1] "Caucasian"
#> 
#> 
#> $`Lactose intolerance`
#> $`Lactose intolerance`$phenotype_id
#> [1] 2
#> 
#> $`Lactose intolerance`$variation
#> [1] "lactose-tolerant"
#> 
#> 
#> $`Eye color`
#> $`Eye color`$phenotype_id
#> [1] 1
#> 
#> $`Eye color`$variation
#> [1] "blue-green"
```



```r
phenotypes(userid='1,6,8', df=TRUE)[[1]][1:10,]
#>                     phenotype phenotypeID        variation
#> 1                  white skin           4        Caucasian
#> 2         Lactose intolerance           2 lactose-tolerant
#> 3                   Eye color           1       blue-green
#> 4                   Hair Type          16         straight
#> 5                      Height          15  Tall ( >180cm )
#> 6              Ability to Tan          14              Yes
#> 7  Short-sightedness (Myopia)          21              low
#> 8                 Beard Color          12           Blonde
#> 9            Colour Blindness          25            False
#> 10                 Strabismus          23            False
```


```r
out <- phenotypes(userid='1-8', df=TRUE)
lapply(out, head)
#> $`Bastian Greshake`
#>             phenotype phenotypeID        variation
#> 1          white skin           4        Caucasian
#> 2 Lactose intolerance           2 lactose-tolerant
#> 3           Eye color           1       blue-green
#> 4           Hair Type          16         straight
#> 5              Height          15  Tall ( >180cm )
#> 6      Ability to Tan          14              Yes
#> 
#> $Senficon
#>   phenotype phenotypeID variation
#> 1   no data     no data   no data
#> 
#> $`no info on user_3`
#>   phenotype phenotypeID variation
#> 1   no data     no data   no data
#> 
#> $`no info on user_4`
#>   phenotype phenotypeID variation
#> 1   no data     no data   no data
#> 
#> $`no info on user_5`
#>   phenotype phenotypeID variation
#> 1   no data     no data   no data
#> 
#> $`Nash Parovoz`
#>                          phenotype phenotypeID        variation
#> 1                       Handedness           3     right-handed
#> 2                        Eye color           1            brown
#> 3                       white skin           4        Caucasian
#> 4              Lactose intolerance           2 lactose-tolerant
#> 5 Ability to find a bug in openSNP           5   extremely high
#> 6           Number of wisdom teeth          57                4
#> 
#> $`no info on user_7`
#>   phenotype phenotypeID variation
#> 1   no data     no data   no data
#> 
#> $`Samantha B. Clark`
#>             phenotype phenotypeID                   variation
#> 1  Mother's eye color         494                       Brown
#> 2          Handedness           3                 left-handed
#> 3 Lactose intolerance           2          lactose-intolerant
#> 4           Eye color           1                       Brown
#> 5      Ability to Tan          14                         Yes
#> 6 Nicotine dependence          20 ex-smoker, 7 cigarettes/day
```

### All known variations

Get all known variations and all users sharing that phenotype for one phenotype(-ID).


```r
phenotypes_byid(phenotypeid=12, return_ = 'desc')
#> $id
#> [1] 12
#> 
#> $characteristic
#> [1] "Beard Color"
#> 
#> $description
#> [1] "coloration of facial hair"
```


```r
phenotypes_byid(phenotypeid=12, return_ = 'knownvars')
#> $known_variations
#> $known_variations[[1]]
#> [1] "Red"
#> 
#> $known_variations[[2]]
#> [1] "Blonde"
#> 
#> $known_variations[[3]]
#> [1] "Red-brown"
#> 
#> $known_variations[[4]]
#> [1] "Red-blonde-brown-black(in diferent parts i have different color,for example near the lips blond-red"
#> 
#> $known_variations[[5]]
#> [1] "No beard-female"
#> 
#> $known_variations[[6]]
#> [1] "Brown-black"
#> 
#> $known_variations[[7]]
#> [1] "Blonde-brown"
#> 
#> $known_variations[[8]]
#> [1] "Black"
#> 
#> $known_variations[[9]]
#> [1] "Dark brown with minor blondish-red"
#> 
#> $known_variations[[10]]
#> [1] "Brown-grey"
#> 
#> $known_variations[[11]]
#> [1] "Red-blonde-brown-black"
#> 
#> $known_variations[[12]]
#> [1] "Blond-brown"
#> 
#> $known_variations[[13]]
#> [1] "Brown, some red"
#> 
#> $known_variations[[14]]
#> [1] "Brown"
#> 
#> $known_variations[[15]]
#> [1] "Brown-gray"
#> 
#> $known_variations[[16]]
#> [1] "Never had a beard"
#> 
#> $known_variations[[17]]
#> [1] "I'm a woman"
#> 
#> $known_variations[[18]]
#> [1] "Black-brown-blonde"
#> 
#> $known_variations[[19]]
#> [1] "Was red-brown now mixed with gray,"
#> 
#> $known_variations[[20]]
#> [1] "Red-blonde-brown"
#> 
#> $known_variations[[21]]
#> [1] "Dark brown w/few blonde & red hairs"
#> 
#> $known_variations[[22]]
#> [1] "Dark blonde with red and light blonde on goatee area."
#> 
#> $known_variations[[23]]
#> [1] "Black with few red hairs"
#> 
#> $known_variations[[24]]
#> [1] "Black, graying"
#> 
#> $known_variations[[25]]
#> [1] "Red, moustache still is, beard mostly white"
#> 
#> $known_variations[[26]]
#> [1] "Blonde/brown-some black-and red on chin-all starting to gray"
#> 
#> $known_variations[[27]]
#> [1] "Dark brown"
#> 
#> $known_variations[[28]]
#> [1] "Every possible color, most hair shafts have more than one color at different points along the shaft"
```


```r
phenotypes_byid(phenotypeid=12, return_ = 'users')[1:10,]
#>    user_id                                                                                           variation
#> 1       22                                                                                                 Red
#> 2        1                                                                                              Blonde
#> 3       26                                                                                           red-brown
#> 4       10 Red-Blonde-Brown-Black(in diferent parts i have different color,for example near the lips blond-red
#> 5       14                                                                                     No beard-female
#> 6       42                                                                                         Brown-black
#> 7       45 Red-Blonde-Brown-Black(in diferent parts i have different color,for example near the lips blond-red
#> 8       16                                                                                        blonde-brown
#> 9        8                                                                                     No beard-female
#> 10     661                                                                                         Brown-black
```

### OpenSNP users


```r
data <- users(df=FALSE)
data[1:2]
#> [[1]]
#> [[1]]$name
#> [1] "gigatwo"
#> 
#> [[1]]$id
#> [1] 31
#> 
#> [[1]]$genotypes
#> list()
#> 
#> 
#> [[2]]
#> [[2]]$name
#> [1] "Anu Acharya"
#> 
#> [[2]]$id
#> [1] 385
#> 
#> [[2]]$genotypes
#> list()
```

## NCBI SNP data

### ld_search

Search for SNPs in Linkage Disequilibrium with a set of SNPs


```r
ld_search("rs420358")
#> Querying SNAP...
#> Querying NCBI for up-to-date SNP annotation information...
#> Done!
#> $rs420358
#>        Proxy      SNP Distance RSquared DPrime GeneVariant GeneName GeneDescription Major Minor   MAF NObserved marker_NCBI organism_NCBI chromosome_NCBI assembly_NCBI alleles_NCBI
#> 4   rs420358 rs420358        0    1.000  1.000  INTERGENIC      N/A             N/A     C     A 0.167       120    rs420358  Homo sapiens               1     GRCh38.p2          G/T
#> 5   rs442418 rs420358      122    1.000  1.000  INTERGENIC      N/A             N/A     C     T 0.167       120    rs442418  Homo sapiens               1     GRCh38.p2          A/G
#> 8   rs718223 rs420358     1168    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167       120    rs718223  Homo sapiens               1     GRCh38.p2          A/G
#> 6   rs453604 rs420358     2947    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167       120    rs453604  Homo sapiens               1     GRCh38.p2          A/G
#> 3   rs372946 rs420358      -70    0.943  1.000  INTERGENIC      N/A             N/A     G     C 0.175       120    rs372946  Homo sapiens               1     GRCh38.p2          C/G
#> 1 rs10889290 rs420358     3987    0.800  1.000  INTERGENIC      N/A             N/A     G     A 0.200       120  rs10889290  Homo sapiens               1     GRCh38.p2          A/G
#> 2 rs10889291 rs420358     4334    0.800  1.000  INTERGENIC      N/A             N/A     C     T 0.200       120  rs10889291  Homo sapiens               1     GRCh38.p2          C/T
#> 7  rs4660403 rs420358     7021    0.800  1.000  INTERGENIC      N/A             N/A     A     G 0.200       120   rs4660403  Homo sapiens               1     GRCh38.p2          A/G
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

### dbSNP

Query NCBI's dbSNP for information on a set of SNPs

An example with both merged SNPs, non-SNV SNPs, regular SNPs, SNPs not found, microsatellite


```r
snps <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
ncbi_snp_query(snps)
#>         Query Chromosome      Marker          Class Gene   Alleles Major Minor    MAF        BP AncestralAllele
#> 1       rs332          7 rs121909001         in-del CFTR     -/TTT  <NA>  <NA>     NA 117559593            <NA>
#> 2    rs420358          1    rs420358            snp <NA>       G,T     G     T     NA  40341239     T,T,T,T,T,T
#> 3   rs1837253          5   rs1837253            snp <NA>       C/T     C     T 0.3822 111066174     T,T,T,T,T,T
#> 4 rs111068718       <NA> rs111068718 microsatellite <NA> (GT)21/24  <NA>  <NA>     NA        NA            <NA>
```
