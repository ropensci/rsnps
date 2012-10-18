# tests for phenotypes fxn in ropensnp
context("phenotypes")
 
test_that("phenotypes returns the correct class", {
	expect_that(phenotypes(userid='1,6,8', df=TRUE), is_a("list"))
	expect_that(phenotypes(userid='1,6,8', df=TRUE)[[1]], is_a("data.frame"))
})

test_that("phenotypes returns the correct dims for data.frame", {
	expect_that(length(phenotypes(userid=1)), equals(2))
	expect_that(nrow(phenotypes(userid='1,6,8', df=TRUE)[[2]]), equals(5))
})

test_that("phenotypes returns the correct value", {
	expect_that(phenotypes(userid=1)$user$name, equals("Bastian Greshake"))
})