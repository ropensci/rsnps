context("genotypes")

test_that("genotypes returns the correct class", {
	skip_on_cran()

	one <- suppressMessages(genotypes('rs9939609', userid='1,6,8', df=TRUE))

	expect_that(one, is_a("data.frame"))
	expect_equal(NROW(one), 3)
	expect_that(as.character(one[2,4]), matches("Nash Parovoz"))
})
