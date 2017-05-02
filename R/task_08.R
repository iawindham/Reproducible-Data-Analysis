####Part 1####
library(tidyverse)
library(lazyeval)

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
nodf_test <- df_summer('a', 'mpg', 'qsec', 'new_column')

toofewcolumns_test<- df_summer(mtcars, 'mpg', 'notacolumn', 'new_column')

names_mtcars <- mutate(mtcars, names = rownames(mtcars))
nonnumericcolumnstest <- df_summer(names_mtcars, 'mpg', 'names', 'new_column' )

correct_test <- df_summer(mtcars, "mpg", "qsec", "new_column")

#####Part 2####
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

library(microbenchmark)
#compares speed of the previously defined bad_summer function and sum() from base R
microbenchmark(
  bad_summer(test_vector), 
  sum(test_vector))
