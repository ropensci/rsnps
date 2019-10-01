context("ncbi_snp_query")

test_that("ncbi_snp_query for rs1173690113 (merged into rs333)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1173690113
  
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1173690113")
  
  
  expect_equal(aa$Query, "rs1173690113")
  expect_equal(aa$Chromosome, "3")
  expect_equal(aa$BP, 46373453) ## on GRCh38
  expect_equal(aa$Marker, "rs333")
  expect_equal(aa$Class, "delins")
  expect_equal(aa$Gene, "CCR5,LOC102724297")
  expect_equal(aa$Alleles, "GTCAGTATCAATTCTGGAAGAATTTCCAGACA,ACA")
  expect_equal(aa$Minor, "delGTCAGTATCAATTCTGGAAGAATTTCCAGACA") 
  expect_equal(aa$MAF, 0.077)
  expect_equal(aa$AncestralAllele, "GTCAGTATCAATTCTGGAAGAATTTCCAGACA")
  expect_equal(aa$VariationAllele, "ACA")
  
})


test_that("ncbi_snp_query for rs1421085", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/?term=rs1421085
  
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1421085")
  
  
  expect_equal(aa$Chromosome, "16")
  expect_equal(aa$BP, 53767042) ## on GRCh38
  expect_equal(aa$Marker, "rs1421085")
  expect_equal(aa$Class, "snv")
  expect_equal(aa$Gene, "FTO")
  expect_equal(aa$Alleles, "T,C")
  expect_equal(aa$AncestralAllele, "T")
  expect_equal(aa$VariationAllele, "C")
  expect_equal(aa$MAF, 0.3164)
  expect_equal(aa$Minor, "C")
  
})


test_that("ncbi_snp_query for rs1610720 (multiple alleles)", {
  ## from issue59: https://github.com/ropensci/rsnps/issues/59
  ## truth: https://www.ncbi.nlm.nih.gov/snp/?term=rs1610720
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1610720")
  
  
  expect_equal(aa$Chromosome, "6")
  expect_equal(aa$BP, 29793285) ## on GRCh38
  expect_equal(aa$Marker, "rs1610720")
  expect_equal(aa$Class, "snv")
  expect_equal(aa$Gene, "HCG4/HLA-V")
  expect_equal(aa$Alleles, "A,G,T")
  expect_equal(aa$AncestralAllele, "A")
  expect_equal(aa$VariationAllele, "G,T")
  expect_equal(aa$MAF, 0.3895)
  expect_equal(aa$Minor, "G")
  
})

test_that("ncbi_snp_query for rs146107628 (duplication)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs146107628
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs146107628")
  
  
  expect_equal(aa$Chromosome, "10")
  expect_equal(aa$BP, 98243085) ## on GRCh38
  expect_equal(aa$Marker, "rs146107628")
  expect_equal(aa$Class, "delins")
  expect_equal(aa$Gene, "R3HCC1L")
  expect_equal(aa$Alleles, "T,TT")
  expect_equal(aa$AncestralAllele, "T")
  expect_equal(aa$VariationAllele, "TT")
  expect_equal(aa$MAF, 0.0365) ## fix!!
  expect_equal(aa$Minor, "T")  ## fix!!
  
})

test_that("ncbi_snp_query for rs200623867 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs200623867
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs200623867")
  
  
  expect_equal(aa$Chromosome, "10")
  expect_equal(aa$BP, 98243545) ## on GRCh38
  expect_equal(aa$Marker, "rs200623867")
  expect_equal(aa$Class, "del")
  expect_equal(aa$Gene, "R3HCC1L")
  expect_equal(aa$Alleles, "G,-")
  expect_equal(aa$AncestralAllele, "G")
  expect_equal(aa$VariationAllele, "-")
  expect_equal(aa$MAF, NA) ##fix
  expect_equal(aa$Minor, NA)  ##fix
  
  
})


test_that("ncbi_snp_query for rs1799752 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1799752
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1799752")
  
  
  expect_equal(aa$Chromosome, "17")
  expect_equal(aa$BP, 63488530) ## on GRCh38 :63488530-63488543
  expect_equal(aa$Marker, "rs1799752")
  expect_equal(aa$Class, "indel")
  expect_equal(aa$Gene, "ACE")
  expect_equal(aa$Alleles, "ATACAGTCACTTTT,ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  expect_equal(aa$Major, "ATACAGTCACTTTT")
  expect_equal(aa$Minor, "ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  expect_equal(aa$MAF, NA)
  expect_equal(aa$AncestralAllele, "ATACAGTCACTTTT")
  
})


test_that("ncbi_snp_query works", {
  skip_on_cran()

  aa <- ncbi_snp_query("rs420358")

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, c('Query', 'Chromosome', 'BP', 'Marker', 'Class', 'Gene',
                'Alleles', 'Minor', 'MAF', 'AncestralAllele', 'VariationAllele'))
})

test_that("ncbi_snp_query - many snps at once works", {
  skip_on_cran()

  x <- c("rs420358", "rs1837253", "rs1209415715")
  aa <- ncbi_snp_query(x)

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, c('Query', 'Chromosome', 'BP', 'Marker', 'Class', 'Gene',
                     'Alleles', 'Minor', 'MAF', 'AncestralAllele', 'VariationAllele'))
  expect_gt(NROW(aa), 2)
})

test_that("ncbi_snp_query - rs IDs not found", {
  skip_on_cran()

  expect_warning(z <- ncbi_snp_query('rs111068718'), "had no information")
  expect_equal(NROW(z), 0)
})

test_that("ncbi_snp_query - gives warning when expected", {
  skip_on_cran()

  expect_warning(ncbi_snp_query('rs332'))
})

test_that("ncbi_snp_query fails well", {
  skip_on_cran()

  expect_error(ncbi_snp_query(), "argument \"SNPs\" is missing")
  expect_error(ncbi_snp_query(5), "not all items supplied are prefixed")
  expect_error(ncbi_snp_query('ab5'), "not all items supplied are prefixed")
})
