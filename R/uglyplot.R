p<-ggplot(diamonds, aes(carat, x, colour = clarity)) +
    geom_boxplot()

print(p)
