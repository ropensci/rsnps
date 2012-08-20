# tests for annotations fxn in ropensnp
context("annotations")

test_that("annotations returns the correct class", {
	expect_that(annotations(snp = 'rs7903146', output = 'metadata'), is_a("data.frame"))
	expect_that(annotations(snp = 'rs7903146', output = 'plos'), is_a("data.frame"))
	expect_that(annotations(snp = 'rs7903146', output = 'snpedia'), is_a("data.frame"))
	expect_that(annotations(snp = 'rs7903146', output = 'all'), is_a("data.frame"))
})

test_that("annotations returns the correct dims for data.frame", {
	expect_that(nrow(annotations(snp = 'rs7903146', output = 'plos')), equals(6))
	expect_that(nrow(annotations(snp = 'rs7903146', output = 'snpedia')), equals(3))
})

test_that("annotations returns the correct value", {
	expect_that(as.character(annotations(snp = 'rs7903146', output = 'plos')[1,6]), matches("10.1371/journal.pone.0017978"))
	expect_that(as.character(annotations(snp = 'rs7903146', output = 'all')[30,10]), matches("normal form"))
})