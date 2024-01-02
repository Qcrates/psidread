test_that("psid_reshape() renames and reshapes the data frame", {
  psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017"," p_age || [13]ER34204")
  str_df <- psid_str(varlist = psid_varlist, type = "separated")
  # Below is the file path for the package test data, set this to your own directory
  exdir <- system.file(package = "psidread","extdata")
  indir <- system.file(package = "psidread","extdata")
  psid_unzip(indir = indir,
             exdir = exdir,
             zipped = TRUE,
             type = "package",
             filename = NA)
  df <- psid_read(indir = indir,
                  str_df = str_df,
                  idvars = c("ER30000"),
                  type = "package",
                  filename = NA)
  ind_long_df <- psid_reshape(psid_df = df,
                            str_df = str_df,
                            shape = "long",
                            level = "individual")
  expect_equal(nrow(df) * nrow(str_df), nrow(ind_long_df))
})
