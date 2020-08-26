# tests for allphenotypes fxn in ropensnp
context("allphenotypes")

test_that("allphenotypes returns the correct class", {
	skip_on_cran()

	expect_that(allphenotypes(df = TRUE), is_a("data.frame"))
})

test_that("allphenotypes returns the correct dims for data.frame", {
	skip_on_cran()

	expect_that(ncol(allphenotypes()[["ADHD"]]), equals(4))
})


test_that("allphenotypes returns set of common known_variations (common = in more than 5 individuals)", {
    skip_on_cran()
  
    expect_true(all(c("False", "True", "Undiagnosed, but probably true", "No", "Yes", 
                    "Not diagnosed", "Mthfr c677t") %in% as.character(allphenotypes()[["ADHD"]][,3]))) 
  
})
