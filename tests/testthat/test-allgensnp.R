# tests for allphenotypes fxn in ropensnp
context("allgensnp")

test_that("allphenotypes returns the correct class", {
  skip_on_cran()
  
  dat <- allgensnp(snp = "rs486907")
  expect_equal(sum(c("name",
                     "chromosome",
                     "position",
                     "user_name",
                     "id",
                     "genotype_id",
                     "local_genotype") %in% colnames(dat)),
               length(colnames(dat)))
})
