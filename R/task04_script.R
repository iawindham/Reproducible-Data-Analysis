#prints the number of rows in the dataframe "diamonds"
print(nrow(diamonds))
#sets RNG seed
set.seed(1410)
#creates the dataframe dsmall from 100 rows of diamonds.  
dsmall <- diamonds[sample(nrow(diamonds), 100),]
plot1 <-ggplot(dsmall, aes(x, y, color = z)) + geom_point() + facet_wrap(~cut)
plot2 <-ggplot(dsmall, aes(carat, price, color = cut)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
plot3 <-ggplot(dsmall, aes(carat, colour = clarity)) + geom_density()+ facet_wrap(~clarity)
plot4 <-ggplot(dsmall, aes(cut, price)) + geom_boxplot()
plot5 <-ggplot(dsmall, aes(x, y, color = "red")) + geom_point() + geom_smooth(method = "lm", se = FALSE, linetype = 2, color = "blue") + xlab("x, in mm") + ylab("y, in mm")
