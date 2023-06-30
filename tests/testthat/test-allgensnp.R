context("allgensnp")

test_that("allgensnps returns the proper dataframe", {
  skip_on_cran()
  
  ## for testing it is useful to be able to only get a subset of users
  
  skip_on_cran()
  
  vcr::use_cassette("allgensnp_error", {
  expect_error(dat <- allgensnp(snp = "rs486907",
                   usersubset = "1-8"))
  })
  
  
  vcr::use_cassette("allgensnp", {
    dat <- allgensnp(snp = "rs486907",
                                  usersubset = "1-8")
  })

  expect_equal(sum(c("name",
                     "chromosome",
                     "position",
                     "user_name",
                     "id",
                     "genotype_id",
                     "local_genotype") %in% colnames(dat)),
               length(colnames(dat)))
})
