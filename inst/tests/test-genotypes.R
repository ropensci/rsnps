# tests for genotypes fxn in ropensnp
context("genotypes")

test_that("genotypes returns the correct class", {
	expect_that(genotypes('rs9939609', userid='1,6,8', df=TRUE), is_a("data.frame"))
})

test_that("genotypes returns the correct dims for data.frame", {
	expect_that(nrow(genotypes('rs9939609', userid='1,6,8', df=TRUE)), equals(3))
})

test_that("genotypes returns the correct value", {
	expect_that(genotypes('rs9939609', userid='1,6,8', df=TRUE)[2,4], equals("Nash Parovoz"))
})