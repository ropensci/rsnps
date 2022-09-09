# tests for annotations fxn in ropensnp
context("annotations")

test_that("annotations returns the correct class", {
  skip_on_cran()

  one <- suppressMessages(annotations(snp = "rs7903146", output = "snpedia"))

  expect_is(one, "data.frame")
  expect_is(
    suppressMessages(annotations(snp = "rs7903146", output = "all")),
    "data.frame"
  )
  expect_equal(ncol(one), 2)
  expect_true(
    grepl(
      "10.1371/journal",
      as.character(
        suppressMessages(
          annotations(snp = "rs7903146", output = "plos")
        )[1, 6]
      )
    )
  )
})
