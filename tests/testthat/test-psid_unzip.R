test_that("psid_unzip() helps unzip and convert the data to .rda files", {
  exdir <- tempdir()
  indir <- system.file(package = "psidread","extdata") # Define the output directory

  # Package version
  psid_unzip(indir = indir, exdir = exdir, zipped = TRUE, type = "package", filename = NA)
  actual_output_pkg <- list.files(path = exdir, pattern = "^(fam|ind)[0-9]{4}(er)?\\.rda")
  exp_output <- c("fam2013er.rda","fam2017er.rda","ind2021er.rda")
  expect_equal(sum(1-exp_output %in% actual_output_pkg), 0)

  # Specific one file
  psid_unzip(indir = indir, exdir = exdir, zipped = TRUE, type = "single", filename = "J327825.zip")
  expect_equal("J327825.rda" %in% list.files(path = exdir, pattern = ".*\\.rda"),TRUE)
})
