test_that("getting users from opensnp works", {
  skip_on_cran()
  
  vcr::use_cassette("get_users_error", {
    expect_error(data <- users(df = TRUE))
  })

  vcr::use_cassette("fetch_genotypes_error", {
    expect_error(mydata <- fetch_genotypes(
      url = data[[1]][1, "genotypes.download_url"],
      file = "~/myfile.txt"
    ))
  })
  
  ## cannot use vcr here because it is with download file
  #   mydata <- fetch_genotypes(
  #     url = data[[1]][1, "genotypes.download_url"],
  #     file = "~/myfile.txt"
  #   )
  # 
  # expect_equal(nrow(mydata), 100)
  # expect_equal(ncol(mydata), 4)


  fn <- "~/myfile.txt"
  if (file.exists(fn)) {
    #Delete file if it exists
    file.remove(fn)
  }
})
