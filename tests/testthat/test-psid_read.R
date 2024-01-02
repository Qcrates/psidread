test_that("psid_read() load the data from multiple data files", {
  psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017", " p_age || [13]ER34204")
  str_df <- psid_str(varlist = psid_varlist, type = "separated")
  exdir <- system.file(package = "psidread","extdata")
  indir <- system.file(package = "psidread","extdata")
  psid_unzip(indir = indir,exdir = exdir,zipped = TRUE,type = "package",filename = NA)
  # package read
  psid_df <- psid_read(indir = indir, str_df = str_df,idvars = c("ER30000"),type = "package",filename = NA)
  exp_output <- c("ER53017","ER66017", # hh_age in 2013 and 2017
                  "ER34204", # p_age in 2013
                  "pid", # Required
                  "ER30000", #idvars
                  "ER34201","ER34501", #indfid
                  "ER34202","ER34502", #xsqnr
                  "ER34203","ER34503") #rel2hh
  expect_equal(sum(1-exp_output %in% colnames(psid_df)), 0) # Expected variables should all be included

  # single file read
  filename = "J327825.zip"
  psid_unzip(indir = indir,exdir = exdir,zipped = TRUE,type = "single",filename = filename)
  psid_df_s <- psid_read(indir = indir, str_df = str_df,idvars = c("ER30000"),type = "single",filename = filename)
  expect_equal(sum(1-exp_output %in% colnames(psid_df_s)), 0) # Expected variables should all be included
})
