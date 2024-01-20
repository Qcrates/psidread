
<!-- README.md is generated from README.Rmd. Please edit that file -->

# psidread

<!-- badges: start -->
<!-- badges: end -->

The goal of psidread is to provide a user-friendly approach to
streamline the management, creation, and formatting of panel data from
the Panel Study of Income Dynamics (PSID).

## Installation

Jan 16th Update: This package is now available on CRAN! You can install
it directly from CRAN with:

``` r
install.packages("psidread")
```

Or, you can install the development version of psidread from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Qcrates/psidread")
```

## Usage

### Overview

The [Panel Study of Income Dynamics](https://psidonline.isr.umich.edu/)
(PSID) is the longest running longitudinal household survey in the
world, which provides invaluable data covering numerous topics including
marriage, income, wealth, health and etc. However, the process of
converting raw PSID data files into datasets ready for analysis is quite
complex and challenging, especially for new users.

This package is developed with the purpose of addressing these
challenges within only R environment without additional assistance from
other statistical programming softwares. By bridging these gaps, the
package aims to make PSID datasets more usable and manageable for
researchers and analysts.

### Introduction

What `psidread` package is created to help:

- Create a table of data structure across multiple waves using the text
  that can be copied and pasted from the website

- Unzip and convert the zipped files without additional help of other
  software

- Read and merge the data files from multiple waves

- Rename and reshape the dataset to fit the need for advanced analysis

### Example Workflow

``` r
# Step 1: Create the table of data structure ----
psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017", " p_age || [13]ER34204")
str_df <- psid_str(varlist = psid_varlist, type = "separated")

# Step 2: Unzip and convert the ascii data ----
input_directory <- "your/input/directory"
output_directory <- "your/export/directory"
psid_unzip(indir = input_directory,
           exdir = output_directory,
           zipped = TRUE,
           type = "package",
           filename = NA)

# Step 3: Read and merge data ----
data_directory <- "your/folder/with/converted/data"
psid_df <- psid_read(indir = data_directory, str_df = str_df,idvars = c("ER30000"),type = "package",filename = NA)

# Step 4: Rename and reshape the data ----
df <- psid_reshape(psid_df = psid_df, str_df = str_df, shape = "long", level = "individual")
df
```

Please refer to the
[vignettes](https://cran.r-project.org/package=psidread/vignettes/my-vignette.html)
for the detailed instructions on how to build your own dataset from PSID
using this package.
