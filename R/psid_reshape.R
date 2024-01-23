#' @title Rename and reshape your PSID dataset
#' @description
#' `psid_reshape()` serves as the final step in processing your PSID data which helps the user rename and reshape the data frame to produce output in your desired format.
#'
#' @details
#' This function offers options in data output at both the household and individual levels.
#' When the user specifies for household-level output, the output will only retain the household head's record for each household.
#' This option will be useful if the user aims to conduct family-level analysis.
#' In contrast, individual-level output includes details for all family members.
#'
#' Additionally, `psid_reshape()` allows for choosing between wide and long formats.
#' In the wide format, variables are named as `VARNAME_YYYY`.
#'
#' @param psid_df The data frame generated from psid_read() function. The user should not change anything on the data frame.
#' @param str_df The structure data frame generated from psid_str() function.
#' @param shape The shape you would like the data frame to be.
#' "long" if you want to have each line represent the data for each person at each year;
#' "wide" if you want to have each line represent the data for all waves for each person;
#' @param level The level of output. Default value is set to 'individual'.
#' The user can also set this value to 'household' if needed. Deduplication will be performed and leave only the record of household head for each household.
#'
#' @returns A data frame with self-defined variable name
#'
#' @export
#'
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr starts_with
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr left_join
#'
#' @examples
#' # Import dataset use `psid_str()`, `psid_unzip()` and `psid_read()`
#' psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017"," p_age || [13]ER34204")
#' str_df <- psid_str(varlist = psid_varlist, type = "separated")
#' # Below is the file path for the package test data, set this to your own directory
#' indir <- system.file(package = "psidread","extdata")
#' df <- psid_read(indir = indir,
#'                 str_df = str_df,
#'                 idvars = c("ER30000"),
#'                 type = "package",
#'                 filename = NA)
#' # Example 1: Individual-level output in long format
#' ind_long_df <- psid_reshape(psid_df = df,
#'                           str_df = str_df,
#'                           shape = "long",
#'                           level = "individual")
#' # Example 2: Household-level output in wide format
#' fam_wide_df <- psid_reshape(psid_df = df,
#'                             str_df = str_df,
#'                             shape = "wide",
#'                             level = "household")

