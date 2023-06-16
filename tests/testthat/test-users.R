test_that("getting users from opensnp works", {
  vcr::use_cassette("users", {
    data <- users(df = TRUE)
  })
  expect_equal(ncol(data[[1]]), 5)
  expect_equal(nrow(data[[1]]), 5476)
})


vcr::use_cassette("users_badgateway", {
  test_that("fail with 502, bad gateway,  when getting opensnp users", {
    expect_error(users(df = TRUE))
  })
  
})
