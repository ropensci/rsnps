context("ncbi_snp_query")

test_that("ncbi_snp_query for rs1173690113 (merged into rs333)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1173690113
  
  skip_on_cran()
  
  expect_warning(aa <- ncbi_snp_query("rs1173690113"), "rs1173690113 has been merged into rs333")

  expect_equal(aa$query, "rs1173690113")
  expect_equal(aa$chromosome, "3")
  expect_equal(aa$bp, 46373453) ## on GRCh38
  expect_equal(aa$rsid, "rs333")
  expect_equal(aa$class, "delins")
  expect_equal(aa$gene, "CCR5/CCR5AS")
  expect_equal(aa$alleles, "ACAGTCAGTATCAATTCTGGAAGAATTTCCAGACA,ACA")
  expect_equal(aa$minor, "delACAGTCAGTATCAATTCTGGAAGAATTTCCAG")
  expect_equal(aa$maf, 0.0774, tolerance = 1e-2)
  expect_equal(aa$ancestral_allele, "ACAGTCAGTATCAATTCTGGAAGAATTTCCAGACA")
  expect_equal(aa$variation_allele, "ACA")
  
  maf_pop <- aa$maf_population[[1]]
  expect_equal(maf_pop[maf_pop$study == "ALSPAC" & maf_pop$ref_seq == "ACAGTCAGTATCAATTCTGGAAGAATTTCCAG" & maf_pop$Minor == "delACAGTCAGTATCAATTCTGGAAGAATTTCCAG" ,"MAF"], 0.09366892, tolerance = 1e-2)
  expect_equal(maf_pop[maf_pop$study == "Estonian" & maf_pop$ref_seq == "ACAGTCAGTATCAATTCTGGAAGAATTTCCAG" & maf_pop$Minor == "delACAGTCAGTATCAATTCTGGAAGAATTTCCAG","MAF"], 0.11785714, tolerance = 1e-2)
  
  
})


test_that("ncbi_snp_query for rs1421085", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/?term=rs1421085
  
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1421085")
  
  
  expect_equal(aa$chromosome, "16")
  expect_equal(aa$bp, 53767042) ## on GRCh38
  expect_equal(aa$rsid, "rs1421085")
  expect_equal(aa$class, "snv")
  expect_equal(aa$gene, "FTO")
  expect_equal(aa$alleles, "T,C")
  expect_equal(aa$ancestral_allele, "T")
  expect_equal(aa$variation_allele, "C")
  expect_equal(aa$maf, 0.3063, tolerance = 1e-2)
  expect_equal(aa$minor, "C")
  
  maf_pop <- aa$maf_population[[1]]
  expect_equal(maf_pop[maf_pop$study == "HapMap" & maf_pop$ref_seq == "T" & maf_pop$Minor == "C" ,"MAF"], 0.2085987, tolerance=1e-2)
  expect_equal(maf_pop[maf_pop$study == "Vietnamese" & maf_pop$ref_seq == "T" & maf_pop$Minor == "C","MAF"], 0.1495327, tolerance=1e-2)
  
  
})


test_that("ncbi_snp_query for rs1610720 (multiple alleles)", {
  ## from issue59: https://github.com/ropensci/rsnps/issues/59
  ## truth: https://www.ncbi.nlm.nih.gov/snp/?term=rs1610720
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1610720")
  
  
  expect_equal(aa$chromosome, "6")
  expect_equal(aa$bp, 29793285) ## on GRCh38
  expect_equal(aa$rsid, "rs1610720")
  expect_equal(aa$class, "snv")
  expect_equal(aa$gene, "HCG4/HLA-V")
  expect_equal(aa$alleles, "A,G,T")
  expect_equal(aa$ancestral_allele, "A")
  expect_equal(aa$variation_allele, "G,T")
  expect_equal(aa$maf, 0.4170, tolerance = 1e-2)
  expect_equal(aa$minor, "G")
  
  
})

test_that("ncbi_snp_query for rs146107628 (duplication)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs146107628
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs146107628")
  
  
  expect_equal(aa$chromosome, "10")
  expect_equal(aa$bp, 98243085) ## on GRCh38
  expect_equal(aa$rsid, "rs146107628")
  expect_equal(aa$class, "delins")
  expect_equal(aa$gene, "R3HCC1L")
  expect_equal(aa$alleles, "T,TT")
  expect_equal(aa$ancestral_allele, "T")
  expect_equal(aa$variation_allele, "TT")
  expect_equal(aa$maf, 0.0365, tolerance = 1e-2) 
  expect_equal(aa$minor, "dupT") 
  
})

