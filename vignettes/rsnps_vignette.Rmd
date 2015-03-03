<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rsnps tutorial}
-->



rsnps tutorial
==========

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
#> [1] "R.M. Holston"
#> 
#> [[1]]$user$id
#> [1] 22
#> 
#> [[1]]$user$genotypes
#> [[1]]$user$genotypes[[1]]
#> [[1]]$user$genotypes[[1]]$genotype_id
#> [1] 8
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
#> [1] "Mom to AG"
#> 
#> [[2]]$user$id
#> [1] 387
#> 
#> [[2]]$user$genotypes
#> [[2]]$user$genotypes[[1]]
#> [[2]]$user$genotypes[[1]]$genotype_id
#> [1] 173
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
#> [1] "Dan Bolser"
#> 
#> [[3]]$user$id
#> [1] 254
#> 
#> [[3]]$user$genotypes
#> list()
```


```r
allgensnp('rs7412', df=TRUE)[1:10,]
#>    snp_name snp_chromosome snp_position         user_name user_id genotype_id genotype   NA   NA   NA
#> 1    rs7412             19     44908822      R.M. Holston      22           8       CC <NA> <NA> <NA>
#> 2    rs7412             19     44908822         Mom to AG     387         173       CC <NA> <NA> <NA>
#> 3    rs7412             19     44908822        Dan Bolser     254        <NA>     <NA> <NA> <NA> <NA>
#> 4    rs7412             19     44908822                Lb      14           6       CC <NA> <NA> <NA>
#> 5    rs7412             19     44908822 Glenn Allen Nolen      19           7       CC <NA> <NA> <NA>
#> 6    rs7412             19     44908822          kevinmcc     285         118       CC <NA> <NA> <NA>
#> 7    rs7412             19     44908822            Sigrid     569         260       CC <NA> <NA> <NA>
#> 8    rs7412             19     44908822        Razib Khan      33          12       CT <NA> <NA> <NA>
#> 9    rs7412             19     44908822             sagan      13           4       CC <NA> <NA> <NA>
#> 10   rs7412             19     44908822   William Vencill     581         266       CC <NA> <NA> <NA>
#>      NA   NA   NA   NA   NA   NA   NA   NA
#> 1  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 2  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 3  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 4  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 5  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 6  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 7  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 8  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 9  <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
#> 10 <NA> <NA> <NA> <NA> <NA> <NA> <NA> <NA>
```


### All Phenotypes

Get all phenotypes, their variations, and how many users have data available for a given phenotype

Get all data


```r
allphenotypes(df = TRUE)[1:10,]
#>    id characteristic                   known_variations number_of_users
#> 1   1      Eye color                              Brown             672
#> 2   1      Eye color                        Brown-green             672
#> 3   1      Eye color                         Blue-green             672
#> 4   1      Eye color                          Blue-grey             672
#> 5   1      Eye color                              Green             672
#> 6   1      Eye color                               Blue             672
#> 7   1      Eye color                              Hazel             672
#> 8   1      Eye color                              Mixed             672
#> 9   1      Eye color                          Gray-blue             672
#> 10  1      Eye color Blue-grey; broken amber collarette             672
```

Output a list, then call the characterisitc of interest by 'id' or 'characteristic'


```r
datalist <- allphenotypes()
```

Get a list of all characteristics you can call


```r
names(datalist)[1:10]
#>  [1] "Eye color"           "Handedness"          "Height"              "Sex"                
#>  [5] "Hair Color"          "Tongue roller"       "Colour Blindness"    "Hair Type"          
#>  [9] "Lactose intolerance" "Astigmatism"
```

Get data.frame for _ADHD_


```r
datalist[["ADHD"]]
#>   id characteristic                            known_variations number_of_users
#> 1 29           ADHD                                       False             167
#> 2 29           ADHD                                        True             167
#> 3 29           ADHD              Undiagnosed, but probably true             167
#> 4 29           ADHD                                          No             167
#> 5 29           ADHD                                         Yes             167
#> 6 29           ADHD                               Not diagnosed             167
#> 7 29           ADHD Diagnosed as not having but with some signs             167
#> 8 29           ADHD                                 Mthfr c677t             167
#> 9 29           ADHD                                   Rs1801260             167
```

Get data.frame for _mouth size_ and _SAT Writing_


```r
datalist[c("mouth size","SAT Writing")]
#> $`mouth size`
#>    id characteristic known_variations number_of_users
#> 1 120     mouth size           Medium              98
#> 2 120     mouth size            Small              98
#> 3 120     mouth size            Large              98
#> 
#> $`SAT Writing`
#>    id characteristic                                        known_variations number_of_users
#> 1  41    SAT Writing                                                     750              66
#> 2  41    SAT Writing                                      Tested before 2005              66
#> 3  41    SAT Writing                                                     800              66
#> 4  41    SAT Writing                                     Country with no sat              66
#> 5  41    SAT Writing                                                     N/a              66
#> 6  41    SAT Writing                                 Never & have ba & above              66
#> 7  41    SAT Writing                                                     720              66
#> 8  41    SAT Writing                         Did well - don't remember score              66
#> 9  41    SAT Writing                                                     511              66
#> 10 41    SAT Writing                                                     700              66
#> 11 41    SAT Writing                                                     760              66
#> 12 41    SAT Writing                                                     780              66
#> 13 41    SAT Writing Not part of sat when i took test in august 1967 at uiuc              66
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
#>                author
#> 1 Marguerite R. Irvin
#> 2        Huixiao Hong
#>                                                                                                                                            title
#> 1 Genome-Wide Detection of Allele Specific Copy Number Variation Associated with Insulin Resistance in African Americans from the HyperGEN Study
#> 2                                                     Technical Reproducibility of Genotyping SNP Arrays Used in Genome-Wide Association Studies
#>       publication_date number_of_readers                                            url
#> 1 2011-08-25T00:00:00Z              2509 http://dx.doi.org/10.1371/journal.pone.0024052
#> 2 2012-09-07T00:00:00Z              3052 http://dx.doi.org/10.1371/journal.pone.0044483
#>                            doi
#> 1 10.1371/journal.pone.0024052
#> 2 10.1371/journal.pone.0044483
```

Just from SNPedia


```r
annotations(snp = 'rs7903146', output = 'snpedia')
#>                                               url
#> 1 http://www.snpedia.com/index.php/Rs7903146(C;C)
#> 2 http://www.snpedia.com/index.php/Rs7903146(C;T)
#> 3 http://www.snpedia.com/index.php/Rs7903146(T;T)
#>                                                            summary
#> 1 Normal (lower) risk of Type 2 Diabetes and Gestational Diabetes.
#> 2     1.4x increased risk for diabetes (and perhaps colon cancer).
#> 3                            2x increased risk for Type-2 diabetes
```

Get all annotations


```r
annotations(snp = 'rs7903146', output = 'all')[1:5,]
#>        .id                      author
#> 1 mendeley        Dhanasekaran Bodhini
#> 2 mendeley Ludmila Alves Sanches Dutra
#> 3 mendeley               Thomas Hansen
#> 4 mendeley    Laura J Rasmussen-Torvik
#> 5 mendeley                      Yu Yan
#>                                                                                                                                                                           title
#> 1                                        The rs12255372(G/T) and rs7903146(C/T) polymorphisms of the TCF7L2 gene are associated with type 2 diabetes mellitus in Asian Indians.
#> 2                                                            Allele-specific PCR assay to genotype SNP rs7903146 in TCF7L2 gene for rapid screening of diabetes susceptibility.
#> 3                                                                                               At-Risk Variant in TCF7L2 for Type II Diabetes Increases Risk of Schizophrenia.
#> 4                                           Preliminary report: No association between TCF7L2 rs7903146 and euglycemic-clamp-derived insulin sensitivity in a mixed-age cohort.
#> 5 The transcription factor 7-like 2 (TCF7L2) polymorphism may be associated with focal arteriolar narrowing in Caucasians with hypertension or without diabetes: the ARIC Study
#>   publication_year number_of_readers open_access
#> 1             2007                 8       FALSE
#> 2             2008                 5       FALSE
#> 3             2011                 1       FALSE
#> 4             2009                 3       FALSE
#> 5             2010                 5        TRUE
#>                                                                                                                                                                      url
#> 1                               http://www.mendeley.com/research/rs12255372-g-t-rs7903146-c-t-polymorphisms-tcf7l2-gene-associated-type-2-diabetes-mellitus-asian-ind-1/
#> 2                     http://www.mendeley.com/research/allelespecific-pcr-assay-to-genotype-snp-rs7903146-in-tcf7l2-gene-for-rapid-screening-of-diabetes-susceptibility/
#> 3                                                                  http://www.mendeley.com/research/atrisk-variant-tcf7l2-type-ii-diabetes-increases-risk-schizophrenia/
#> 4                   http://www.mendeley.com/research/preliminary-report-association-between-tcf7l2-rs7903146-euglycemicclampderived-insulin-sensitivity-mixedage-cohort/
#> 5 http://www.mendeley.com/research/transcription-factor-7like-2-tcf7l2-polymorphism-associated-focal-arteriolar-narrowing-caucasians-hypertension-diabetes-aric-study-7/
#>                              doi publication_date summary first_author pubmed_link journal trait pvalue
#> 1                           none             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA
#> 2                           none             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA
#> 3 10.1016/j.biopsych.2011.01.031             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA
#> 4                           none             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA
#> 5         10.1186/1472-6823-10-9             <NA>    <NA>         <NA>        <NA>    <NA>  <NA>     NA
#>   pvalue_description confidence_interval
#> 1               <NA>                <NA>
#> 2               <NA>                <NA>
#> 3               <NA>                <NA>
#> 4               <NA>                <NA>
#> 5               <NA>                <NA>
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
#> 1          Handedness           3                 left-handed
#> 2 Lactose intolerance           2          lactose-intolerant
#> 3           Eye color           1                       Brown
#> 4      Ability to Tan          14                         Yes
#> 5 Nicotine dependence          20 ex-smoker, 7 cigarettes/day
#> 6          Hair Color          13                       brown
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
```


```r
phenotypes_byid(phenotypeid=12, return_ = 'users')[1:10,]
#>    user_id
#> 1       22
#> 2        1
#> 3       26
#> 4       10
#> 5       14
#> 6       42
#> 7       45
#> 8       16
#> 9        8
#> 10     661
#>                                                                                              variation
#> 1                                                                                                  Red
#> 2                                                                                               Blonde
#> 3                                                                                            red-brown
#> 4  Red-Blonde-Brown-Black(in diferent parts i have different color,for example near the lips blond-red
#> 5                                                                                      No beard-female
#> 6                                                                                          Brown-black
#> 7  Red-Blonde-Brown-Black(in diferent parts i have different color,for example near the lips blond-red
#> 8                                                                                         blonde-brown
#> 9                                                                                      No beard-female
#> 10                                                                                         Brown-black
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

