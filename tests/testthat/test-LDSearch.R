context("ld_search")

test_that("ld_search returns the correct data", {
  skip_on_cran()

  aa <- ld_search("rs420358", quiet = TRUE)
  bb <- ld_search('rs2836443', quiet = TRUE)

  expect_is(aa, "list")
  expect_is(aa[[1]], "data.frame")
  expect_named(aa, "rs420358")
  expect_equal(unique(aa[[1]]$SNP), "rs420358")

  expect_is(bb, "list")
  expect_is(bb[[1]], "data.frame")
  expect_named(bb, "rs2836443")
  expect_equal(unique(bb[[1]]$SNP), "rs2836443")
})

test_that("ld_search fails well - only one bad snp, no good ones", {
  skip_on_cran()

  expect_is(tryCatch(ld_search(SNPs = "rs121913366", quiet = TRUE), warning = function(w) w), "warning")
  expect_error(suppressWarnings(ld_search(SNPs = "rs121913366", quiet = TRUE)),
               "no valid data found")
})

test_that("ld_search fails well - one bad snp + other good ones", {
  skip_on_cran()

  expect_warning(ld_search(c('rs2836443', "rs121909001"), quiet = TRUE), "No matching proxy snps found")
})
