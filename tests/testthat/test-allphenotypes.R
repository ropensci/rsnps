# tests for allphenotypes fxn in ropensnp
context("allphenotypes")

test_that("allphenotypes returns the correct class", {
  skip_on_cran()
  
  vcr::use_cassette("allphenotypes", {
    allphdf <- allphenotypes(df = TRUE)
  })

  expect_that(allphdf, is_a("data.frame"))
})

test_that("allphenotypes returns the correct dims for data.frame", {
  skip_on_cran()
  vcr::use_cassette("allphenotypes_ADHD", {
    allphADHD <- allphenotypes()[["ADHD"]]
  })
  expect_that(ncol(allphADHD), equals(4))
  
  
 ## "allphenotypes returns set of common known_variations (common = in more than 5 individuals)"
  expect_true(all(c(
    "False", "True", "Undiagnosed, but probably true", "No", "Yes",
    "Not diagnosed", "Mthfr c677t"
  ) %in% as.character(allphADHD[, 3])))
  
})


