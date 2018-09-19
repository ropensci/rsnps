pkgname <- "solarius"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('solarius')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("availableTransforms")
### * availableTransforms

flush(stderr()); flush(stdout())

### Name: availableTransforms
### Title: Get a list of available transforms.
### Aliases: availableTransforms

### ** Examples

availableTransforms()



cleanEx()
nameEx("dat30")
### * dat30

flush(stderr()); flush(stdout())

### Name: dat30
### Title: dat30 data set adapted from multic R package
### Aliases: dat30 genocovdat30 mapdat30

### ** Examples

data(dat30)

str(dat30)

plotPed(dat30, 2) # plot the pedigree tree for family #2

## Not run: 
##D kin2 <- solarKinship2(dat30)
##D plotKinship2(kin2)
##D plotKinship2(kin2[1:30, 1:30])
##D 
## End(Not run)
str(genocovdat30)

genocovdat30[1:5, 1:5]
str(mapdat30)

head(mapdat30)



cleanEx()
nameEx("dat50")
### * dat50

flush(stderr()); flush(stdout())

### Name: phenodata
### Title: dat50 data set adapted from FFBSKAT R package
### Aliases: genocovdata genodata kin phenodata snpdata

### ** Examples

data(dat50)

str(phenodata)
plotKinship2(2*kin)
str(genodata)

genodata[1:5, 1:5]
str(genocovdata)

genocovdata[1:5, 1:5]

# compare with the genotypes
genodata[1:5, 1:5]
str(snpdata)

head(snpdata)



cleanEx()
nameEx("loadMulticPhen")
### * loadMulticPhen

flush(stderr()); flush(stdout())

### Name: loadMulticPhen
### Title: Load the complete data set from R package multic
### Aliases: loadMulticPhen

### ** Examples

dat <- loadMulticPhen()
dim(dat)

data(dat30)
dim(dat30)



cleanEx()
nameEx("matchIdNames")
### * matchIdNames

flush(stderr()); flush(stdout())

### Name: matchIdNames
### Title: Match ID column names
### Aliases: matchIdNames

### ** Examples

# @ http://helix.nih.gov/Documentation/solar-6.6.2-doc/91.appendix_1_text.html#load
#solar> help file-pedigree                                                       
#
# The pedigree file consists of one record for each individual in the data
# set.  Each record must include the following fields:
#
#    ego ID, father ID, mother ID, sex
#
# In addition, a family ID is required when ego IDs are not unique across
# the entire data set.  If the data set contains genetically identical
# individuals, an MZ-twin ID must be present (as described below).  If an
# analysis of household effects is planned, a household ID can be included
# (also described below).
#
# The default field names are ID, FA, MO, SEX, FAMID, MZTWIN, and HHID.
#

fields <- c("id", "ID", "ids",
  "famid", "FAMID", "famidity",
  "mo", "MO", "mother", "MOTHER", "MOtrait", "motherland",
  "fa", "FA", "father", "FATHER", "fatherland",
  "sex", "SEX", "sexo")

### ID
# pass: id, ID
# filter: ids
grep("^id$|^ID$", fields, value = TRUE)

### FAMID
grep("^famid$|^FAMID$", fields, value = TRUE)

### MO
grep("^mo$|^MO$|^mother$|^MOTHER$", fields, value = TRUE)

### FA
grep("^fa$|^FA$|^father$|^FATHER$", fields, value = TRUE)

### SEX
grep("^sex$|^SEX$", fields, value = TRUE)




cleanEx()
nameEx("matchMapNames")
### * matchMapNames

flush(stderr()); flush(stdout())

### Name: matchMapNames
### Title: Match map column names
### Aliases: matchMapNames

### ** Examples

data(dat50)
 matchMapNames(names(snpdata))



cleanEx()
nameEx("package.file")
### * package.file

flush(stderr()); flush(stdout())

### Name: package.file
### Title: Alternative to system.file
### Aliases: package.file

### ** Examples

mibddir <- package.file("extdata", "solarOutput", "solarMibds", package = "solarius")
mibddir

list.files(mibddir)



cleanEx()
nameEx("plotKinship2")
### * plotKinship2

flush(stderr()); flush(stdout())

### Name: plotKinship2
### Title: Plot the double kinship matrix
### Aliases: histKinship2 imageKinship2 plotKinship2

### ** Examples

# load `kin` kinship matrix from `dat50` data set
data(dat50)
kin2 <- 2* kin # double kinship matrix

plotKinship2(kin2) # equivalent to `imageKinship2(kin2)`

plotKinship2(kin2, "hist") # equivalent to `histKinship2(kin2)`



cleanEx()
nameEx("plotPed")
### * plotPed

flush(stderr()); flush(stdout())

### Name: plotPed
### Title: Plot the pedigree
### Aliases: plotPed

### ** Examples

data(dat30)
plotPed(dat30, 1)



cleanEx()
nameEx("plotQQManh")
### * plotQQManh

flush(stderr()); flush(stdout())

### Name: plotManh
### Title: Plot the association results
### Aliases: plotManh plotQQ

### ** Examples

## Not run: 
##D data(dat50)
##D 
##D assoc <- solarAssoc(trait ~ 1, phenodata,
##D  snpdata = genodata, snpmap = snpdata, kinship = kin)
##D 
##D plotManh(assoc) # equivalent to plot(assoc)
##D 
##D plotQQ(assoc) # equivalent to plot(assoc, "qq")
##D 
## End(Not run)



