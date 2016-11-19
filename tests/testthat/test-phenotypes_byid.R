# tests for phenotypes_byid fxn in ropensnp
context("phenotypes_byid")

test_that("phenotypes_byid returns the correct class", {
	skip_on_cran()

	one <- suppressMessages(phenotypes_byid(phenotypeid=12, return_ = 'users'))

	expect_is(one, "data.frame")
	expect_is(suppressMessages(phenotypes_byid(phenotypeid=12, return_ = 'desc')), "list")
	expect_equal(NCOL(one), 2)
	expect_that(suppressMessages(phenotypes_byid(phenotypeid=12, return_ = 'knownvars'))$known_variations[1:2],
							equals(list("Red","Blonde")))
})
