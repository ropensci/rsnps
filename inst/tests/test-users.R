# tests for users fxn in ropensnp
context("users")

data <- users(df=TRUE)
 
test_that("users returns the correct class", {
	expect_that(users(df=FALSE), is_a("list"))
	expect_that(users(df=TRUE), is_a("data.frame"))
})

test_that("users returns the correct dims for data.frame", {
	expect_that(nrow(data[[1]]), equals(224))
	expect_that(nrow(data[[2]]), equals(352))
	expect_that(ncol(data[[1]]), equals(5))
	expect_that(ncol(data[[2]]), equals(2))
})

test_that("users returns the correct value", {
	expect_that(data[[1]]$name[[1]], matches("Samantha"))
})