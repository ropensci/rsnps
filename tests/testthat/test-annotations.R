# tests for annotations fxn in ropensnp
context("annotations")

sm <- suppressMessages
one <- sm(annotations(snp = 'rs7903146', output = 'snpedia'))

test_that("annotations returns the correct class", {
	expect_that(one, is_a("data.frame"))
	expect_that(sm(annotations(snp = 'rs7903146', output = 'all')), is_a("data.frame"))
})

test_that("annotations returns the correct dims for data.frame", {
	expect_that(ncol(one), equals(2))
})

test_that("annotations returns the correct value", {
	expect_that(grepl("10.1371/journal",as.character(sm(annotations(snp = 'rs7903146', output = 'plos'))[1,6])), is_true())
})
