#' @title Read PSID data from the packaged data file or customized data file
#' @description
#' `psid_read()` is the core function which enables the user to read variables from multiple packaged PSID data files using just one line of code.
#' @details
#' This function also offers the option to read a customized single data files with selected variables.
#' It is important to note that `psid_read()` does not change the original variable names as they are in the source data.
#' To execute it effectively, please make sure that:
#' - `psid_str()` has been executed beforehand and the table of data structure has been in the environment.
#' - `psid_unzip()` has been executed to prepare the data in `.rda` format.

#' @param indir A character value of the directory path where the user store the .rda data files. This value should be the same as the `exdir` in the `psid_unzip()`
#' @param str_df A data frame of the data structure, generated from the `psid_str()` function.
#' @param idvars A vector of character values, including the variables that do not change across years. Labelled as "ALL YEAR" in PSID website.
#' @param type The type of data that the user downloaded from PSID. Set to "package" if the user downloaded packaged dataset, "single" if the user downloaded selected data set.
#' @param filename A character value of the name of the file. You can use the filename value you used when you run `psid_unzip()`, or a filename without any file extension.

#' @returns A data frame with all the selected variables inside but name unchanged.

#' @importFrom dplyr select
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom dplyr left_join
#' @importFrom dplyr all_of
#' @importFrom stats na.omit
#' @importFrom stats setNames
#'
#' @export
#'
#' @examples
#' # Example 1: Read from multiple package data files (Whole procedure)
#' psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017",
#'                             " p_age || [13]ER34204")
#' str_df <- psid_str(varlist = psid_varlist,
#'                    type = "separated")
#' # Below is the file path for the package test data, set this to your own directory
#' indir <- system.file(package = "psidread","extdata")
#' psid_read(indir = indir,
#'           str_df = str_df,
#'           idvars = c("ER30000"),
#'           type = "package",
#'           filename = NA)
#'
#' # Example 2: Read from your customized data file (Whole procedure)
#' filename = "J327825.zip"
#' psid_read(indir = indir,
#'           str_df = str_df,
#'           idvars = c("ER30000"),
#'           type = "single",
#'           filename = filename)

