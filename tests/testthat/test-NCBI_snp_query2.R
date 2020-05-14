context("ncbi_snp_query2")

test_that("ncbi_snp_query2 works", {
  skip_on_cran()

  aa <- ncbi_snp_query2("rs420358")

  expect_is(aa, "dbsnp")
  expect_is(aa$summary, "data.frame")
  expect_is(aa$data, "list")
  expect_is(aa$summary$query, "character")
  expect_is(aa$summary$organism, "character")
  expect_type(aa$summary$bp, "double")
  expect_named(aa$summary, c('query', 'marker', 'organism', 'chromosome',
                             'assembly', 'alleles', 'minor', 'maf', 'bp'))
})

test_that("ncbi_snp_query2 - many snps at once works", {
  skip_on_cran()

  x <- c("rs420358", "rs1837253", "rs1209415715", "rs111068718")
  aa <- ncbi_snp_query2(x)

  expect_is(aa, "dbsnp")
  expect_is(aa$summary, "data.frame")
  expect_is(aa$data, "list")
  expect_is(aa$summary$query, "character")
  expect_is(aa$summary$organism, "character")
  expect_type(aa$summary$bp, "double")
  expect_named(aa$summary, c('query', 'marker', 'organism', 'chromosome',
                             'assembly', 'alleles', 'minor', 'maf', 'bp'))
  expect_gt(NROW(aa$summary), 3)
})

test_that("ncbi_snp_query2 - a SNP that's merged into another returns different SNP ID and warning", {
  skip_on_cran()

  expect_warning(
    aa <- ncbi_snp_query2("rs332"), 
    "Query results from SNPs rs332 are empty"
  )

  expect_is(aa, "dbsnp")
  expect_false(identical(aa$summary$query, "rs332"))
})

test_that("ncbi_snp_query2 fails well", {
  skip_on_cran()

  expect_error(ncbi_snp_query2(), "argument \"SNPs\" is missing")
  expect_error(ncbi_snp_query2(5), "not all items supplied are prefixed")
  expect_error(ncbi_snp_query2('ab5'), "not all items supplied are prefixed")
})
