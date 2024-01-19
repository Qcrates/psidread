#' @title Unzip and transfer the downloaded PSID data files
#' @description
#' This `psid_unzip()` function streamlines the process of transforming ASCII data downloaded from the PSID website to R data files (.rda).
#' @details
#' This function executes two primary operations:
#' - Unzip the zipped data files
#' - Converts the ASCII file into a `.rda` format for the reading steps
#'
#' For optimal functionality, please ensure that you have satisfied the following prerequisites:
#' - If you are using packaged data files, please do not make any changes to the name of the data files
#' - If you download the dataset with only selected variables, please choose `ASCII Data With SAS Statements` as the data output type
#'
#' The user will only need to execute this function once.
#' If you have already executed this function before and have all the `.rda` files settled down, you do not have to run this again.
#' This function may take several minutes if you have multiple packaged file to unzip and convert.
#'
#' @importFrom asciiSetupReader read_ascii_setup
#' @importFrom stringr str_match_all
#' @importFrom stringr str_detect
#' @importFrom utils unzip
#'
#' @param indir A string value of the directory path where the user store the downloaded data files.
#' @param exdir A string value of the directory path where the user wish to put the generated `.rda` files.
#' @param zipped  A logic value indicating whether the data files are zipped or not.
#' @param type A string value of either "package" or "single", indicating whether the data files are packaged data file or a single customized dataset with only selected variables.
#' @param filename A string value of the name of the single file. Default to be NA, but requires to be specified if the type is "single"
#' @returns `.rda` data files stored in the specified directory file folder
#' @export
#'
#' @examples
#' # Example 1: Unzip and convert packaged files
#' exdir <- tempdir()
#' indir <- system.file(package = "psidread","extdata") # Define the input directory
#' psid_unzip(indir = indir, exdir = exdir, zipped = TRUE, type = "package", filename = NA)
#' # Example 2: Unzip and convert customized single data files
#' exdir <- tempdir()
#' indir <- system.file(package = "psidread","extdata") # Define the output directory
#' filename = "J327825.zip"
#' psid_unzip(indir = indir, exdir = exdir, zipped = TRUE, type = "single", filename = filename)

psid_unzip <- function(indir, exdir, zipped = TRUE, type = "package", filename = NA){
  # Packaged data ----
  if (type == "package"){

    ## Step 1. Unzip the data files ----
    if (zipped == TRUE){

      # Capture the names of packaged data files with name like FAMYYYY(ER).zip or INDYYYY(ER).zip
      list_tozip <- list.files(path = indir, pattern = "^[a-zA-Z]+[0-9]{4}(er)?\\.zip$", ignore.case = TRUE)
      # Capture the file name without file extensions
      list_foldername <- unlist(sapply(stringr::str_match_all(string = list_tozip, pattern = "^([a-zA-Z]+[0-9]{4}(er)?)\\.zip$"), function(x) x[,2]))

      # Unzip the .zip files looply
      for (i in c(1: length(list_tozip))){

        # Unzip the .zip files
        utils::unzip(zipfile = file.path(indir, list_tozip[i]), exdir = file.path(indir, list_foldername[i]), overwrite = TRUE)

        # Text reminder
        message("File ", list_tozip[i], " has been unzipped!")

      }

      # Capture the names of the unzipped file folders
      list_unzipped <- list.files(path = indir, pattern = "^[a-zA-Z]+[0-9]{4}(er)?$")

    } else {

      # If the data files have already been manually unzipped by the user
      list_unzipped <- list.files(path = indir, pattern = "^[a-zA-Z]+[0-9]{4}(er)?$")

    }

    # PSID wrote the file names in capitalized letters
    list_unzipped_upper <- toupper(list_unzipped)

    ## Step 2. Read the ASCII data and convert to .rda ----
    for (i in c(1:length(list_unzipped))){

      # Read and convert the ASCII files into .rda files
      temp <- read_ascii_setup(data = file.path(indir, list_unzipped[i], paste0(list_unzipped_upper[i],".txt")),
                               setup_file = file.path(indir, list_unzipped[i], paste0(list_unzipped_upper[i],".sas")),
                               use_clean_names = FALSE)

      # Rename the dataset
      assign(list_unzipped[i],temp)

      # Save the .rda files to the directory (exdir)
      save(list = list_unzipped[i], file = paste(paste(exdir, list_unzipped[i], sep = "/"), ".rda", sep = ""))

      # Text reminder
      message("Data file ", list_unzipped[i], ".rda has been created successfully!")

      # Clean the environment
      rm(temp, list = list_unzipped[i])

    }

  } else if (type == "single"){
    # Customized single dataset ----

    if (is.na(filename)){

      # Compulsorily requires file name if type = 'single'
      stop("Please specify the name of your single data file!")

    } else {

      ## Step 1. Unzip ----
      if (zipped == TRUE){

        if (str_detect(filename, pattern = "\\.zip") == FALSE){

          # Requires .zip file input in filename
          stop("Your specified file is not a .zip file")

        } else {

          # Unzip and print reminder
          utils::unzip(zipfile = file.path(indir, filename), exdir = file.path(indir, sub("\\.zip$","",filename)), overwrite = TRUE)
          message("File ", filename, " has been unzipped!")

          # Remove the file extension
          filename <- sub("\\.zip$","",filename)

        }
      } else {

        filename <- filename

      }

      filename_upper <- toupper(filename)

      ## Step 2. Read the ASCII and convert ----
      temp <- read_ascii_setup(data = file.path(indir, filename, paste0(filename_upper, ".txt")),
                               setup_file = file.path(indir, filename, paste0(filename_upper, ".sas")),
                               use_clean_names = FALSE)
      assign(filename,temp)
      save(list = filename, file = paste(paste(exdir, filename, sep = "/"), ".rda", sep = ""))
      message("Data file ", filename, ".rda has been created successfully!")
      rm(temp, list = filename)

    }
  } else {

    # type argument is required
    stop("Please specify whether the type of your PSID data is 'package' or 'single'!")

  }

}



