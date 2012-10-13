# tests for fetch_genotypes fxn in ropensnp
context("fetch_genotypes")

data <- users(df=TRUE)

test_that("fetch_genotypes returns the correct class", {
	expect_that(fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15), 
		is_a("data.frame"))
})

test_that("fetch_genotypes returns the correct dims for data.frame", {
	expect_that(nrow(fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15)), 
							equals(15))
})

test_that("fetch_genotypes returns the correct value", {
	expect_that(fetch_genotypes(url = data[[1]][1,"genotypes.download_url"], rows=15)[1,1], 
							matches("rs4477212"))
})