psid_reshape <- function(psid_df, str_df, shape = "wide", level = "individual"){

  # Pre-set for global variable absence notes
  year <- xsqnr <- rel2hh <- indfid <- varlist_toread <- NULL

  # Add match key to structure data frame
  year_toread <- str_df$year
  temp_env <- new.env()
  temp_env$key_tb <- psid_str(varlist = c("xsqnr || 	[69]ER30021 [70]ER30044 [71]ER30068 [72]ER30092 [73]ER30118 [74]ER30139 [75]ER30161 [76]ER30189 [77]ER30218 [78]ER30247 [79]ER30284 [80]ER30314 [81]ER30344 [82]ER30374 [83]ER30400 [84]ER30430 [85]ER30464 [86]ER30499 [87]ER30536 [88]ER30571 [89]ER30607 [90]ER30643 [91]ER30690 [92]ER30734 [93]ER30807 [94]ER33102 [95]ER33202 [96]ER33302 [97]ER33402 [99]ER33502 [01]ER33602 [03]ER33702 [05]ER33802 [07]ER33902 [09]ER34002 [11]ER34102 [13]ER34202 [15]ER34302 [17]ER34502 [19]ER34702 [21]ER34902",
                                          "rel2hh || [68]ER30003 [69]ER30022 [70]ER30045 [71]ER30069 [72]ER30093 [73]ER30119 [74]ER30140 [75]ER30162 [76]ER30190 [77]ER30219 [78]ER30248 [79]ER30285 [80]ER30315 [81]ER30345 [82]ER30375 [83]ER30401 [84]ER30431 [85]ER30465 [86]ER30500 [87]ER30537 [88]ER30572 [89]ER30608 [90]ER30644 [91]ER30691 [92]ER30735 [93]ER30808 [94]ER33103 [95]ER33203 [96]ER33303 [97]ER33403 [99]ER33503 [01]ER33603 [03]ER33703 [05]ER33803 [07]ER33903 [09]ER34003 [11]ER34103 [13]ER34203 [15]ER34303 [17]ER34503 [19]ER34703 [21]ER34903",
                                          "indfid || [68]ER30001 [69]ER30020 [70]ER30043 [71]ER30067 [72]ER30091 [73]ER30117 [74]ER30138 [75]ER30160 [76]ER30188 [77]ER30217 [78]ER30246 [79]ER30283 [80]ER30313 [81]ER30343 [82]ER30373 [83]ER30399 [84]ER30429 [85]ER30463 [86]ER30498 [87]ER30535 [88]ER30570 [89]ER30606 [90]ER30642 [91]ER30689 [92]ER30733 [93]ER30806 [94]ER33101 [95]ER33201 [96]ER33301 [97]ER33401 [99]ER33501 [01]ER33601 [03]ER33701 [05]ER33801 [07]ER33901 [09]ER34001 [11]ER34101 [13]ER34201 [15]ER34301 [17]ER34501 [19]ER34701 [21]ER34901",
                                          "famfid || [68]V3 [69]V442 [70]V1102 [71]V1802 [72]V2402 [73]V3002 [74]V3402 [75]V3802 [76]V4302 [77]V5202 [78]V5702 [79]V6302 [80]V6902 [81]V7502 [82]V8202 [83]V8802 [84]V10002 [85]V11102 [86]V12502 [87]V13702 [88]V14802 [89]V16302 [90]V17702 [91]V19002 [92]V20302 [93]V21602 [94]ER2002 [95]ER5002 [96]ER7002 [97]ER10002 [99]ER13002 [01]ER17002 [03]ER21002 [05]ER25002 [07]ER36002 [09]ER42002 [11]ER47302 [13]ER53002 [15]ER60002 [17]ER66002 [19]ER72002 [21]ER78002",
                                          "wlthid || [84]S101 [89]S201 [94]S301 [99]S401 [01]S501 [03]S601 [05]S701 [07]S801"),
                              type = "separated") |>
    dplyr::filter(year %in% year_toread) |>
    dplyr::select(year, xsqnr, rel2hh, indfid)
  str_df <- str_df |>
    dplyr::left_join(temp_env$key_tb, by = "year")
  rm(list = ls(temp_env), envir = temp_env)

  # Identify the idvars
  varlist_toread <- unname(unlist(str_df[,c(2:ncol(str_df))]))
  varlist_toread <- varlist_toread[!is.na(varlist_toread)]
  idvars <- setdiff(colnames(psid_df), varlist_toread)

  # Full varlist
  varnames_woyear <- colnames(str_df)[2:length(str_df)]

  # Step 1: Rename ----
  for (i in c(1:nrow(str_df))){
    yr <- str_df$year[i]
    list_varcode <- unname(unlist(str_df[i,c(2:ncol(str_df))]))
    list_varname <- paste(varnames_woyear[!is.na(list_varcode)], yr, sep = "_")
    list_varcode <- list_varcode[!is.na(list_varcode)]
    psid_df <- psid_df |>
      dplyr::rename(setNames(list_varcode,list_varname))
  }

  # Step 2: Reshape ----
  if (level == "individual"){
    if (shape == "wide"){
      ## Individual wide ----
      df <- psid_df
    } else if (shape == "long"){
      ## Individual long ----
      df <- psid_df |>
        tidyr::pivot_longer(
          cols = tidyr::starts_with(varnames_woyear),
          names_to = c(".value", "year"),
          names_sep = "_(?=[^_]+$)" # match the last underscore in the variable name
        )
    } else {
      stop("Please specify your expected shape of data frame to be either wide or long version")
    }
  } else if (level == "household"){
    ## Household wide ----
    df <- psid_df |>
      tidyr::pivot_longer(
        cols = tidyr::starts_with(varnames_woyear),
        names_to = c(".value", "year"),
        names_sep = "_(?=[^_]+$)" # match the last underscore in the variable name
      )
    if (shape == "long"){
    ## Household long ----
      df <- df |>
        dplyr::filter(rel2hh == 10 & xsqnr == 1)
    } else if (shape == "wide"){
      df <- df |>
        dplyr::filter(rel2hh == 10 & xsqnr == 1)

      df <- df |>
        tidyr::pivot_wider(
          id_cols = idvars,
          names_from = year,
          names_sep = "_",
          values_from = varnames_woyear,
          names_glue = "{.value}_{year}"
        )
    } else {
      stop("Please specify your expected shape of data frame to be either wide or long version")
    }
  } else {
    stop("Please specify your expected level of output to be either individual or household level.")
  }
  return(df)
}





