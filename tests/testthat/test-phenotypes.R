# tests for phenotypes fxn in ropensnp
context("phenotypes")

test_that("phenotypes returns the correct class", {
	skip_on_cran()

	df <- suppressMessages(phenotypes(userid='1,6,8', df=TRUE))

	expect_that(df, is_a("list"))
	expect_that(df[[1]], is_a("data.frame"))
	expect_that(as.character(suppressMessages(phenotypes(userid=1))$user$name), equals("Bastian Greshake"))
})
