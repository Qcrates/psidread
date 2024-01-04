
<!-- README.md is generated from README.Rmd. Please edit that file -->

# psidread

<!-- badges: start -->
<!-- badges: end -->

The goal of psidread is to provide a user-friendly approach to
streamline the management, creation, and formatting of panel data from
the Panel Study of Income Dynamics (PSID).

## Installation

You can install the development version of psidread from
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
psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017", " p_age || [13]ER34204")
str_df <- psid_str(varlist = psid_varlist, type = "separated")
input_directory <- "/Users/RachelChiu/Documents/ReProj/PSID/psidread/inst/extdata"
psid_df <- psid_read(indir = input_directory, str_df = str_df,idvars = c("ER30000"),type = "package",filename = NA)
str(psid_df)
```

Please refer to the vignettes for the detailed instructions on how to
build your own dataset from PSID using this package: [psidread user
manual](vignettes/my-vignette.html) (GitHub does not show the html file
directly. Download and open the file in the web browser.)
