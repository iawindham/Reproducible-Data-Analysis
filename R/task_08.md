Part 1
------

### Instructions

Write a function that fulfills the following criteria:

1.  It should be tidyverse compatible (i.e., the first argument must be a data frame)

2.  It should add two arbitrary columns of the data frame (specified by the user) and put them in a new column of that data frame, with the name of the new column specified by the user
3.  It should throw an informative warning if any invalid arguments are provided. Invalid arguments might include:

<!-- -->

1.  The first argument is not a data frame
2.  Less than two valid columns are specified to add (e.g., one or both of the column names isn't in the supplied data frame)
3.  The columns specified are not numeric, and therefore can't be added - use tryCatch() for this

<!-- -->

1.  If the columns to add aren't valid but the new column name is, the function should create a column of NA values

### Code

Here, I define the function df\_summer that meets the above criteria (see comments below).

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(lazyeval)
```

    ## 
    ## Attaching package: 'lazyeval'

    ## The following objects are masked from 'package:purrr':
    ## 
    ##     is_atomic, is_formula

``` r
#df_summer is a function that will add two columns in a given data frame and add this new column to the data frame with a user given name
df_summer <- function(df, col1, col2, title) {
  #The function will stop if the argument df is not a data frame.
  if (is.data.frame(df) != TRUE) {
    stop("Stop: Argument is not a data frame.")
  #A warning will be issued if two columns have not been specified in the function call
} else if ((col1 %in% colnames(df)) != TRUE | (col2 %in% colnames(df)) != TRUE) {
    warning("Warning: You have not specified two columns to add")
  } 
  tryCatch (
    {
    #Must utilize standard evaluation if dplyr is required
      
    #Must use as.name() and interp (from the lazyeval package) because col1 and col2 will be character strings
    #col1 and col2 are added
     summer_return <- interp(~ a + b, a = as.name(col1), b = as.name(col2))
    #Sum of col1 and col2 are added to df as new column named from 'title' argument
     df %>% mutate_(.dots = setNames(list(summer_return), title))
    },
  #Checks if both of the specified columns are numeric vectors
  warning = if(is.numeric(df[[col1]]) != TRUE | is.numeric(df[[col2]]) != TRUE){
    #If not numeric, then the function will create a new column in df of null values, named from 'title' argument 
    message("One or both columns is not numeric")
     summer_na <- df %>%
       mutate_(.dots = setNames(list(NA), title))
     return(summer_na)
    }  
  )
}
```

The following tests show that df\_summer meets the above criteria

``` r
#this test would cause the code to stop, so I commented it out

#nodf_test <- df_summer('a', 'mpg', 'qsec', 'new_column')
```

``` r
toofewcolumns_test<- df_summer(mtcars, 'mpg', 'notacolumn', 'new_column')
```

    ## Warning in df_summer(mtcars, "mpg", "notacolumn", "new_column"): Warning:
    ## You have not specified two columns to add

    ## One or both columns is not numeric

``` r
#creates a new version of mtcars with a column consisting of the row names, called 'names'
names_mtcars <- mutate(mtcars, names = rownames(mtcars))
nonnumericcolumnstest <- df_summer(names_mtcars, 'mpg', 'names', 'new_column' )
```

    ## One or both columns is not numeric

``` r
correct_test <- df_summer(mtcars, "mpg", "qsec", "new_column")
correct_test
```

    ##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb new_column
    ## 1  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4      37.46
    ## 2  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4      38.02
    ## 3  22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1      41.41
    ## 4  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1      40.84
    ## 5  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2      35.72
    ## 6  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1      38.32
    ## 7  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4      30.14
    ## 8  24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2      44.40
    ## 9  22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2      45.70
    ## 10 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4      37.50
    ## 11 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4      36.70
    ## 12 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3      33.80
    ## 13 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3      34.90
    ## 14 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3      33.20
    ## 15 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4      28.38
    ## 16 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4      28.22
    ## 17 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4      32.12
    ## 18 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1      51.87
    ## 19 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2      48.92
    ## 20 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1      53.80
    ## 21 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1      41.51
    ## 22 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2      32.37
    ## 23 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2      32.50
    ## 24 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4      28.71
    ## 25 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2      36.25
    ## 26 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1      46.20
    ## 27 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2      42.70
    ## 28 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2      47.30
    ## 29 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4      30.30
    ## 30 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6      35.20
    ## 31 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8      29.60
    ## 32 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2      40.00

new\_column is the sum of mpg and qsec.

Part 2
------

### Instructions

Write a function named that uses a for loop to calculate the sum of the elements of a vector, which is passed as an argument (i.e., it should do the same thing that sum() does with vectors). your\_fun(1:10^4) should return 50005000.

### Code

The function bad\_summer uses a for loop to calculate the sum of the elements test\_vector 1:10^4.

``` r
test_vector <- c(1:10^4)

bad_summer <- function(vec) {
  #begin counter at 0
  sum_output <- 0
  #Each value of the vector is added to the previous sum, producing a new sum
  for (i in vec) {
    sum_output = sum_output + vec[[i]]
  }
  return(sum_output)
}
bad_summer(test_vector)
```

    ## [1] 50005000

``` r
sum(test_vector) == bad_summer(test_vector) 
```

    ## [1] TRUE

Use the microbenchmark::microbenchmark function to compare the performace of your function to that of sum in adding up the elements of the vector 1:10^4.

``` r
library(microbenchmark)
#compares speed of the previously defined bad_summer function and sum() from base R
microbenchmark(
  bad_summer(test_vector), 
  sum(test_vector))
```

    ## Unit: microseconds
    ##                     expr     min       lq     mean   median       uq
    ##  bad_summer(test_vector) 596.346 654.9055 660.3750 659.9915 673.2145
    ##         sum(test_vector)  11.625  11.9170  12.7064  12.7880  13.0780
    ##      max neval
    ##  716.662   100
    ##   17.437   100

Microbenchmark compares the time taken to evaluate the two given expressions. bad\_summer() took ~642 microseconds to do the same operation that sum() completed in ~12. Using for loops to calculate sums is much slower and more cumbersome than simply using the base R functions, which have been designed to run at an optimal speed.
