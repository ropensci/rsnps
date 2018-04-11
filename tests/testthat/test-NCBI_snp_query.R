context("ncbi_snp_query")

test_that("ncbi_snp_query works", {
  skip_on_cran()

  aa <- ncbi_snp_query("rs420358")

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, c('Query', 'Chromosome', 'Marker', 'Class', 'Gene',
                'Alleles', 'Major', 'Minor', 'MAF', 'BP', 'AncestralAllele'))
})

test_that("ncbi_snp_query - many snps at once works", {
  skip_on_cran()

  x <- c("rs420358", "rs1837253", "rs1209415715")
  aa <- ncbi_snp_query(x)

  expect_is(aa, "data.frame")
  expect_is(aa$Query, "character")
  expect_is(aa$Chromosome, "character")
  expect_type(aa$BP, "double")
  expect_named(aa, c('Query', 'Chromosome', 'Marker', 'Class', 'Gene',
              'Alleles', 'Major', 'Minor', 'MAF', 'BP', 'AncestralAllele'))
  expect_gt(NROW(aa), 2)
})

test_that("ncbi_snp_query - rs IDs not found", {
  skip_on_cran()

  expect_warning(z <- ncbi_snp_query('rs111068718'), "had no information")
  expect_equal(NROW(z), 0)
})

test_that("ncbi_snp_query - gives warning when expected", {
  skip_on_cran()

  expect_warning(ncbi_snp_query('rs332'), "has been merged into")
})

test_that("ncbi_snp_query fails well", {
  skip_on_cran()

  expect_error(ncbi_snp_query(), "argument \"SNPs\" is missing")
  expect_error(ncbi_snp_query(5), "not all items supplied are prefixed")
  expect_error(ncbi_snp_query('ab5'), "not all items supplied are prefixed")
})
