#2.3.1.1
#> vec <- c(1, 3, 4, 5, 7)
#> dim(vec)
#NULL
#Vectors are inherently dimensionless until dimensions are set.
#When dimensions are set using dim(), the the vector will become an array.
#2.4.5.1
#Data frames have
#names, or colnames
#rownames
#class (int, char, etc)
#and individual variable labels
#2.4.5.2
#> df2
#  x y
#1 1 a
2 2 b
3 3 c
> as.matrix(df2)
     x   y  
[1,] "1" "a"
[2,] "2" "b"
[3,] "3" "c"

All of the variables are coerced to the same data type(matrices must be homogeneous)
2.4.5.3
 empty <- data.frame()
> empty
data frame with 0 columns and 0 rows
Can have a data frame with no rows or columns
Cannot add a column to an empty data frame, as a new column must match the length 
of previously added columns
> col<-cbind(empty, data.frame(x = 1))
Error in data.frame(..., check.names = FALSE) : 
  arguments imply differing number of rows: 0, 1
Adding a row to an empty data frame adds both a row and a column.
> row<-rbind(empty, data.frame(x=1))
> row
  x
1 1
> nrow(row)
[1] 1
> ncol

Well plate data
The file is a data frame, with 94 observations of three variables.

Column one is a factor with 94 levels
COlumn two is a numeric vector
Column three is an integer vector
After installing tidyverse, nothing seems to be different (???)

The length of a data frame is the number of columns in the data frame, as 
supposed to in a matrix where it is rows + columns.
This is because a data.frame is a list of vectors.

> cylinders <- mtcars$cyl
> cylinders
 [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8
[18] 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
> is.atomic(cylinders)
[1] TRUE
> cylinder2 <- mtcars[,2]
> cylinder2
 [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
> class(cylinder2)
[1] "numeric"


> newmtcars <- data.frame( mpg = mtcars$mpg, wt = mtcars$wt, row.names = rownames(mtcars))
> newmtcars
                     mpg    wt
Mazda RX4           21.0 2.620
Mazda RX4 Wag       21.0 2.875
Datsun 710          22.8 2.320
Hornet 4 Drive      21.4 3.215
Hornet Sportabout   18.7 3.440
Valiant             18.1 3.460
Duster 360          14.3 3.570
Merc 240D           24.4 3.190
Merc 230            22.8 3.150
Merc 280            19.2 3.440
Merc 280C           17.8 3.440
Merc 450SE          16.4 4.070
Merc 450SL          17.3 3.730
Merc 450SLC         15.2 3.780
Cadillac Fleetwood  10.4 5.250
Lincoln Continental 10.4 5.424
Chrysler Imperial   14.7 5.345
Fiat 128            32.4 2.200
Honda Civic         30.4 1.615
Toyota Corolla      33.9 1.835
Toyota Corona       21.5 2.465
Dodge Challenger    15.5 3.520
AMC Javelin         15.2 3.435
Camaro Z28          13.3 3.840
Pontiac Firebird    19.2 3.845
Fiat X1-9           27.3 1.935
Porsche 914-2       26.0 2.140
Lotus Europa        30.4 1.513
Ford Pantera L      15.8 3.170
Ferrari Dino        19.7 2.770
Maserati Bora       15.0 3.570
Volvo 142E          21.4 2.780


