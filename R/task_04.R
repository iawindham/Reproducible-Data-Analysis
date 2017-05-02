#prints the number of rows in the dataframe "diamonds"
print(nrow(diamonds))
#sets RNG seed
set.seed(1410)
#creates the dataframe dsmall from 100 rows of diamonds.  
dsmall <- diamonds[sample(nrow(diamonds), 100),]
#A scatterplot of y vs x, colored by z values and faceted by cut
plot1 <-ggplot(dsmall, aes(x, y, color = z)) + geom_point() + facet_wrap(~cut)
#A scatterplot of price vs carat, colored by cut and smoothed (using the "lm" method, without standard error bars) 
plot2 <-ggplot(dsmall, aes(carat, price, color = cut)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
#A density plot of carat, faceted and colored by clarity
plot3 <-ggplot(dsmall, aes(carat, colour = clarity)) + geom_density()+ facet_wrap(~clarity)
#A boxplot of price as a function of cut
plot4 <-ggplot(dsmall, aes(cut, price)) + geom_boxplot()
#A scatterplot of y versus x. 
#The points should be red (colour = "red"), the color of the smoothing line should be blue (colour = "blue"), 
#and the line should be dashed with fat dashes (linetype=2). 
#The x and y labels should be set manually as well. 
plot5 <-ggplot(dsmall, aes(x, y, color = "red")) + geom_point() + geom_smooth(method = "lm", se = FALSE, linetype = 2, color = "blue") + xlab("x, in mm") + ylab("y, in mm")

##Uglyplot##
uglyplot<-ggplot(diamonds, aes(carat, x, colour = clarity)) +
    geom_boxplot()

print(uglyplot)
