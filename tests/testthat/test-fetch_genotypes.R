test_that("getting users from opensnp works", {
  vcr::use_cassette("fetch_genotypes", {
    data <- users(df = TRUE)
    head(data[[1]]) # users with links to genome data
    mydata <- fetch_genotypes(
      url = data[[1]][1, "genotypes.download_url"],
      file = "~/myfile.txt"
    )
  })
  
  expect_equal(nrow(mydata), 100)
  expect_equal(ncol(mydata), 4)
  
})
