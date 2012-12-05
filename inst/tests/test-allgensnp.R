# tests for allgensnp fxn in ropensnp
context("allgensnp")

test_that("allgensnp returns the correct class", {
	expect_that(allgensnp('rs7412', df=TRUE), is_a("data.frame"))
})

test_that("allgensnp returns the correct dims for data.frame", {
	expect_that(ncol(allgensnp('rs9939609', df=TRUE)), equals(7))
})