cleanEx()
nameEx("plotRes")
### * plotRes

flush(stderr()); flush(stdout())

### Name: plotRes
### Title: Plot the residuals of a polygenic model
### Aliases: plotRes plotResQQ

### ** Examples

## Not run: 
##D ### basic (univariate) polygenic model
##D mod <- solarPolygenic(trait1 ~ age + sex, dat30)
##D 
##D plotRes(mod)
##D 
##D plotResQQ(mod)
##D 
## End(Not run)



cleanEx()
nameEx("snp2solar")
### * snp2solar

flush(stderr()); flush(stdout())

### Name: snpdata2solar
### Title: Export snp genotypes, genotype covariates and amp to SOLAR
### Aliases: snpcovdata2solar snpdata2solar snpmap2solar

### ** Examples

# Example of `snp.genocov` file:
# id,nGTypes,snp_s1,snp_s2,...
# 1,50,0,0,...
# 2,50,0,0,...

# Example of `snp.geno-list` file:
# snp_s1
# snp_s2
# ...



cleanEx()
nameEx("solarAssoc")
### * solarAssoc

flush(stderr()); flush(stdout())

### Name: solarAssoc
### Title: Run association analysis.
### Aliases: solarAssoc

### ** Examples

### load data
data(dat50)
dim(phenodata)
dim(kin)
dim(genodata)

## Not run: 
##D ### basic (univariate) association model with a custom kinship
##D mod <- solarAssoc(trait~age+sex, phenodata,
##D   kinship = kin, snpdata = genodata)
##D mod$snpf # table of results for 50 SNPs
## End(Not run)



cleanEx()
nameEx("solarMultipoint")
### * solarMultipoint

flush(stderr()); flush(stdout())

### Name: solarMultipoint
### Title: Run multipoint linkage analysis.
### Aliases: solarMultipoint

### ** Examples

### load phenotype data
data(dat30)

### load marker data
mibddir <- system.file('extdata', 'solarOutput',
  'solarMibdsCsv', package = 'solarius')
list.files(mibddir)

## Not run: 
##D ### basic (univariate) linkage model
##D mod <- solarMultipoint(trait1 ~ 1, dat30,
##D   mibddir = mibddir, chr = 5)
##D mod$lodf # table of results (LOD scores) (the highest 3.56)
##D 
##D ### basic (bivariate) linkage model
##D mod <- solarMultipoint(trait1 + trait2 ~ 1, dat30,
##D   mibddir = mibddir, chr = 5)
##D mod$lodf # table of results (LOD scores) (the highest 2.74)
##D 
##D ### two-pass linkage model
##D mod <- solarMultipoint(trait1 ~ 1, dat30,
##D   mibddir = mibddir, chr = 5,
##D   multipoint.options = "3")
##D mod$lodf # table of results (LOD scores, 1 pass) (the highest 2.74)
##D mod$lodf2 # table of results (LOD scores, 2 pass) (all nearly zero LOD scores)
##D 
## End(Not run)



cleanEx()
nameEx("solarPolygenic")
### * solarPolygenic

flush(stderr()); flush(stdout())

### Name: solarPolygenic
### Title: Run polygenic analysis.
### Aliases: solarPolygenic

### ** Examples

### load data and check out ID names
data(dat30)
matchIdNames(names(dat30))

## Not run: 
##D ### basic (univariate) polygenic model
##D mod <- solarPolygenic(trait1 ~ age + sex, dat30)
##D 
##D ### (univariate) polygenic model with parameters
##D mod <- solarPolygenic(trait1 ~ age + sex, dat30, covtest = TRUE)
##D mod$cf # look at test statistics for covariates
##D 
##D ### basic (bivariate) polygenic model
##D mod <- solarPolygenic(trait1 + trait2 ~ 1, dat30)
##D mod$vcf # look at variance components
##D 
##D ### (bivariate) polygenic model with trait specific covariates
##D mod <- solarPolygenic(trait1 + trait2 ~ age + sex(trait1), dat30)
##D 
##D ### (bivariate) polygenic model with a test of the genetic correlation
##D mod <- solarPolygenic(trait1 + trait2 ~ 1, dat30, polygenic.options = "-testrhog")
##D mod$lf # look at a p-value of the test
##D 
##D ### transforms for (univariate) polygenic model
##D mod <- mod <- solarPolygenic(trait1 ~ 1, dat30, transforms = "log")
##D 
##D ### transforms for (bivariate) polygenic model
##D mod <- solarPolygenic(trait1 + trait2 ~ 1, dat30,
##D    transforms = c(trait1 = "log", trait2 = "inormal"))
##D 
##D ### SOLAR format of introducing covariates
##D mod <- solarPolygenic(traits = "trait1", covlist = "age^1,2,3#sex", data =  dat30)
##D mod$cf # 8 covariate terms will be printed
##D 
## End(Not run)



cleanEx()
nameEx("transformTrait")
### * transformTrait

flush(stderr()); flush(stdout())

### Name: transformTrait
### Title: Transform a trait.
### Aliases: transformTrait

### ** Examples

library(plyr)
library(ggplot2)

data(dat30)
dat <- mutate(dat30,
   inormal_trait1 = transformTrait(trait1, "inormal"))

ggplot(dat, aes(trait1)) + geom_histogram()
ggplot(dat, aes(inormal_trait1)) + geom_histogram()



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
