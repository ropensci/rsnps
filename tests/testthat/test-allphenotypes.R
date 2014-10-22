# tests for allphenotypes fxn in ropensnp
context("allphenotypes")

test_that("allphenotypes returns the correct class", {
	expect_that(allphenotypes(df = TRUE), is_a("data.frame"))
})

test_that("allphenotypes returns the correct dims for data.frame", {
	expect_that(ncol(allphenotypes()[["ADHD"]]), equals(4))
})

test_that("allphenotypes returns the correct value", {
	expect_that(as.character(allphenotypes()[["ADHD"]][7,3]), 
							equals("Diagnosed as not having but with some signs"))
})
