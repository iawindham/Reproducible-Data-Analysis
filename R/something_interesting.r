p <-ggplot(mtcars, aes(mpg, cyl)) + geom_point() + geom_smooth(method = "lm")
print(p)