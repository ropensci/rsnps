# tests for phenotypes_byid fxn in ropensnp
context("phenotypes_byid")

sm <- suppressMessages
one <- sm(phenotypes_byid(phenotypeid=12, return_ = 'users'))

test_that("phenotypes_byid returns the correct class", {
	expect_is(one, "data.frame")
	expect_is(sm(phenotypes_byid(phenotypeid=12, return_ = 'desc')), "list")
})

test_that("phenotypes_byid returns the correct dims for data.frame", {
	expect_equal(NCOL(one), 2)
})

test_that("phenotypes_byid returns the correct value", {
	expect_that(sm(phenotypes_byid(phenotypeid=12, return_ = 'knownvars'))$known_variations[1:2], 
							equals(list("Red","Blonde")))
})