### LDSearch

Search for SNPs in Linkage Disequilibrium with a set of SNPs


```r
LDSearch("rs420358")
#> Querying SNAP...
#> Querying NCBI for up-to-date SNP annotation information...
#> Done!
#> $rs420358
#>        Proxy      SNP Distance RSquared DPrime GeneVariant GeneName GeneDescription Major Minor   MAF
#> 4   rs420358 rs420358        0    1.000  1.000  INTERGENIC      N/A             N/A     C     A 0.167
#> 5   rs442418 rs420358      122    1.000  1.000  INTERGENIC      N/A             N/A     C     T 0.167
#> 8   rs718223 rs420358     1168    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167
#> 6   rs453604 rs420358     2947    1.000  1.000  INTERGENIC      N/A             N/A     A     G 0.167
#> 3   rs372946 rs420358      -70    0.943  1.000  INTERGENIC      N/A             N/A     G     C 0.175
#> 1 rs10889290 rs420358     3987    0.800  1.000  INTERGENIC      N/A             N/A     G     A 0.200
#> 2 rs10889291 rs420358     4334    0.800  1.000  INTERGENIC      N/A             N/A     C     T 0.200
#> 7  rs4660403 rs420358     7021    0.800  1.000  INTERGENIC      N/A             N/A     A     G 0.200
#>   NObserved Chromosome_NCBI Marker_NCBI Class_NCBI Gene_NCBI Alleles_NCBI Major_NCBI Minor_NCBI MAF_NCBI
#> 4       120               1    rs420358        snp      <NA>          G,T          G          T       NA
#> 5       120               1    rs442418        snp      <NA>          A/G          A          G   0.0723
#> 8       120               1    rs718223        snp      <NA>          A/G          A          G   0.0723
#> 6       120               1    rs453604        snp      <NA>          A/G          A          G   0.0727
#> 3       120               1    rs372946        snp      <NA>          C,G          C          G       NA
#> 1       120               1  rs10889290        snp      <NA>          A/G          G          A   0.0841
#> 2       120               1  rs10889291        snp      <NA>          C/T          C          T   0.0839
#> 7       120               1   rs4660403        snp      <NA>          A/G          A          G   0.0827
#>    BP_NCBI
#> 4 40341238
#> 5 40341360
#> 8 40342406
#> 6 40344185
#> 3 40341168
#> 1 40345225
#> 2 40345572
#> 7 40348259
```

### dbSNP

Query NCBI's dbSNP for information on a set of SNPs

An example with both merged SNPs, non-SNV SNPs, regular SNPs, SNPs not found, microsatellite


```r
snps <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
NCBI_snp_query(snps)
#>         Query Chromosome      Marker          Class Gene   Alleles Major Minor    MAF        BP
#> 1       rs332          7 rs121909001         in-del CFTR     -/TTT  <NA>  <NA>     NA 117559592
#> 2    rs420358          1    rs420358            snp <NA>       G,T     G     T     NA  40341238
#> 3   rs1837253          5   rs1837253            snp <NA>       C/T     C     T 0.3822 111066173
#> 4 rs111068718       <NA> rs111068718 microsatellite <NA> (GT)21/24  <NA>  <NA>     NA        NA
```
