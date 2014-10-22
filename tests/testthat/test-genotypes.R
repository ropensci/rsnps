# tests for genotypes fxn in ropensnp
context("genotypes")

sm <- suppressMessages
one <- sm(genotypes('rs9939609', userid='1,6,8', df=TRUE))

test_that("genotypes returns the correct class", {
	expect_that(one, is_a("data.frame"))
})

test_that("genotypes returns the correct dims for data.frame", {
	expect_equal(NROW(one), 3)
})

test_that("genotypes returns the correct value", {
	expect_that(as.character(one[2,4]), matches("Nash Parovoz"))
})
