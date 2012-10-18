# tests for users fxn in ropensnp
context("users")

data <- users(df=TRUE)
 
test_that("users returns the correct class", {
	expect_that(users(df=TRUE), is_a("list"))
})

test_that("users returns the correct dims for data.frame", {
	expect_that(ncol(data[[1]]), equals(5))
	expect_that(ncol(data[[2]]), equals(2))
})

test_that("users returns the correct value", {
	expect_that(data[[1]]$name[[1]], matches("Samantha"))
})