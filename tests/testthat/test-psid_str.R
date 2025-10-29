test_that("psid_str() creates table for data structure", {
  psid_varlist_s = c(" hh_age || [13]ER53017 [17]ER66017", " p_age || [13]ER34204")
  actual_output_s <- psid_str(varlist = psid_varlist_s, type = "separated")
  psid_varlist_i = "|| hh_age ///
                [13]ER53017  [17]ER66017 ///
               || p_age ///
               [13]ER34204///"
  actual_output_i <- psid_str(varlist = psid_varlist_i, type = "integrated")

  exp_output <- data.frame(
    year = c(2013, 2017),
    hh_age = c("ER53017", "ER66017"),
    p_age = c("ER34204", NA)
  )
  row.names(exp_output) <- c(1:(nrow(exp_output) + 1))[2:(nrow(exp_output) + 1)] # Row name does not affect
  expect_equal(actual_output_s, exp_output)
  expect_equal(actual_output_i, exp_output)
})


