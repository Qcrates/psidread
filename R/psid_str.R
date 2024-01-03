#' @title Construct the table of PSID data structure
#' @description
#' The `psid_str()` function provides a simplified solution to build a table of data structure for your PSID dataset with your customized variable names.
#' @details
#' This function is influenced by the methodology implemented in the `psidtools` package developed by Professor Ulrich Kohler.
#' To utilize it, users only need to provide either a string vector (which is recommended) or a single value (if copying and pasting from their .do file).
#' Minimal additional formatting is needed, and users can easily copy and paste year-variable names directly from the PSID website's codebook.
#'
#' - This data frame only contains cross-year variables selected by the user to include in their panel dataset.
#' Do not specify ALL-YEAR variables here (e.g., individual's sex, individual's birth order).
#'
#' - The recommended approach for providing the variable list is to separate them into distinct character values and then wrap them within a vector.
#' For example: `c(" hh_age || [13]ER53017  [17]ER66017", " p_age || [13]ER34204")`
#' `hh_age` and `p_age` are self-defined variable name. It is up to you! The final data output will show this variable name instead of the variable code like `ER34204`.
#' The `[YY]VARCODE` sequence can be found from the code book of PSID. You do not need to make any changes on them.
#' Please ensure proper separation between the user-defined variable name and the `[YY]VARCODE` using "||".
#' Each variable sequence should be placed in a separate string value.
#' If this method is used, users should set the `type` argument to "separated".
#'
#' - This function also offers an option for users who wish to copy and paste their code directly from Stata.
#' Simply copy and paste your code into a single string value without making any alterations.
#' For instance: `"|| hh_age /// [13]ER53017  [17]ER66017 /// || p_age /// [13]ER34204///"`
#' Note the different position of "||" between the two input methods.
#' If you utilize this input method, please specify the `type` argument as "integrated."
#'
#' The output of this function will be utilized by `psid_read()` for reading the dataset into the environment and by `psid_reshape()` for renaming and reshaping the panel dataset.
#' Therefore, it is recommended to execute this function prior to running other functions within this package.
#'
#' @param varlist A vector of string values or a single string value, including user's self-defined variable name and the year and variable code from PSID website.
#' @param type A string value of either "separated" or "integrated", indicating the type of varlist
#' @returns A data frame of the data structure of your PSID dataset, with each row represents the year and each column represents the variable
#' @export
#' @importFrom stringr str_replace
#' @importFrom stringr str_extract_all
#' @importFrom stringr str_match_all
#' @importFrom dplyr full_join
#'
#'
#' @examples
#'
#' # Example 1: Separated string input
#' psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017",
#'                  " p_age || [13]ER34204")
#' psid_str(varlist = psid_varlist, type = "separated")
#'
#' # Example 2: Integrated string input
#' psid_varlist <- "|| hh_age ///
#'                 [13]ER53017  [17]ER66017 ///
#'                 || p_age ///
#'                 [13]ER34204///" # DO NOT CHANGE ANYTHING
#' psid_str(varlist = psid_varlist, type = "integrated")

psid_str <- function(varlist, type = "separated"){
  if (type == "separated"){
    # Trim spaces
    input_str <- stringr::str_replace(string = varlist, pattern = "^\\s*([^| ]+)", replacement = "\\1")
    # Extract self-defined variable name
    varname_list <- unlist(stringr::str_extract_all(string = input_str, pattern = "^[^| ]+"))
    # Extract [X]XX
    varcode_list <- stringr::str_extract_all(string = input_str, pattern = "\\[[0-9]+\\] *[A-Za-z0-9]+")
  } else if (type == "integrated"){
    input_str <- unlist(strsplit(varlist, split = "\\|\\|", perl = TRUE))
    input_str <- input_str[nzchar(trimws(input_str))]
    # Extract self-defined variable name
    varname_list <- sapply(stringr::str_match_all(string = input_str, pattern = "^\\s*(\\w+)"), function(x) x[,2])
    # Extract [X]XX
    varcode_list <- stringr::str_extract_all(string = input_str, pattern = "\\[[0-9]+\\] *[A-Za-z0-9]+")
  } else {
    stop("Error: Please enter either 'separated' or 'integrated' for type argument")
  }
  # Generate empty data frame
  str_df <- data.frame(year = NA)
  # Loop over all variables
  for (i in c(1:length(varcode_list))){
    # Decompose [X]XX
    extracted <- stringr::str_match_all(string = varcode_list[[i]], pattern = "\\[([0-9]+)\\] *([0-9A-Za-z]+)")
    # Extract year
    year_temp <- as.numeric(sapply(extracted, function(x) x[,2]) )
    year_temp <- ifelse(year_temp > 50, 1900 + year_temp, 2000 + year_temp)
    # Extract variable code
    varcode_temp <- sapply(extracted, function(x) x[,3])
    # Temporary data frame for merge
    temp <- data.frame(year = year_temp, varcode = varcode_temp) # Bind columns
    colnames(temp) <- c("year",varname_list[i]) # Rename columns
    # Merge
    str_df <- str_df |>
      dplyr::full_join(temp, by = "year")
  }
  str_df <- str_df[!is.na(str_df$year),]
  str_df <- str_df[order(str_df$year),]
  return(str_df)
}