test_that("ncbi_snp_query for rs200623867 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs200623867
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs200623867")
  
  
  expect_equal(aa$chromosome, "10")
  expect_equal(aa$bp, 98243545) ## on GRCh38
  expect_equal(aa$rsid, "rs200623867")
  expect_equal(aa$class, "del")
  expect_equal(aa$gene, "R3HCC1L")
  expect_equal(aa$alleles, "G, delG")
  expect_equal(aa$ancestral_allele, "G")
  expect_equal(aa$variation_allele, "delG")
  expect_equal(aa$maf, NA_real_) 
  expect_equal(aa$minor, NA_character_) 
  
})


test_that("ncbi_snp_query for rs1799752 (deletion)", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1799752
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1799752")
  
  
  expect_equal(aa$chromosome, "17")
  expect_equal(aa$bp, 63488530) ## on GRCh38 :63488530-63488543
  expect_equal(aa$rsid, "rs1799752")
  expect_equal(aa$class, "delins")
  expect_equal(aa$gene, "ACE")
  expect_equal(aa$alleles, "ATACAGTCACTTTT,ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  expect_equal(aa$minor, NA_character_)
  expect_equal(aa$maf, NA_real_)
  expect_equal(aa$ancestral_allele, "ATACAGTCACTTTT")
  expect_equal(aa$variation_allele, "ATACAGTCACTTTTTTTTTTTTTTTGAGACGGAGTCTCGCTCTGTCGCCCATACAGTCACTTTT")
  
})


test_that("ncbi_snp_query for rs1610720 snp", {
  ## truth: https://www.ncbi.nlm.nih.gov/snp/rs1610720
  skip_on_cran()
  
  aa <- ncbi_snp_query("rs1610720")
  
  expect_equal(aa$chromosome, "6")
  expect_equal(aa$bp, 29793285) ## on GRCh38
  expect_equal(aa$rsid, "rs1610720")
  expect_equal(aa$class, "snv")
  expect_equal(aa$gene, "HCG4/HLA-V")
  expect_equal(aa$alleles, "A,G,T")
  expect_equal(aa$minor, "G")
  expect_equal(aa$maf, 0.4170, tolerance = 1e-2)
  expect_equal(aa$ancestral_allele, "A")
  expect_equal(aa$variation_allele, "G,T")
  
})


expected_df_names <- c("query", "chromosome", "bp", "class", "rsid", "gene", "alleles", "ancestral_allele", "variation_allele", "seqname", "hgvs", "assembly", "ref_seq", "minor", "maf", "maf_population")
test_that("ncbi_snp_query works", {
  skip_on_cran()

  aa <- ncbi_snp_query("rs420358")

  expect_is(aa, "data.frame")
  expect_is(aa$query, "character")
  expect_is(aa$chromosome, "character")
  expect_type(aa$bp, "double")
  expect_named(aa, expected_df_names)
})

test_that("ncbi_snp_query - many snps at once works", {
  skip_on_cran()

  x <- c("rs420358", "rs1837253", "rs1209415715")
  aa <- ncbi_snp_query(x)

  expect_is(aa, "data.frame")
  expect_is(aa$query, "character")
  expect_is(aa$chromosome, "character")
  expect_type(aa$bp, "double")
  expect_named(aa, expected_df_names)
  expect_gt(NROW(aa), 2)
})


test_that("ncbi_snp_query - many snps at once works with some that give errors", {
  skip_on_cran()
  
  x <- c("rs420358", "rs1", "rs1209415715") ## rs1 does not exist
  expect_warning(aa <- ncbi_snp_query(x), "The following rsId had no information available on NCBI:") 
  
  expect_is(aa, "data.frame")
  expect_is(aa$query, "character")
  expect_is(aa$chromosome, "character")
  expect_type(aa$bp, "double")
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

  expect_error(ncbi_snp_query(), "argument \"snps\" is missing")
  expect_error(ncbi_snp_query(5), "not all items supplied are prefixed")
  expect_error(ncbi_snp_query('ab5'), "not all items supplied are prefixed")

})



