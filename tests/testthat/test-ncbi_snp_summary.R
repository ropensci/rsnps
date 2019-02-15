context("ncbi_snp_summary")

test_that("ncbi_snp_summary works", {
  skip_on_cran()

  aa <- ncbi_snp_summary("rs420358")

  expect_is(aa, "data.frame")
  expect_is(aa$queried_id, "character")
  expect_is(aa$snp_id, "character")
  expect_equal(aa$snp_id, "420358")
  expect_true(all(vapply(aa, class, "") == "character"))
})

test_that("ncbi_snp_summary - many snps at once works", {
  skip_on_cran()

  x <- c("rs332", "rs420358", "rs1837253", "rs1209415715", "rs111068718")
  aa <- ncbi_snp_summary(x)

  expect_is(aa, "data.frame")
  expect_is(aa$queried_id, "character")
  expect_is(aa$snp_id, "character")
  expect_equal(sort(aa$queried_id), sort(gsub("rs", "", x)))
  expect_true(all(vapply(aa, class, "") == "character"))
  expect_equal(NROW(aa), 5)
})

test_that("ncbi_snp_summary - sort order matches input order", {
  skip_on_cran()

  x <- c("rs4301695", "rs17495050", "rs5024522", "rs9422868", "rs9422871")
  aa <- ncbi_snp_summary(x)

  expect_is(aa, "data.frame")
  expect_equal(gsub("^rs", "", x), aa$queried_id)
})

test_that("ncbi_snp_summary - rs IDs not found", {
  skip_on_cran()

  expect_warning(z <- ncbi_snp_summary("rs111068718"), "no results found")
  expect_equal(NROW(z), 0)
})

test_that("ncbi_snp_summary fails well", {
  skip_on_cran()

  expect_error(ncbi_snp_summary(), "argument \"x\" is missing")
  expect_error(ncbi_snp_summary(5), "is not TRUE")
})