psid_read <- function(indir, str_df, idvars = NA, type, filename = NA){

  # Pre-set for global variable absence notes
  year <- ER30001 <- ER30002 <- famfid <- indfid <- wlthid <- NULL

  # Get the year to read
  year_toread <- str_df$year

  # Get the variable vector to read, remove the NA values.
  varlist_toread <- unname(unlist(str_df[,c(2:ncol(str_df))]))
  varlist_toread <- varlist_toread[!is.na(varlist_toread)]

  # Temporary environment for read and clean
  temp_env <- new.env()

  # Table of key for match
  temp_env$key_tb <- psid_str(varlist = c("xsqnr || 	[69]ER30021 [70]ER30044 [71]ER30068 [72]ER30092 [73]ER30118 [74]ER30139 [75]ER30161 [76]ER30189 [77]ER30218 [78]ER30247 [79]ER30284 [80]ER30314 [81]ER30344 [82]ER30374 [83]ER30400 [84]ER30430 [85]ER30464 [86]ER30499 [87]ER30536 [88]ER30571 [89]ER30607 [90]ER30643 [91]ER30690 [92]ER30734 [93]ER30807 [94]ER33102 [95]ER33202 [96]ER33302 [97]ER33402 [99]ER33502 [01]ER33602 [03]ER33702 [05]ER33802 [07]ER33902 [09]ER34002 [11]ER34102 [13]ER34202 [15]ER34302 [17]ER34502 [19]ER34702 [21]ER34902",
                                          "rel2hh || [68]ER30003 [69]ER30022 [70]ER30045 [71]ER30069 [72]ER30093 [73]ER30119 [74]ER30140 [75]ER30162 [76]ER30190 [77]ER30219 [78]ER30248 [79]ER30285 [80]ER30315 [81]ER30345 [82]ER30375 [83]ER30401 [84]ER30431 [85]ER30465 [86]ER30500 [87]ER30537 [88]ER30572 [89]ER30608 [90]ER30644 [91]ER30691 [92]ER30735 [93]ER30808 [94]ER33103 [95]ER33203 [96]ER33303 [97]ER33403 [99]ER33503 [01]ER33603 [03]ER33703 [05]ER33803 [07]ER33903 [09]ER34003 [11]ER34103 [13]ER34203 [15]ER34303 [17]ER34503 [19]ER34703 [21]ER34903",
                                          "indfid || [68]ER30001 [69]ER30020 [70]ER30043 [71]ER30067 [72]ER30091 [73]ER30117 [74]ER30138 [75]ER30160 [76]ER30188 [77]ER30217 [78]ER30246 [79]ER30283 [80]ER30313 [81]ER30343 [82]ER30373 [83]ER30399 [84]ER30429 [85]ER30463 [86]ER30498 [87]ER30535 [88]ER30570 [89]ER30606 [90]ER30642 [91]ER30689 [92]ER30733 [93]ER30806 [94]ER33101 [95]ER33201 [96]ER33301 [97]ER33401 [99]ER33501 [01]ER33601 [03]ER33701 [05]ER33801 [07]ER33901 [09]ER34001 [11]ER34101 [13]ER34201 [15]ER34301 [17]ER34501 [19]ER34701 [21]ER34901",
                                          "famfid || [68]V3 [69]V442 [70]V1102 [71]V1802 [72]V2402 [73]V3002 [74]V3402 [75]V3802 [76]V4302 [77]V5202 [78]V5702 [79]V6302 [80]V6902 [81]V7502 [82]V8202 [83]V8802 [84]V10002 [85]V11102 [86]V12502 [87]V13702 [88]V14802 [89]V16302 [90]V17702 [91]V19002 [92]V20302 [93]V21602 [94]ER2002 [95]ER5002 [96]ER7002 [97]ER10002 [99]ER13002 [01]ER17002 [03]ER21002 [05]ER25002 [07]ER36002 [09]ER42002 [11]ER47302 [13]ER53002 [15]ER60002 [17]ER66002 [19]ER72002 [21]ER78002",
                                          "wlthid || [84]S101 [89]S201 [94]S301 [99]S401 [01]S501 [03]S601 [05]S701 [07]S801"),
                              type = "separated") |>
    dplyr::filter(year %in% year_toread)


  if (type == "package"){
    # Packaged ----

    # Load the individual dataset
    ind_filename <- list.files(path = indir, pattern = "ind.*\\.rda")
    load(file = file.path(indir, ind_filename), envir = temp_env)

    # Rename the individual data file for generalization
    matches <- ls(pattern = ".*ind.*", envir = temp_env)
    if (length(matches) > 0){
      temp_env$ind_df <- get(matches[1], envir = temp_env)
      rm(list = matches[1], envir = temp_env)
    } else {
      stop("Please check if you have cross-year individual file in the directory")
    }

    # Step1: Generate main data frame with selected variable ----
    # Including: ER30001, ER30002, fid, xsqnr, rel2hh, idvars
    psid_df <- temp_env$ind_df |>
      dplyr::select(all_of(na.omit(c("ER30001","ER30002", temp_env$key_tb$indfid, temp_env$key_tb$xsqnr, temp_env$key_tb$rel2hh, idvars)))) |>
      dplyr::mutate(pid = ER30001 * 1000 + ER30002) |>
      dplyr::select(-ER30001,-ER30002)

    # Remove those has read in the first step
    varlist_toread <- setdiff(varlist_toread, colnames(psid_df))

    # Step2: Read cross-year individual variables from ind_df file ----
    varlist_temp <- intersect(varlist_toread, colnames(temp_env$ind_df))
    temp_env$indcy_df <- temp_env$ind_df |>
      dplyr::select(all_of(c("ER30001","ER30002",varlist_temp))) |>
      dplyr::mutate(pid = ER30001 * 1000 + ER30002) |>
      dplyr::select(-ER30001,-ER30002)

    # Merge back
    psid_df <- psid_df |>
      dplyr::left_join(temp_env$indcy_df, by = "pid")

    # Clean the env for next round data read
    rm(list = setdiff(ls(envir = temp_env), "key_tb"), envir = temp_env)

    # Step3: Read family files (and wealth files if any) and merge back ----
    for (yr in str_df$year){

      # Get the vector of fid variables: Unlist and unname
      famfid_yr <- unname(unlist(temp_env$key_tb |> dplyr::filter(year == yr) |> dplyr::select(famfid)))
      indfid_yr <- unname(unlist(temp_env$key_tb |> dplyr::filter(year == yr) |> dplyr::select(indfid)))
      wlthid_yr <- unname(unlist(temp_env$key_tb |> dplyr::filter(year == yr) |> dplyr::select(wlthid)))

      # Varlist to read for this year
      list_varyear <- unname(unlist(str_df |> dplyr::filter(year == yr) |> dplyr::select(-year)))

      # Remove duplicated variables
      list_varyear <- setdiff(list_varyear[!is.na(list_varyear)], colnames(psid_df))

      # Read only when list of variables is not NULL
      if (length(list_varyear) > 0){

        if (is.na(wlthid_yr)){
          ## No additional wealth files ----
          # Read family files
          name_fam_df <- list.files(path = indir, pattern = paste(".*fam",yr,".*\\.rda",sep = ""))
          load(file = paste(indir,name_fam_df,sep="/"), envir = temp_env)
          matches <- ls(pattern = paste(".*fam",yr,".*",sep=""), envir = temp_env)

          # Fam data for read, rename as fam_df
          if (length(matches) > 0){
            temp_env$fam_df <- get(matches[1], envir = temp_env) |>
              dplyr::select(all_of(c(famfid_yr,list_varyear)))
            rm(list = matches[1], envir = temp_env)
          } else {
            stop("Please check if you have necessary family packaged file in the directory")
          }

        } else {
          ## With additional wealth files ----
          # Read family files
          name_fam_df <- list.files(path = indir, pattern = paste(".*fam",yr,".*\\.rda",sep = ""))
          load(file = paste(indir,name_fam_df,sep="/"), envir = temp_env)
          matches <- ls(pattern = paste(".*fam",yr,".*",sep=""), envir = temp_env)
          if (length(matches) > 0){
            temp_env$fam_df <- get(matches[1], envir = temp_env)
            rm(list = matches[1], envir = temp_env)
          } else {
            stop("Please check if you have necessary family packaged file in the directory")
          }

          # Read wealth files
          name_wlth_df <- list.files(path = indir, pattern = paste(".*wlth",yr,".*\\.rda",sep = ""))
          load(file = paste(indir,name_wlth_df,sep="/"), envir = temp_env)
          matches <- ls(pattern = paste(".*wlth",yr,".*",sep=""), envir = temp_env)
          if (length(matches) > 0){
            temp_env$wlth_df <- get(matches[1], envir = temp_env)
            rm(list = matches[1], envir = temp_env)
          } else {
            stop("Please check if you have necessary wealth packaged file in the directory")
          }

          # Merge using match key
          by_vector <- setNames(nm = famfid_yr, object = wlthid_yr)
          temp_env$fam_df <- temp_env$fam_df |>
            dplyr::left_join(temp_env$wlth_df, by = by_vector) |>
            dplyr::select(all_of(c(famfid_yr,list_varyear)))
        }

        # Read family variables of that year and merge back to the main dataset
        by_vector <- setNames(nm = indfid_yr, object = famfid_yr)
        psid_df <- psid_df |>
          dplyr::left_join(temp_env$fam_df, by = by_vector)

        # Clean the environment and print reminder
        rm(list = setdiff(ls(envir = temp_env), "key_tb"), envir = temp_env)
        message("Data for year ",yr," has been added!")

      } else {

        # Move on if length(list_varyear) is 0
        next(paste("No data for year ",yr," has been added!",sep=""))

      }

    }

    # Step4: Remove those non-response for all waves covered
    rowSums(psid_df[,temp_env$key_tb$indfid])
    psid_df <- psid_df[which(rowSums(psid_df[,temp_env$key_tb$indfid]) > 0),]

  } else if (type == "single"){
  # Single ----
    varlist_final <- union(varlist_toread, unname(unlist(temp_env$key_tb[,c("xsqnr","rel2hh","indfid")])))
    load(file = paste(indir,paste(sub("\\.zip$","",filename),".rda",sep=""), sep="/"), envir = temp_env)
    psid_df <- get(sub("\\.zip$","",filename), envir = temp_env) |>
      dplyr::select(all_of(na.omit(c("ER30001","ER30002",varlist_final,idvars)))) |>
      dplyr::mutate(pid = ER30001 * 1000 + ER30002) |>
      dplyr::select(-ER30001,-ER30002)

  } else {

    # Require to specify the type of input data
    stop("Please specify whether your PSID data is 'package' or 'single'!" )

  }
  return(psid_df)
}










