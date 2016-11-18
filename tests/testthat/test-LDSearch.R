context("LDSearch")

test_that("LDSearch returns the correct data", {
  aa <- LDSearch("rs420358", quiet = TRUE)
  bb <- LDSearch('rs2836443', quiet = TRUE)
  
  expect_is(aa, "list")
  expect_is(aa[[1]], "data.frame")
  expect_named(aa, "rs420358")
  expect_equal(unique(aa[[1]]$SNP), "rs420358")
  
  expect_is(bb, "list")
  expect_is(bb[[1]], "data.frame")
  expect_named(bb, "rs2836443")
  expect_equal(unique(bb[[1]]$SNP), "rs2836443")
})

test_that("LDSearch fails well - only one bad snp, no good ones", {
  expect_is(tryCatch(LDSearch(SNPs = "rs121913366", quiet = TRUE), warning = function(w) w), "warning")
  expect_error(suppressWarnings(LDSearch(SNPs = "rs121913366", quiet = TRUE)), 
               "no valid data found")
})

test_that("LDSearch fails well - one bad snp + other good ones", {
  expect_warning(LDSearch(c('rs2836443', "rs121909001"), quiet = TRUE), "No matching proxy snps found")
})
