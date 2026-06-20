# psidread 1.0.7

- Fixed a bug in `psid_read()` where including 1968 variables caused a join failure because `ER30001` was dropped before being used as a join key for the 1968 family file merge.

- Fixed a bug in `psid_reshape()` where the rename step crashed when `ER30001` was absent from the data frame after `psid_read()` processing.

# psidread 1.0.6

- Fixed minor issue on regular expression in `psid_str()` for variables names in earlier waves. Thanks Jiao G. for pointing this out!

# psidread 1.0.5

- Explicitly declared R (\>= 4.1.0) as a dependency due to use of native pipe and anonymous functions.
- No changes in functionality.

# psidread 1.0.4

- Minor maintenance update: added merge key for 2023 waves

# psidread 1.0.3

# psidread 1.0.2

# psidread 1.0.1

# psidread 1.0.0

# psidread 1.0.0 (2024-01-01)

- Initial CRAN submission.
