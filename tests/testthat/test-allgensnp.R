# tests for allphenotypes fxn in ropensnp
context("allgensnp")

test_that("allphenotypes returns the correct class", {
  skip_on_cran()
  
  ## for testing it is useful to be able to only get a subset of users
  
  dat <- allgensnp(snp = "rs486907",
                   usersubset = "1-8")
  expect_equal(sum(c("name",
                     "chromosome",
                     "position",
                     "user_name",
                     "id",
                     "genotype_id",
                     "local_genotype") %in% colnames(dat)),
               length(colnames(dat)))
})
