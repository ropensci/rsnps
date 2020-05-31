context("ncbi_snp_query")

test_that("ncbi_snp_query for rs1173690113 (merged into rs333)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1173690113
  
  skip_on_cran()
  
  expect_warning(aa <- ncbi_snp_query("rs1173690113"), "rs1173690113 has been merged into rs333")

  expect_equal(aa$Query, "rs1173690113")
  expect_equal(aa$Chromosome, "3")
  expect_equal(aa$BP, 46373453) ## on GRCh38
  expect_equal(aa$rsid, "rs333")
  expect_equal(aa$Class, "delins")
  expect_equal(aa$Gene, "CCR5/CCR5AS")
  expect_equal(aa$Alleles, "ACAGTCAGTATCAATTCTGGAAGAATTTCCAGACA,ACA")
  expect_equal(aa$Minor, "delACAGTCAGTATCAATTCTGGAAGAATTTCCAG")
  expect_equal(aa$MAF, 0.0774)
  expect_equal(aa$AncestralAllele, "ACAGTCAGTATCAATTCTGGAAGAATTTCCAGACA")
  expect_equal(aa$VariationAllele, "ACA")
  
})


test_that("ncbi_snp_query for rs1421085", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/?term=rs1421085
  
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1421085")
  
  
  expect_equal(aa$Chromosome, "16")
  expect_equal(aa$BP, 53767042) ## on GRCh38
  expect_equal(aa$rsid, "rs1421085")
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
  expect_equal(aa$rsid, "rs1610720")
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
  expect_equal(aa$rsid, "rs146107628")
  expect_equal(aa$Class, "delins")
  expect_equal(aa$Gene, "R3HCC1L")
  expect_equal(aa$Alleles, "T,TT")
  expect_equal(aa$AncestralAllele, "T")
  expect_equal(aa$VariationAllele, "TT")
  expect_equal(aa$MAF, 0.0365) 
  expect_equal(aa$Minor, "dupT") 
  
})

test_that("ncbi_snp_query for rs200623867 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs200623867
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs200623867")
  
  
  expect_equal(aa$Chromosome, "10")
  expect_equal(aa$BP, 98243545) ## on GRCh38
  expect_equal(aa$rsid, "rs200623867")
  expect_equal(aa$Class, "del")
  expect_equal(aa$Gene, "R3HCC1L")
  expect_equal(aa$Alleles, "G, delG")
  expect_equal(aa$AncestralAllele, "G")
  expect_equal(aa$VariationAllele, "delG")
  expect_equal(aa$MAF, NA_real_) 
  expect_equal(aa$Minor, NA_character_) 
  
})


test_that("ncbi_snp_query for rs1799752 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1799752
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1799752")
  
  
  expect_equal(aa$Chromosome, "17")
  expect_equal(aa$BP, 63488530) ## on GRCh38 :63488530-63488543
  expect_equal(aa$rsid, "rs1799752")
  expect_equal(aa$Class, "delins")
  expect_equal(aa$Gene, "ACE")
  expect_equal(aa$Alleles, "ATACAGTCACTTTT,ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  expect_equal(aa$Minor, NA_character_)
  expect_equal(aa$MAF, NA_real_)
  expect_equal(aa$AncestralAllele, "ATACAGTCACTTTT")
  expect_equal(aa$VariationAllele, "ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  
})


test_that("ncbi_snp_query for rs1610720 snp", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1610720
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1610720")
  
  expect_equal(aa$Chromosome, "6")
  expect_equal(aa$BP, 29793285) ## on GRCh38
  expect_equal(aa$rsid, "rs1610720")
  expect_equal(aa$Class, "snv")
  expect_equal(aa$Gene, "HCG4/HLA-V")
  expect_equal(aa$Alleles, "A,G,T")
  expect_equal(aa$Minor, "G")
  expect_equal(aa$MAF, 0.3895)
  expect_equal(aa$AncestralAllele, "A")
  expect_equal(aa$VariationAllele, "G,T")
  
})


expected_df_names <- c("Query", "Chromosome", "BP", "Class", "rsid", "Gene", "Alleles", "AncestralAllele", "VariationAllele", "seqname", "hgvs", "assembly", "ref_seq", "Minor", "MAF")

test_that("ncbi_snp_query works", {
  skip_on_cran()

  aa <- ncbi_snp_query("rs420358")

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, expected_df_names)
})

test_that("ncbi_snp_query - many snps at once works", {
  skip_on_cran()

  x <- c("rs420358", "rs1837253", "rs1209415715")
  aa <- ncbi_snp_query(x)

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, expected_df_names)
  expect_gt(NROW(aa), 2)
})


test_that("ncbi_snp_query - many snps at once works with some that give errors", {
  skip_on_cran()
  
  x <- c("rs420358", "rs1", "rs1209415715") ## rs1 does not exist
  expect_warning(aa <- ncbi_snp_query(x), "The following rsId had no information available on NCBI:") 
  
  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, expected_df_names)
  expect_equal(NROW(aa), 2)
})

test_that("ncbi_snp_query - rs IDs not found", {
  skip_on_cran()

  expect_warning(z <- ncbi_snp_query("rs111068718"), "The following rsId has been withdrawn from NCBI:")
  expect_equal(NROW(z), 0)
})

test_that("ncbi_snp_query - gives warning when expected", {
  skip_on_cran()

  expect_warning(ncbi_snp_query('rs332'))
  expect_warning(ncbi_snp_query('rs1'), "The following rsId had no information available on NCBI:")

  
})

test_that("ncbi_snp_query fails well", {
  skip_on_cran()

  expect_error(ncbi_snp_query(), "argument \"SNPs\" is missing")
  expect_error(ncbi_snp_query(5), "not all items supplied are prefixed")
  expect_error(ncbi_snp_query('ab5'), "not all items supplied are prefixed")

})



